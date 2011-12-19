# Represents a class in the Ruby world. Classes are objects in runtime so they
# inherit from RObject.
class RClass < RObject
  attr_reader   :name, :is_ghost
  attr_accessor :parent, :associated_module

  # Creates a new class. Number is an instance of Class for example.
  def initialize(name, options = {})
    runtime = defined?(Runtime) ? Runtime : {}
    
    options = {
      :parent     => runtime['Object'], 
      :is_ghost   => false, 
      :is_module  => false
    }.update(options)
    
    @name             = name
    @runtime_methods  = {}
    @parent           = options[:parent]
    @is_ghost         = options[:is_ghost]
    @is_module        = options[:is_module]
  
    # Check if we're bootstrapping (launching the runtime). During this process the 
    # runtime is not fully initialized and core classes do not yet exists, so we defer 
    # using those once the language is bootstrapped.
    # This solves the chicken-or-the-egg problem with the Class class. We can 
    # initialize Class then set Class.class = Class.
    runtime_class = runtime['Class']
  
    super runtime_class
    
    # Create the ghost class (if not already a ghost), deriving it from the ghost class of the current class's parent.
    # This will allow for the inheritance of the so called "class" methods.
    singleton_class(options[:parent].singleton_class) if !options[:is_ghost] && runtime_class
  end

  # Lookup a method
  def lookup(method_name)
    runtime_methods[method_name.to_sym] || (parent && parent != self ? parent.lookup(method_name) : nil)
  end

  # Create a new instance of this class
  def new
    raise('Sorry, modules cannot be instantiated!') if @is_module
    
    RObject.new self
  end
  
  # Create an instance of this class that holds a Ruby value. Like a String, 
  # Number or true.
  def new_with_value(value)
    RObject.new self, value
  end
  
  def has_associated_module?
    !!associated_module
  end
  
  def runtime_methods
    is_ghost && has_associated_module? ? associated_module.runtime_methods : @runtime_methods
  end

  def include_modules(modules)
    modules.each do |mOdule|    # Given 'module' is a reserved word in Ruby, we will use 'mOdule' instead.
      class_name                      = "<Anonymous parent class for class '#{to_s}' and module '#{mOdule.to_s}'>"
      ghost_parent                    = RClass.new(class_name, :parent => parent, :is_ghost => true)
      ghost_parent.associated_module  = mOdule
      self.parent                     = ghost_parent
    end
    
    self
  end

  def to_s
    name
  end
end
