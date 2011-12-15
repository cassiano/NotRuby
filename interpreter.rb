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

    return_value || Runtime['nil']
  end
end

class NumberNode
  def eval(context)
    Runtime['Number'].new_with_value(value)
  end
end

class StringNode
  def eval(context)
    Runtime['String'].new_with_value(value)
  end
end

class TrueNode
  def eval(context)
    Runtime['true']
  end
end

class FalseNode
  def eval(context)
    Runtime['false']
  end
end

class NilNode
  def eval(context)
    Runtime['nil']
  end
end

class AssignNode
  def eval(context)
    context.locals[name] = value.eval(context)
  end
end

class ConstantNode
  def eval(context)
    context[name] || raise("Constant not found #{name}")
  end
end

class CallNode
  def eval(context)
    # a
    if receiver.nil? && context.locals[method] && arguments.empty?
      # Local variable
      context.locals[method]
    # Method call
    else
      # object.print
      if receiver
        value = receiver.eval(context)
      else
        # [self.]print
        value = context.current_self
      end
      
      evaluated_arguments = arguments.map { |arg| arg.eval(context) }

      value.call method, evaluated_arguments
    end
  end
end

class DefNode
  def eval(context)
    method = RMethod.new(params, body)
    
    # Is it a singleton method?
    klass = object ?
      (receiver = String === object ? context.locals[object] : object.eval(context)) && receiver.singleton_class :
      context.current_class
    
    klass.runtime_methods[name.to_sym] = method
  end
end

class ClassNode
  def eval(context)
    unless (rclass = context[name]) # class was not defined
      evaluated_parent  = parent && parent.eval(context)
      rclass            = evaluated_parent ? RClass.new(name, :parent => evaluated_parent) : RClass.new(name)
      context[name]     = rclass
    end
    
    class_context = Context.new(rclass, rclass)
    
    body.eval(class_context)
    
    rclass
  end
end

class ModuleNode
  def eval(context)
    unless (rmodule = context[name]) # module was not defined
      rmodule       = RClass.new(name, :is_module => true)
      context[name] = rmodule
    end
    
    module_context = Context.new(rmodule, rmodule)
    
    body.eval(module_context)
    
    rmodule
  end
end

class IfNode
  def eval(context)
    ### Exercise
    # Here you have access to:
    #  condition: condition node that will determine if the body should be executed
    #       body: node to be executed if the condition is true
    #  else_body: node to be executed if the condition is false
    if condition.eval(context).ruby_value
      body.eval(context)
    elsif else_body
      else_body.eval(context)
    else
      Runtime['nil']
    end
  end
end

class WhileNode
  def eval(context)
    while condition.eval(context).ruby_value
      body.eval(context)
    end
    Runtime['nil']
  end
end