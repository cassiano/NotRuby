require "runtime/object"
require "runtime/class"
require "runtime/method"
require "runtime/context"

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

Runtime["Class"]      = rclass
Runtime["Object"]     = object_class
Runtime["Number"]     = RClass.new('Number')
Runtime["String"]     = RClass.new('String')
Runtime["TrueClass"]  = RClass.new('TrueClass')
Runtime["FalseClass"] = RClass.new('FalseClass')
Runtime["NilClass"]   = RClass.new('NilClass')

Runtime["true"]   = Runtime["TrueClass"].new_with_value(true)
Runtime["false"]  = Runtime["FalseClass"].new_with_value(false)
Runtime["nil"]    = Runtime["NilClass"].new_with_value(nil)

# Object.new
Runtime["Class"].runtime_methods["new"] = proc do |receiver, arguments|
  receiver.new
end

Runtime["Class"].runtime_methods["name"] = proc do |receiver, arguments|
  receiver.name
end

Runtime["Class"].runtime_methods["include"] = proc do |receiver, arguments|
  receiver.include_modules arguments
end

Runtime["Object"].runtime_methods["extend"] = proc do |receiver, arguments|
  receiver.extend_modules arguments
end

Runtime["Class"].runtime_methods["superclass"] = proc do |receiver, arguments|
  cls = receiver.parent
  cls = cls.parent while cls.is_ghost
  cls
end

Runtime["Class"].runtime_methods["ancestors"] = proc do |receiver, arguments|
  current   = receiver
  ancestors = [receiver]
  
  while (current = current.parent)
    break if ancestors.include?(current)    # Avoid an endless loop.
    ancestors << current
  end
  
  ancestors
end

Runtime["Class"].runtime_methods["instance_methods"] = proc do |receiver, arguments|
  Runtime["Class"].runtime_methods["ancestors"].call(receiver).map { |ancestor|
    ancestor.runtime_methods.map { |k, v| k }
  }.flatten
end

Runtime["Object"].runtime_methods["methods"] = proc do |receiver, arguments|
  Runtime["Class"].runtime_methods["ancestors"].call(receiver.runtime_class).map { |ancestor|
    ancestor.runtime_methods.map { |k, v| k }
  }.flatten
end

Runtime["Object"].runtime_methods["klass"] = proc do |receiver, arguments|
  cls = receiver.runtime_class
  cls = cls.runtime_class while cls.is_ghost
  cls
end

Runtime["Object"].runtime_methods["singleton_class"] = proc do |receiver, arguments|
  receiver.singleton_class
end

Runtime["Object"].runtime_methods["method_missing"] = proc do |receiver, arguments|
  puts "NoMethodError: undefined method '#{arguments[0]}' for #{receiver.respond_to?(:name) ? receiver.name : (receiver.ruby_value || 'nil')}:#{Runtime["Object"].runtime_methods["klass"].call(receiver).name}"
end

# Runtime["Number"].runtime_methods["method_missing"] = proc do |receiver, arguments|
#   puts "method_missing called with parameters: #{arguments.map { |a| a.respond_to?(:ruby_value) ? a.ruby_value : a }.join(', ')}"
# end

# print("hi")
Runtime["Object"].runtime_methods["print"] = proc do |receiver, arguments|
  puts arguments.first.ruby_value
  Runtime["nil"]
end

# 1 + 2
Runtime["Number"].runtime_methods["+"] = proc do |receiver, arguments|
  a = receiver.ruby_value
  b = arguments.first.ruby_value
  Runtime["Number"].new_with_value a + b
end

# 1 < 2
# 1.<(2)
Runtime["Number"].runtime_methods["<"] = proc do |receiver, arguments|
  a = receiver.ruby_value
  b = arguments.first.ruby_value
  a < b ? Runtime["true"] : Runtime["false"]
end