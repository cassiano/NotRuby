require 'runtime/object'
require 'runtime/class'
require 'runtime/method'
require 'runtime/context'

# Bootstrap the runtime. This is where we assemble all the classes and objects together
# to form the runtime.

                                                    # What happens in the runtime:
rclass                      = RClass.new('Class')   # Class
rclass.runtime_class        = rclass                # Class.class = Class
object_class                = RClass.new('Object')  # Object = Class.new
object_class.runtime_class  = rclass                # Object.class = Class
object_class.parent         = object_class          # Object.superclass = Object
rclass.parent               = object_class          # Class.superclass = Object

Runtime = Context.new(object_class.new) # Object.new

Runtime['Class']      = rclass
Runtime['Object']     = object_class
Runtime['Number']     = RClass.new('Number')
Runtime['String']     = RClass.new('String')
Runtime['TrueClass']  = RClass.new('TrueClass')
Runtime['FalseClass'] = RClass.new('FalseClass')
Runtime['NilClass']   = RClass.new('NilClass')

Runtime['true']   = Runtime['TrueClass'].new_with_value(true)
Runtime['false']  = Runtime['FalseClass'].new_with_value(false)
Runtime['nil']    = Runtime['NilClass'].new_with_value(nil)

# Object.new
Runtime['Class'].runtime_methods = {
  :new => proc do |receiver, arguments|
            receiver.new
          end,
          
  :name =>  proc do |receiver, arguments|
              receiver.name
            end,

  :include => proc do |receiver, arguments|
                receiver.include_modules arguments
              end,

  :superclass => proc do |receiver, arguments|
                  cls = receiver.parent
                  cls = cls.parent while cls.is_ghost
                  cls
                end,

  :ancestors => proc do |receiver, arguments|
                  current         = receiver
                  ancestors       = [receiver]
                  include_ghosts  = !!arguments[0]
  
                  while (current = current.parent)
                    break if ancestors.include?(current)    # Avoid an endless loop.
                    next if current.is_ghost && !include_ghosts
                    ancestors << current
                  end
  
                  ancestors
                end,

  :instance_methods =>  proc do |receiver, arguments|
                          include_ancestors = !arguments[0].nil? ? arguments[0].ruby_value : true
                          instance_methods = receiver.runtime_methods.map { |k, v| k }
                          instance_methods += receiver.parent.call(:instance_methods, arguments) if include_ancestors and receiver.parent != receiver
                          instance_methods
                        end
}

Runtime['Object'].runtime_methods = {
  :extend =>  proc do |receiver, arguments|
                receiver.extend_modules arguments
              end,

  :methods => proc do |receiver, arguments|
                receiver.runtime_class.call(:instance_methods, arguments)
              end,

  :klass => proc do |receiver, arguments|
              cls = receiver.runtime_class
              cls = cls.runtime_class while cls.is_ghost
              cls
            end,

  :singleton_class => proc do |receiver, arguments|
                        receiver.singleton_class
                      end,

  # Default :method_missing implementation.
  :method_missing =>  proc do |receiver, arguments|
                        raise "NoMethodError: undefined method '#{arguments[0]}' for #{receiver.respond_to?(:name) ? receiver.name : (receiver.ruby_value || 'nil')}:#{Runtime['Object'].runtime_methods[:klass].call(receiver).name}"
                      end,

  # print('hi')
  :print => proc do |receiver, arguments|
              puts arguments.first.ruby_value
              Runtime['nil']
            end
}

Runtime['Number'].runtime_methods = {
  # 1 + 2
  # 1.+(2)
  :+ => proc do |receiver, arguments|
          a = receiver.ruby_value
          b = arguments.first.ruby_value
          Runtime['Number'].new_with_value a + b
        end,

  # 1 < 2
  # 1.<(2)
  :< => proc do |receiver, arguments|
          a = receiver.ruby_value
          b = arguments.first.ruby_value
          a < b ? Runtime['true'] : Runtime['false']
        end,
        
  # Overriden :method_missing sample implementation.
  :method_missing =>  proc do |receiver, arguments|
                        puts "Overriden method_missing for class Number called with parameters: #{arguments.map { |a| a.respond_to?(:ruby_value) ? a.ruby_value : a }.join(', ')}"
                      end
}
