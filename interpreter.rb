require 'parser'
require 'runtime'

class Interpreter
  def initialize
    @parser = Parser.new
  end
  
  def eval(code)
    @parser.parse(code).eval(Runtime)
  end
end

class Nodes
  # This method is the 'interpreter' part of our language. All nodes know how to eval 
  # itself and returns the result of its evaluation by implementing the 'eval' method.
  # The 'context' variable is the environment in which the node is evaluated (local
  # variables, current class, etc.).
  def eval(context)
    return_value = nil

    nodes.each do |node|
      return_value = node.eval(context)
    end

    return_value || Runtime[:nil] 
  end
end

class NumberNode
  def eval(context)
    Runtime[:Number].new_with_value(value)
  end
end

class StringNode
  def eval(context)
    Runtime[:String].new_with_value(value)
  end
end

class TrueNode
  def eval(context)
    Runtime[:true] 
  end
end

class FalseNode
  def eval(context)
    Runtime[:false] 
  end
end

class NilNode
  def eval(context)
    Runtime[:nil] 
  end
end

class AssignNode
  def eval(context)
    context.locals[name] = value.eval(context)
  end
end

class ConstantNode
  def eval(context)
    context[name] || raise("NameError: uninitialized constant #{name}")
  end
end

class CallNode
  def eval(context)
    # a
    if receiver.nil? && context.locals[method_name] && arguments.empty?
      # Local variable
      context.locals[method_name]
    # Method call
    else
      # object.print or [self.]print ?
      object = receiver ? receiver.eval(context) : context.current_self
      
      evaluated_arguments = arguments.map { |arg| arg.eval(context) }

      object.call method_name, evaluated_arguments
    end
  end
end

class DefNode
  def eval(context)
    method = RMethod.new(name.to_sym, params, body)
    
    # Is it a singleton method?
    klass = object ?
      (receiver = String === object ? context.locals[object] : object.eval(context)) && receiver.singleton_class :
      context.current_class
    
    klass.runtime_methods[name.to_sym] = method
    
    Runtime[:nil] 
  end
end

class ClassNode
  def eval(context)
    unless (rclass = context[name]) # class was not defined
      evaluated_parent  = parent && parent.eval(context)
      rclass            = evaluated_parent ? 
                            RClass.new(name, :parent => evaluated_parent) : 
                            RClass.new(name)
      context[name]     = rclass
    end
    
    body.eval Context.new(rclass, rclass)
  end
end

class ModuleNode
  def eval(context)
    unless (rmodule = context[name]) # module was not defined
      rmodule       = RClass.new(name, :is_module => true)
      context[name] = rmodule
    end
    
    body.eval Context.new(rmodule, rmodule)
    
    Runtime[:nil] 
  end
end

class IfNode
  def eval(context)
    if condition.eval(context).ruby_value
      body.eval context
    elsif else_body
      else_body.eval context
    else
      Runtime[:nil] 
    end
  end
end

class WhileNode
  def eval(context)
    while condition.eval(context).ruby_value
      body.eval context
    end
    
    Runtime[:nil] 
  end
end

class SelfNode
  def eval(context)
    context.current_self
  end
end

class SuperNode
  def eval(context)
    raise('Invalid use of super (no method currently in execution)') unless context.current_method_and_arguments
    raise('Infinite recursion detected (super would call itself)') if context.current_class == context.current_class.parent

    if arguments.empty?
      context.current_self.call *context.current_method_and_arguments, context.current_class.parent
    else
      evaluated_arguments = arguments.map { |arg| arg.eval(context) }
      
      context.current_self.call context.current_method_and_arguments[0], evaluated_arguments, context.current_class.parent
    end
  end
end

class SingletonClassOperatorNode
  def eval(context)
    evaluated_object  = object.eval(context)
    singleton_class   = evaluated_object.singleton_class
    
    body.eval Context.new(singleton_class, singleton_class)
  end
end
