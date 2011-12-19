# Compile with: rex tokens.rex -o lexer.rb

class Lexer

macro
  BLANK             [\ \t]+
  KEYWORDS          \b(end|def|class|if|while|else|true|false|nil|module|self|super)\b
  LONGER_OPERATORS  \|\||&&|==|!=|>=|<=

rule
  # Whitespace
  {BLANK}       # no action
  \#.*$
  
  # Literals
  \d+                                   { [:NUMBER, text.to_i] }
  (["']).*?\1                           { [:STRING, text[1..-2]] }
  \n+                                   { [:NEWLINE, text] }
  
  # Keywords
  {KEYWORDS}                            { [text.upcase.to_sym, text] }
  
  # Identifiers
  [a-z]\w*                              { [:IDENTIFIER, text] }
  [A-Z]\w*                              { [:CONSTANT, text] }
  
  # Longer operators
  {LONGER_OPERATORS}                    { [text, text] }
  
  # Catch all
  .                                     { [text, text] }

inner
  def run(code)
    scan_setup(code)
    tokens = []
    while token = next_token
      tokens << token
    end
    tokens
  end
end