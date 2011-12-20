require 'polyglot'
require 'treetop'

Treetop.load 'ruby'

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

Context = Struct.new(:current_self, :locals)
@context = Context.new(nil, {})

@parser = RubyParser.new
