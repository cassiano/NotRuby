# Represents an Awesome object instance in the Ruby world.
class RObject
  attr_accessor :runtime_class
  attr_reader   :ruby_value

  # Each object have a class (named runtime_class to prevent errors with Ruby's class
  # method). Optionaly an object can hold a Ruby value (eg.: numbers and strings).
  def initialize(runtime_class, ruby_value = self)
    @runtime_class  = runtime_class
    @ruby_value     = ruby_value
  end

  # Call a method on the object.
  def call(method, arguments = [])
    # Like a typical Class-based runtime model, we store methods in the class of the
    # object.
    if (called_method = @runtime_class.lookup(method))
      called_method.call self, arguments
    else
      self.call 'method_missing', [method] + arguments
    end
  end
  
  # Returns the object's singleton class, creating it if needed.
  def singleton_class(parent = runtime_class)
    self.runtime_class = RClass.new("<Anonymous singleton class for object '#{respond_to?(:name) ? name : object_id}'>", parent, true) unless runtime_class.is_ghost
    
    runtime_class    
  end

  def extend_modules(modules)
    modules.each do |mOdule|    # Given 'module' is a reserved word in Ruby, we will use 'mOdule' instead.
      ghost_singleton                   = RClass.new("<Anonymous class for object '#{respond_to?(:name) ? name : object_id}' and module '#{mOdule.name}'>", singleton_class.parent, true)
      ghost_singleton.associated_module = mOdule
      singleton_class.parent            = ghost_singleton
    end
  end
end
