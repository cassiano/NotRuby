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
  def call(method_name, arguments = [], initial_class = runtime_class)
    # Like a typical Class-based runtime model, we store methods in the class of the object.
    if (method = initial_class.lookup(method_name.to_sym))
      method.call self, arguments, initial_class
    else
      self.call :method_missing, [method_name] + arguments, initial_class
    end
  end
  
  # Returns the object's singleton class, creating it if needed.
  def singleton_class(parent = runtime_class)
    class_name          = "<Anonymous singleton class for object '#{to_s}'>"
    self.runtime_class  = RClass.new(class_name, :parent => parent, :is_ghost => true) unless runtime_class.is_ghost
    
    runtime_class    
  end

  def extend_modules(modules)
    modules.each do |mOdule|    # Given 'module' is a reserved word in Ruby, we will use 'mOdule' instead.
      class_name                        = "<Anonymous class for object '#{to_s}' and module '#{mOdule.to_s}'>"
      ghost_singleton                   = RClass.new(class_name, :parent => singleton_class.parent, :is_ghost => true)
      ghost_singleton.associated_module = mOdule
      singleton_class.parent            = ghost_singleton
    end
  end
  
  def to_s
    ruby_value || object_id
  end

  def default_method_missing(name, args)
    raise "NoMethodError: undefined method '#{name}' for #{to_s}:#{call(:klass).name}"
  end
end
