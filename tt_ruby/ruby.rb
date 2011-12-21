require 'polyglot'
require 'treetop'
require 'ruby-debug'

class NumberNode < Treetop::Runtime::SyntaxNode
  def eval(context)
    text_value.to_i
  end
end

class StringNode < Treetop::Runtime::SyntaxNode
  def eval(context)
    text_value[1..-2]
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
    context.locals[identifier.eval(context)] = expression.eval(context)
  end
end

class IdentifierNode < Treetop::Runtime::SyntaxNode
  def eval(context)
    text_value.to_sym
  end
end

class ParamListNode < Treetop::Runtime::SyntaxNode
  def eval(context)
    [expression.eval(context)] + others.elements.map { |e| e.expression.eval(context) }
  end
end

class CallNode < Treetop::Runtime::SyntaxNode
  # receiver:(identifier '.')? method:identifier param_list?  <CallNode>
  def eval(context)
    # debugger
    evaluated_receiver  = receiver.identifier.eval(context) if receiver.respond_to?(:identifier)
    evaluated_method    = method.eval(context)
    
    if !evaluated_receiver && !params.instance_of?(ParamListNode) && context.locals.has_key?(evaluated_method)
      # Local variable.
      context.locals[evaluated_method]
    else
      # Method call.
      object          = evaluated_receiver || context.current_self
      evaluated_parms = params.eval(context) rescue []
      
      raise "No way (yet) to call method '#{evaluated_method}' on object '#{object}' with parameters [#{evaluated_parms.join(', ')}]"
    end
  end
end

Treetop.load 'ruby'

Context   = Struct.new(:current_self, :current_class, :locals, :constants)
@context  = Context.new(self, self.class, {}, {})
@parser   = RubyParser.new