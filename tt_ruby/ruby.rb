require 'polyglot'
require 'treetop'
require 'ruby-debug'
require '../runtime'

class NumberNode < Treetop::Runtime::SyntaxNode
  def eval(context)
    context[:Number].new_with_value text_value.to_i
  end
end

class StringNode < Treetop::Runtime::SyntaxNode
  def eval(context)
    context[:String].new_with_value text_value[1..-2]
  end
end

class TrueNode < Treetop::Runtime::SyntaxNode
  def eval(context)
    true
  end
end

class FalseNode < Treetop::Runtime::SyntaxNode
  def eval(context)
    false
  end
end

class NilNode < Treetop::Runtime::SyntaxNode
  def eval(context)
    nil
  end
end

class SelfNode < Treetop::Runtime::SyntaxNode
  def eval(context)
    context.current_self
  end
end

class ExpressionsNode < Treetop::Runtime::SyntaxNode
  def eval(context)
    others.elements.inject(expression.eval(context)) { |memo, e| e.expression.eval(context) }
  end
end

class AssignmentNode < Treetop::Runtime::SyntaxNode
  def eval(context)
    context.locals[identifier.name] = expression.eval(context)
  end
end

class IdentifierNode < Treetop::Runtime::SyntaxNode
  def eval(context)
    context.locals[name]
  end
end

class ConstantNode < Treetop::Runtime::SyntaxNode
  def eval(context)
    context[name] || raise("NameError: uninitialized constant #{name}")
  end
end

class ParamListNode < Treetop::Runtime::SyntaxNode
  def eval(context)
    unless optional_params.empty?
      ([optional_params] + optional_params.others.elements).map { |e| e.expression.eval(context) }
    else
      []
    end
  end
end

class CallNode < Treetop::Runtime::SyntaxNode
  def eval(context)
    if !receiver && params.empty? && context.locals.has_key?(method.name)
      # Local variable.
      context.locals[method.name]
    else
      # Method call.
      object          = receiver ? receiver.eval(context) : context.current_self
      evaluated_parms = !params.empty? ? params.eval(context) : []
      
      object.call method.name, evaluated_parms
    end
  end
end

class ClassNode < Treetop::Runtime::SyntaxNode
  def eval(context)
    unless (rclass = context[name])   # Class was not defined.
      evaluated_parent  = parent && parent.eval(context)
      rclass            = evaluated_parent ? 
                            RClass.new(name, :parent => evaluated_parent) : 
                            RClass.new(name)
      context[name]     = rclass
    end
    
    body.eval Context.new(rclass, rclass)
  end
end

class DefNode < Treetop::Runtime::SyntaxNode
  def eval(context)
    context.current_class.runtime_methods[name] = RMethod.new(name, params, body)
    
    Runtime[:nil] 
  end
end

class OperatorCallNode < Treetop::Runtime::SyntaxNode
  def eval(context)
    operations.elements.inject(left.eval(context)) do |memo, e|
      memo.call(e.operator.name, [e.right.eval(context)])
    end
  end
end

Treetop.load 'ruby'

# Context   = Struct.new(:current_self, :current_class, :locals, :constants)
# @context  = Context.new(self, self.class, {}, {})
@parser   = RubyParser.new
