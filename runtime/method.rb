# Represents a method defined in the runtime.
class RMethod
  def initialize(name, params, body)
    @name   = name
    @params = params
    @body   = body
  end
  
  def call(receiver, arguments, klass = nil)
    # Create a context of evaluation in which the method will execute.
    context = Context.new(*[receiver, klass].compact)
    context.current_method_and_arguments = [@name, arguments]
    
    # Assign arguments to local variables
    @params.each_with_index do |param, index|
      context.locals[param] = arguments[index]
    end
    
    @body.eval context
  end
end
