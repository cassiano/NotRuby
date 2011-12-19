# Compile with: racc grammar.y -o parser.rb

class Parser

# Declare tokens produced by the lexer
token IF ELSE WHILE DEF CLASS NEWLINE NUMBER STRING TRUE FALSE NIL IDENTIFIER CONSTANT END MODULE SELF SUPER

# Precedence table
# Based on http://en.wikipedia.org/wiki/Operators_in_C_and_C%2B%2B#Operator_precedence
prechigh
  left  '.'
  right '!'
  left  '*' '/'
  left  '+' '-'
  left  '>' '>=' '<' '<='
  left  '==' '!='
  left  '&&'
  left  '||'
  right '='
  left  ','
preclow

rule
  # All rules are declared in this format:
  #
  #   RuleName:
  #     OtherRule TOKEN AnotherRule    { code to run when this matches }
  #   | OtherRule                      { ... }
  #   ;
  #
  # In the code section (inside the {...} on the right):
  # - Assign to "result" the value returned by the rule.
  # - Use val[index of expression] to reference expressions on the left.
  
  
  # All parsing will end in this rule, being the trunk of the AST.
  Root:
    /* nothing */                      { result = Nodes.new([]) }
  | Expressions                        { result = val[0] }
  ;
  
  # Any list of expressions, class or method body, separated by line breaks.
  Expressions:
    Expression                         { result = Nodes.new(val) }
  | Expressions Terminator Expression  { result = val[0] << val[2] }
    # To ignore trailing line breaks
  | Expressions Terminator             { result = val[0] }
  | Terminator                         { result = Nodes.new([]) }
  ;
  
  # All tokens that can terminate an expression
  Terminator:
    NEWLINE
  | ";"
  ;

  # All types of expression in our language
  Expression:
    Self
  | Super
  | Literal
  | Call
  | Operator
  | Constant
  | Assign
  | Def
  | Class
  | Module
  | If
  | While
  | SingletonClassOperator
  | '(' Expression ')'    { result = val[1] }
  ;
  
  Self:
    SELF                          { result = SelfNode.new }

  Super:
    # super
    SUPER                         { result = SuperNode.new([]) }
    # super(1, 2, 3)
  | SUPER ArgListWithParens       { result = SuperNode.new(val[1]) }
  ;
  
  # All hard-coded values
  Literal:
    NUMBER                        { result = NumberNode.new(val[0]) }
  | STRING                        { result = StringNode.new(val[0]) }
  | TRUE                          { result = TrueNode.new }
  | FALSE                         { result = FalseNode.new }
  | NIL                           { result = NilNode.new }
  ;
  
  # Method call
  Call:
    # method
    IDENTIFIER                    { result = CallNode.new(nil, val[0], []) }
    # method(1, 2, 3)
  | IDENTIFIER ArgListWithParens  { result = CallNode.new(nil, val[0], val[1]) }
    # receiver.class (special method name, given it's a keyword)
  | Expression '.' IDENTIFIER     { result = CallNode.new(val[0], val[2], []) }
    # receiver.method(1, 2, 3)
  | Expression '.' IDENTIFIER
      ArgListWithParens           { result = CallNode.new(val[0], val[2], val[3]) }
  ;
  
  ArgListWithParens:
    '(' ')'                       { result = [] }
  | '(' ArgList ')'               { result = val[1] }
  ;
  
  ArgList:
    Expression                    { result = val }
  | ArgList "," Expression        { result = val[0] << val[2] }
  ;
  
  Operator:
  # Binary operators
    Expression '||' Expression    { result = CallNode.new(val[0], val[1], [val[2]]) }
  | Expression '&&' Expression    { result = CallNode.new(val[0], val[1], [val[2]]) }
  | Expression '==' Expression    { result = CallNode.new(val[0], val[1], [val[2]]) }
  | Expression '!=' Expression    { result = CallNode.new(val[0], val[1], [val[2]]) }
  | Expression '>' Expression     { result = CallNode.new(val[0], val[1], [val[2]]) }
  | Expression '>=' Expression    { result = CallNode.new(val[0], val[1], [val[2]]) }
  | Expression '<' Expression     { result = CallNode.new(val[0], val[1], [val[2]]) }
  | Expression '<=' Expression    { result = CallNode.new(val[0], val[1], [val[2]]) }
    # 1 + 2 => 1.+(2)
    #   1       +       2                                   1       "+"      [2]
  | Expression '+' Expression     { result = CallNode.new(val[0], val[1], [val[2]]) }
  | Expression '-' Expression     { result = CallNode.new(val[0], val[1], [val[2]]) }
  | Expression '*' Expression     { result = CallNode.new(val[0], val[1], [val[2]]) }
  | Expression '/' Expression     { result = CallNode.new(val[0], val[1], [val[2]]) }
  # Unary operators
  | '!' Expression                { result = CallNode.new(val[1], val[0], []) }
  ;
  
  # Assigment to a local variable
  Assign:
    IDENTIFIER "=" Expression     { result = AssignNode.new(val[0], val[2]) }
  ;
  
  # Method definition
  Def:
    DEF IDENTIFIER Terminator
      Expressions
    END                           { result = DefNode.new(nil, val[1], [], val[3]) }
  | DEF IDENTIFIER "(" ParamList ")" Terminator
      Expressions
    END                           { result = DefNode.new(nil, val[1], val[3], val[6]) }
  | DEF SingletonObject "." IDENTIFIER "(" ParamList ")" Terminator
      Expressions
    END                           { result = DefNode.new(val[1], val[3], val[5], val[8]) }
  | DEF SingletonObject "." IDENTIFIER Terminator
      Expressions
    END                           { result = DefNode.new(val[1], val[3], [], val[5]) }
  ;

  SingletonObject:
    Self
  | IDENTIFIER                    { result = val[0] }
  | Constant
  | "(" Expression ")"            { result = val[1] }
  ;

  ParamList:
    /* nothing */                 { result = [] }
  | IDENTIFIER                    { result = val }
  | ParamList "," IDENTIFIER      { result = val[0] << val[2] }
  ;
  
  # Class definition
  Class:
    CLASS CONSTANT Terminator
      Expressions
    END                           { result = ClassNode.new(val[1], nil, val[3]) }
  | CLASS CONSTANT "<" Expression Terminator
      Expressions
    END                           { result = ClassNode.new(val[1], val[3], val[5]) }
  ;

  # Module definition
  Module:
    MODULE CONSTANT Terminator
      Expressions
    END                           { result = ModuleNode.new(val[1], val[3]) }
  ;
  
  # Retrieving the value of a constant
  Constant:
    CONSTANT                      { result = ConstantNode.new(val[0]) }
  ;
  
  If:
    IF Expression Terminator
      Expressions
    END                                 { result = IfNode.new(val[1], val[3], nil) }
  | IF Expression Terminator
      Expressions
    ELSE Terminator
      Expressions
    END                                 { result = IfNode.new(val[1], val[3], val[6]) }
  ;
  
  While:
    WHILE Expression Terminator
      Expressions
    END                                 { result = WhileNode.new(val[1], val[3]) }
  ;
  
  SingletonClassOperator:
    CLASS "<<" Expression Terminator
      Expressions
    END                                 { result = SingletonClassOperatorNode.new(val[2], val[4]) }
  ;
end

---- header
  require "lexer"
  require "nodes"

---- inner
  def parse(code, show_tokens=false)
    @tokens = Lexer.new.run(code)
    p @tokens if show_tokens
    do_parse
  end
  
  def next_token
    @tokens.shift
  end