require File.dirname(__FILE__) + '/test_helper'
require 'interpreter'

class InterpreterTest < Test::Unit::TestCase
  def test_number
    assert_equal 1, Interpreter.new.eval("1").ruby_value
  end
  
  def test_true
    assert_equal true, Interpreter.new.eval("true").ruby_value
  end
  
  def test_assign
    assert_equal 2, Interpreter.new.eval("a = 2; 3; a").ruby_value
  end
  
  def test_method
    code = <<-CODE
      def boo(a)
        a
      end
      
      boo("yah!")
    CODE
    
    assert_equal "yah!", Interpreter.new.eval(code).ruby_value
  end
  
  def test_reopen_class
    code = <<-CODE
      class Number
        def ten
          10
        end
      end
      
      1.ten
    CODE
    
    assert_equal 10, Interpreter.new.eval(code).ruby_value
  end
  
  def test_define_class
    code = <<-CODE
      class Pony
        def awesome
          true
        end
      end
      
      Pony.new.awesome
    CODE
    
    assert_equal true, Interpreter.new.eval(code).ruby_value
  end
  
  def test_if
    code = <<-CODE
      if true
        "works!"
      end
    CODE
    
    assert_equal "works!", Interpreter.new.eval(code).ruby_value
  end
  
  def test_if_with_else
    code = <<-CODE
      if false
        "nope"
      else
        "works!"
      end
    CODE
    
    assert_equal "works!", Interpreter.new.eval(code).ruby_value
  end
  
  def test_while
    code = <<-CODE
      x = 0
      while x < 10
        x = x + 1
      end
      x
    CODE
    
    assert_equal 10, Interpreter.new.eval(code).ruby_value
  end

  def test_inheritance
    code = <<-CODE
      class A1
        def m
          1
        end
      end
        
      class B1 < A1
        # Empty class body
      end
      
      B1.new.m
    CODE
    
    assert_equal 1, Interpreter.new.eval(code).ruby_value
  end

  def test_singleton_method
    code = <<-CODE
      class A2
        def A2.m
          2
        end
      end
        
      A2.m
    CODE
    
    assert_equal 2, Interpreter.new.eval(code).ruby_value
  end

  def test_singleton_method
    code = <<-CODE
      a = 1
      
      def a.m
        2
      end
      
      a.m
    CODE
    
    assert_equal 2, Interpreter.new.eval(code).ruby_value
  end

  def test_inheritance_of_singleton_method
    code = <<-CODE
      class A3
        def A3.m
          3
        end
      end
        
      class B3 < A3
        # Empty class body
      end
      
      B3.m
    CODE
    
    assert_equal 3, Interpreter.new.eval(code).ruby_value
  end

  def test_self_in_instance_method
    code = <<-CODE
      class A4
        def m
          self.n
        end
        
        def n
          4
        end
      end

      A4.new.m
    CODE
    
    assert_equal 4, Interpreter.new.eval(code).ruby_value
  end

  def test_self_in_class_method
    code = <<-CODE
      class A5
        def self.m
          self.n
        end
        
        def self.n
          5
        end
      end

      A5.m
    CODE
    
    assert_equal 5, Interpreter.new.eval(code).ruby_value
  end

  def test_include_module
    code = <<-CODE
      module M6
        def m
          6
        end
      end
        
      class A6
        include(M6)
      end
      
      A6.new.m
    CODE
    
    assert_equal 6, Interpreter.new.eval(code).ruby_value
  end

  def test_extend_module
    code = <<-CODE
      module M7
        def m
          7
        end
      end
        
      class A7
        extend(M7)
      end
      
      A7.m
    CODE
    
    assert_equal 7, Interpreter.new.eval(code).ruby_value
  end
  
  def test_default_method_missing
    code = <<-CODE
      '...'.non_existent_method
    CODE
    
    assert_raise RuntimeError, "NoMethodError: undefined method 'non_existent_method' for ...:String" do
      Interpreter.new.eval(code)
    end
  end  

  def test_overridden_method_missing
    code = <<-CODE
      1.non_existent_method(2, 3, 4)
    CODE
    
    assert_raise RuntimeError, "Overriden method_missing for 1:Number called with parameters: [:non_existent_method, 2, 3, 4]" do
      Interpreter.new.eval(code)
    end
  end

  def test_instance_methods
    code = <<-CODE
      class A8
        def m
          # Empty
        end
        
        def n
          # Empty
        end
      end
      
      A8
    CODE
    
    assert_equal [:m, :n], Interpreter.new.eval(code).call(:instance_methods) - Runtime[:Object].call(:instance_methods)
    assert_equal [:m, :n], Interpreter.new.eval(code).call(:instance_methods, [Runtime[:false]])
  end

  def test_super_1_level
    code = <<-CODE
      class A9
        def m(p1, p2)
          p1 + p2
        end
      end
        
      class B9 < A9
        def m(p1, p2)
          super
        end
      end
      
      B9.new.m(9, 10)
    CODE
    
    assert_equal 19, Interpreter.new.eval(code).ruby_value
  end

  def test_super_2_levels
    code = <<-CODE
      class A10
        def m(p1, p2)
          p1 + p2
        end
      end
        
      class B10 < A10
        def m(p1, p2)
          super
        end
      end

      class C10 < B10
        def m(p1, p2)
          super
        end
      end
      
      C10.new.m(10, 11)
    CODE
    
    assert_equal 21, Interpreter.new.eval(code).ruby_value
  end

  def test_super_with_non_existing_method_1_level
    code = <<-CODE
      class A11
        def m(p1, p2)
          super
        end
      end
      
      A11.new.m(11, 12)
    CODE
    
    assert_raise RuntimeError, "NoMethodError: undefined method 'm' for xxx:xxx" do
      Interpreter.new.eval(code)
    end
  end

  def test_super_with_non_existing_method_2_levels
    code = <<-CODE
      class A12
        def m(p1, p2)
          super
        end
      end
        
      class B12 < A12
        def m(p1, p2)
          super
        end
      end

      B12.new.m(12, 13)
    CODE
    
    assert_raise RuntimeError, "NoMethodError: undefined method 'm' for xxx:xxx" do
      Interpreter.new.eval(code)
    end
  end

  def test_super_with_parameters
    code = <<-CODE
      class A13
        def m(p1, p2)
          p1 + p2
        end
      end
        
      class B13 < A13
        def m(p1, p2)
          super(15, 16)
        end
      end
      
      B13.new.m(13, 14)
    CODE
    
    assert_equal 31, Interpreter.new.eval(code).ruby_value
  end

  def test_class_less_than_less_than_object_current_class
    code = <<-CODE
      class A14
        class << self
          def m
            14
          end
        end
      end
      
      A14.m
    CODE
    
    assert_equal 14, Interpreter.new.eval(code).ruby_value
  end

  def test_class_less_than_less_than_object_current_self
    code = <<-CODE
      class Object
        def singleton_klass
          class << self
            self
          end
        end
      end
      
      class A
        self
      end
    CODE
    
    assert_equal Interpreter.new.eval(code).call(:singleton_class), Interpreter.new.eval(code).call(:singleton_klass)
  end
end
