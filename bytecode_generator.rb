## Our humble bytecode format
#
#                                       Stack
# Opcode           Operands     before         after
CALL,            # index, argc  [rcv, arg...]  [returned]
PUSH_NUMBER,     # index        []             [number]
PUSH_STRING,     # index        []             [string]
PUSH_SELF,       #              []             [self]
PUSH_NIL,        #              []             [nil]
PUSH_BOOL,       # 1=t, 0=f     []             [true or false]
GET_LOCAL,       # index        []             [value]
SET_LOCAL,       # index        [value]        []
JUMP_UNLESS,     # offset       [test]         []
ADD,             #              [a, b]         [result]
RETURN = *       #              []             []
(0..10)

class BytecodeGenerator
  def initialize
    @literals = []
    @locals = []
    @instructions = []
  end
  
  def compile_all(nodes)
    nodes.each { |node| node.compile(self) }
  end
  
  def number_literal(value)
    emit PUSH_NUMBER, literal_index(value)
  end
  
  def string_literal(value)
    emit PUSH_STRING, literal_index(value)
  end
  
  def true_literal
    emit PUSH_BOOL, 1
  end
  
  def false_literal
    emit PUSH_BOOL, 0
  end
  
  def nil_literal
    emit PUSH_NIL
  end
  
  def set_local(name, value)
    value.compile(self)
    emit SET_LOCAL, local_index(name)
  end
  
  def get_local(name)
    emit GET_LOCAL, local_index(name)
  end
  
  def call(receiver, method, arguments)
    if receiver
      receiver.compile(self)
    else
      # self.print
      emit PUSH_SELF
    end
    
    arguments.each do |argument|
      argument.compile(self)
    end
    
    if method == "+"
      emit ADD
      return
    end
    
    emit CALL, literal_index(method), arguments.size
  end
  
  def if(condition, body)
    condition.compile(self)
    emit JUMP_UNLESS, 0
    offset_index = @instructions.size - 1
    body.compile(self)
    @instructions[offset_index] = @instructions.size - 1 - offset_index
  end
  
  # true if the local variable as been defined
  def has_local?(name)
    @locals.include?(name)
  end
  
  # Returns the index of the local in the local table
  def local_index(name)
    @locals << name unless @locals.include?(name)
    @locals.index(name)
  end
  
  # Returns the index of the literal in the literal table
  def literal_index(literal)
    @literals << literal unless @literals.include?(literal)
    @literals.index(literal)
  end
  
  # Emit the instruction
  # Eg.:
  #  emit CALL, 1, 10
  # will generate the bytecode
  # 0, 1, 10
  def emit(opcode, *operands)
    @instructions << opcode
    @instructions.concat operands
  end
  
  def assemble
    emit RETURN
    
    {
      :literals => @literals,
      :locals => @locals,
      :instructions => @instructions
    }
  end
end
