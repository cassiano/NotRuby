#
# DO NOT MODIFY!!!!
# This file is automatically generated by Racc 1.4.7
# from Racc grammer file "".
#

require 'racc/parser.rb'

  require "lexer"
  require "nodes"

class Parser < Racc::Parser

module_eval(<<'...end grammar.y/module_eval...', 'grammar.y', 213)
  def parse(code, show_tokens=false)
    @tokens = Lexer.new.run(code)
    p @tokens if show_tokens
    do_parse
  end
  
  def next_token
    @tokens.shift
  end
...end grammar.y/module_eval...
##### State transition tables begin ###

racc_action_table = [
    29,    33,    30,    25,    26,    33,    18,    19,    20,    21,
    22,    23,    28,   114,    27,    29,    24,    30,    25,    26,
    59,    18,    19,    20,    21,    22,    23,    28,     5,    27,
    93,    24,    17,    76,    29,     5,    30,    25,    26,     5,
    18,    19,    20,    21,    22,    23,    28,    17,    27,    56,
    24,    33,   111,    81,     6,    80,     5,    94,     5,     5,
     5,     6,   105,     5,   110,     6,    17,    29,   126,    30,
    25,    26,     5,    18,    19,    20,    21,    22,    23,    28,
    93,    27,     6,    24,     6,     6,     6,     5,    33,     6,
    44,    45,    42,    43,    33,   124,    44,    45,     6,    17,
    29,    48,    30,    25,    26,    55,    18,    19,    20,    21,
    22,    23,    28,     6,    27,    29,    24,    30,    25,    26,
     5,    18,    19,    20,    21,    22,    23,    28,    31,    27,
    90,    24,    17,    89,    33,     5,    44,    45,    42,    43,
    61,   nil,    33,   122,    44,    45,     6,    17,    29,   nil,
    30,    25,    26,   nil,    18,    19,    20,    21,    22,    23,
    28,     6,    27,    29,    24,    30,    25,    26,     5,    18,
    19,    20,    21,    22,    23,    28,   nil,    27,   104,    24,
    17,   120,   nil,     5,   nil,     5,   nil,     5,   nil,     5,
   104,   121,   nil,   103,     6,    17,    29,   112,    30,    25,
    26,     5,    18,    19,    20,    21,    22,    23,    28,     6,
    27,     6,    24,     6,    49,     6,     5,    48,     5,   nil,
   nil,   nil,     5,   nil,   109,   nil,   107,     6,    17,    29,
   102,    30,    25,    26,     5,    18,    19,    20,    21,    22,
    23,    28,     6,    27,     6,    24,   nil,   nil,     6,     5,
    33,   nil,    44,    45,    42,    43,    38,    39,    40,    41,
     6,    17,    29,   nil,    30,    25,    26,    84,    18,    19,
    20,    21,    22,    23,    28,     6,    27,    29,    24,    30,
    25,    26,   nil,    18,    19,    20,    21,    22,    23,    28,
   nil,    27,   nil,    24,    17,   nil,    29,   nil,    30,    25,
    26,   nil,    18,    19,    20,    21,    22,    23,    28,    17,
    27,    29,    24,    30,    25,    26,   nil,    18,    19,    20,
    21,    22,    23,    28,   nil,    27,   nil,    24,    17,   nil,
    29,   nil,    30,    25,    26,     5,    18,    19,    20,    21,
    22,    23,    28,    17,    27,   nil,    24,    51,    28,    33,
     5,    44,    45,    42,    43,   nil,   nil,   nil,   128,   nil,
   nil,     6,    17,    29,   nil,    30,    25,    26,    54,    18,
    19,    20,    21,    22,    23,    28,     6,    27,    29,    24,
    30,    25,    26,     5,    18,    19,    20,    21,    22,    23,
    28,   nil,    27,   nil,    24,    17,    33,   nil,    44,    45,
    42,    43,    38,    39,    40,    41,    36,    37,    35,     6,
    17,    29,   nil,    30,    25,    26,   nil,    18,    19,    20,
    21,    22,    23,    28,   nil,    27,    29,    24,    30,    25,
    26,   nil,    18,    19,    20,    21,    22,    23,    28,   nil,
    27,   nil,    24,    17,   nil,    29,   nil,    30,    25,    26,
   nil,    18,    19,    20,    21,    22,    23,    28,    17,    27,
    29,    24,    30,    25,    26,   nil,    18,    19,    20,    21,
    22,    23,    28,   nil,    27,   nil,    24,    17,   nil,    29,
   nil,    30,    25,    26,   nil,    18,    19,    20,    21,    22,
    23,    28,    17,    27,    29,    24,    30,    25,    26,   nil,
    18,    19,    20,    21,    22,    23,    28,   nil,    27,   nil,
    24,    17,   nil,    29,   nil,    30,    25,    26,   nil,    18,
    19,    20,    21,    22,    23,    28,    17,    27,    29,    24,
    30,    25,    26,   nil,    18,    19,    20,    21,    22,    23,
    28,   nil,    27,   nil,    24,    17,   nil,    29,   nil,    30,
    25,    26,   nil,    18,    19,    20,    21,    22,    23,    28,
    17,    27,    29,    24,    30,    25,    26,   nil,    18,    19,
    20,    21,    22,    23,    28,   nil,    27,   nil,    24,    17,
   nil,    29,   nil,    30,    25,    26,     5,    18,    19,    20,
    21,    22,    23,    28,    17,    27,    33,    24,    44,    45,
    42,    43,    38,    39,    40,    41,    36,    37,    35,    34,
   nil,   nil,     6,    17,    29,   nil,    30,    25,    26,     5,
    18,    19,    20,    21,    22,    23,    28,   nil,    27,    33,
    24,    44,    45,    42,    43,    38,    39,    40,    41,    36,
    37,    35,    34,   nil,   nil,     6,    17,    29,   nil,    30,
    25,    26,   nil,    18,    19,    20,    21,    22,    23,    28,
   nil,    27,    29,    24,    30,    25,    26,     5,    18,    19,
    20,    21,    22,    23,    28,   nil,    27,   nil,    24,    17,
    33,   nil,    44,    45,    42,    43,    38,    39,    40,    41,
    36,    37,   nil,     6,    17,    29,   nil,    30,    25,    26,
   nil,    18,    19,    20,    21,    22,    23,    28,   nil,    27,
    29,    24,    30,    25,    26,   nil,    18,    19,    20,    21,
    22,    23,    28,   nil,    27,   nil,    24,    17,   nil,   nil,
    33,     5,    44,    45,    42,    43,    38,    39,    40,    41,
   nil,    33,    17,    44,    45,    42,    43,    38,    39,    40,
    41,    36,    37,    35,    34,     5,    33,     6,    44,    45,
    42,    43,   nil,   nil,   nil,    33,   nil,    44,    45,    42,
    43,    38,    39,    40,    41,    36,    37,    35,    34,     5,
   nil,     6,   nil,   nil,   nil,   nil,   nil,   nil,   nil,    33,
   nil,    44,    45,    42,    43,    38,    39,    40,    41,    36,
    37,    35,    34,   nil,    33,     6,    44,    45,    42,    43,
    38,    39,    40,    41,    36,    37,    35,    34,   nil,   nil,
   nil,    33,    74,    44,    45,    42,    43,    38,    39,    40,
    41,    36,    37,    35,    34,   nil,   nil,   nil,    33,    95,
    44,    45,    42,    43,    38,    39,    40,    41,    36,    37,
    35,    34,    33,   nil,    44,    45,    42,    43,    38,    39,
    40,    41,    36,    37,    35,    34,    33,   nil,    44,    45,
    42,    43,    38,    39,    40,    41,    36,    37,    35,    34 ]

racc_action_check = [
    48,    73,    48,    48,    48,    72,    48,    48,    48,    48,
    48,    48,    48,   104,    48,    35,    48,    35,    35,    35,
    31,    35,    35,    35,    35,    35,    35,    35,    51,    35,
   105,    35,    48,    48,   118,    94,   118,   118,   118,   118,
   118,   118,   118,   118,   118,   118,   118,    35,   118,    27,
   118,    50,    99,    52,    51,    51,    99,    81,   120,     2,
   123,    94,    94,   111,    99,   118,   118,   113,   123,   113,
   113,   113,   113,   113,   113,   113,   113,   113,   113,   113,
    80,   113,    99,   113,   120,     2,   123,   119,    67,   111,
    67,    67,    67,    67,    70,   119,    70,    70,   113,   113,
    17,    61,    17,    17,    17,    26,    17,    17,    17,    17,
    17,    17,    17,   119,    17,   108,    17,   108,   108,   108,
   108,   108,   108,   108,   108,   108,   108,   108,     1,   108,
    77,   108,    17,    77,    66,   117,    66,    66,    66,    66,
    33,   nil,    71,   117,    71,    71,   108,   108,    24,   nil,
    24,    24,    24,   nil,    24,    24,    24,    24,    24,    24,
    24,   117,    24,   106,    24,   106,   106,   106,   106,   106,
   106,   106,   106,   106,   106,   106,   nil,   106,   115,   106,
    24,   115,   nil,   116,   nil,   103,   nil,    56,   nil,   100,
    92,   116,   nil,    92,   106,   106,    83,   100,    83,    83,
    83,    83,    83,    83,    83,    83,    83,    83,    83,   116,
    83,   103,    83,    56,    23,   100,    98,    23,    96,   nil,
   nil,   nil,    91,   nil,    98,   nil,    96,    83,    83,    79,
    91,    79,    79,    79,    79,    79,    79,    79,    79,    79,
    79,    79,    98,    79,    96,    79,   nil,   nil,    91,    55,
    64,   nil,    64,    64,    64,    64,    64,    64,    64,    64,
    79,    79,    29,   nil,    29,    29,    29,    55,    29,    29,
    29,    29,    29,    29,    29,    55,    29,    30,    29,    30,
    30,    30,   nil,    30,    30,    30,    30,    30,    30,    30,
   nil,    30,   nil,    30,    29,   nil,    90,   nil,    90,    90,
    90,   nil,    90,    90,    90,    90,    90,    90,    90,    30,
    90,    32,    90,    32,    32,    32,   nil,    32,    32,    32,
    32,    32,    32,    32,   nil,    32,   nil,    32,    90,   nil,
    87,   nil,    87,    87,    87,    87,    87,    87,    87,    87,
    87,    87,    87,    32,    87,   nil,    87,    25,    25,    69,
   127,    69,    69,    69,    69,   nil,   nil,   nil,   127,   nil,
   nil,    87,    87,    34,   nil,    34,    34,    34,    25,    34,
    34,    34,    34,    34,    34,    34,   127,    34,   125,    34,
   125,   125,   125,   125,   125,   125,   125,   125,   125,   125,
   125,   nil,   125,   nil,   125,    34,    62,   nil,    62,    62,
    62,    62,    62,    62,    62,    62,    62,    62,    62,   125,
   125,    84,   nil,    84,    84,    84,   nil,    84,    84,    84,
    84,    84,    84,    84,   nil,    84,    37,    84,    37,    37,
    37,   nil,    37,    37,    37,    37,    37,    37,    37,   nil,
    37,   nil,    37,    84,   nil,    38,   nil,    38,    38,    38,
   nil,    38,    38,    38,    38,    38,    38,    38,    37,    38,
    39,    38,    39,    39,    39,   nil,    39,    39,    39,    39,
    39,    39,    39,   nil,    39,   nil,    39,    38,   nil,    40,
   nil,    40,    40,    40,   nil,    40,    40,    40,    40,    40,
    40,    40,    39,    40,    41,    40,    41,    41,    41,   nil,
    41,    41,    41,    41,    41,    41,    41,   nil,    41,   nil,
    41,    40,   nil,    42,   nil,    42,    42,    42,   nil,    42,
    42,    42,    42,    42,    42,    42,    41,    42,    43,    42,
    43,    43,    43,   nil,    43,    43,    43,    43,    43,    43,
    43,   nil,    43,   nil,    43,    42,   nil,    44,   nil,    44,
    44,    44,   nil,    44,    44,    44,    44,    44,    44,    44,
    43,    44,    45,    44,    45,    45,    45,   nil,    45,    45,
    45,    45,    45,    45,    45,   nil,    45,   nil,    45,    44,
   nil,    86,   nil,    86,    86,    86,    86,    86,    86,    86,
    86,    86,    86,    86,    45,    86,     3,    86,     3,     3,
     3,     3,     3,     3,     3,     3,     3,     3,     3,     3,
   nil,   nil,    86,    86,     0,   nil,     0,     0,     0,     0,
     0,     0,     0,     0,     0,     0,     0,   nil,     0,   101,
     0,   101,   101,   101,   101,   101,   101,   101,   101,   101,
   101,   101,   101,   nil,   nil,     0,     0,    49,   nil,    49,
    49,    49,   nil,    49,    49,    49,    49,    49,    49,    49,
   nil,    49,    85,    49,    85,    85,    85,    85,    85,    85,
    85,    85,    85,    85,    85,   nil,    85,   nil,    85,    49,
    63,   nil,    63,    63,    63,    63,    63,    63,    63,    63,
    63,    63,   nil,    85,    85,    54,   nil,    54,    54,    54,
   nil,    54,    54,    54,    54,    54,    54,    54,   nil,    54,
    36,    54,    36,    36,    36,   nil,    36,    36,    36,    36,
    36,    36,    36,   nil,    36,   nil,    36,    54,   nil,   nil,
    65,    57,    65,    65,    65,    65,    65,    65,    65,    65,
   nil,    57,    36,    57,    57,    57,    57,    57,    57,    57,
    57,    57,    57,    57,    57,    58,    68,    57,    68,    68,
    68,    68,   nil,   nil,   nil,    58,   nil,    58,    58,    58,
    58,    58,    58,    58,    58,    58,    58,    58,    58,    97,
   nil,    58,   nil,   nil,   nil,   nil,   nil,   nil,   nil,    97,
   nil,    97,    97,    97,    97,    97,    97,    97,    97,    97,
    97,    97,    97,   nil,    46,    97,    46,    46,    46,    46,
    46,    46,    46,    46,    46,    46,    46,    46,   nil,   nil,
   nil,    82,    46,    82,    82,    82,    82,    82,    82,    82,
    82,    82,    82,    82,    82,   nil,   nil,   nil,    60,    82,
    60,    60,    60,    60,    60,    60,    60,    60,    60,    60,
    60,    60,    78,   nil,    78,    78,    78,    78,    78,    78,
    78,    78,    78,    78,    78,    78,    75,   nil,    75,    75,
    75,    75,    75,    75,    75,    75,    75,    75,    75,    75 ]

racc_action_pointer = [
   612,   128,    52,   579,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,    98,   nil,   nil,
   nil,   nil,   nil,   183,   146,   334,    91,    35,   nil,   260,
   275,    20,   309,   127,   361,    13,   708,   424,   443,   458,
   477,   492,   511,   526,   545,   560,   787,   nil,    -2,   645,
    34,    21,    36,   nil,   693,   242,   180,   724,   748,   nil,
   821,    67,   379,   663,   233,   713,   117,    71,   739,   332,
    77,   125,   -12,   -16,   nil,   849,   nil,    98,   835,   227,
    67,    44,   804,   194,   409,   660,   579,   328,   nil,   nil,
   294,   215,   158,   nil,    28,   nil,   211,   772,   209,    49,
   182,   612,   nil,   178,     0,    17,   161,   nil,   113,   nil,
   nil,    56,   nil,    65,   nil,   146,   176,   128,    32,    80,
    51,   nil,   nil,    53,   nil,   376,   nil,   343,   nil ]

racc_action_default = [
    -1,   -64,    -2,    -3,    -6,    -7,    -8,    -9,   -10,   -11,
   -12,   -13,   -14,   -15,   -16,   -17,   -18,   -64,   -20,   -21,
   -22,   -23,   -24,   -25,   -64,   -64,   -64,   -64,   -60,   -64,
   -64,   -64,    -5,   -64,   -64,   -64,   -64,   -64,   -64,   -64,
   -64,   -64,   -64,   -64,   -64,   -64,   -64,   -26,   -64,   -64,
   -45,   -51,   -64,   -52,   -64,   -64,   -64,   -64,   -64,   129,
    -4,   -27,   -33,   -34,   -35,   -36,   -37,   -38,   -39,   -40,
   -41,   -42,   -43,   -44,   -19,   -31,   -29,   -64,   -46,   -64,
   -54,   -64,   -64,   -64,   -64,   -64,   -64,   -64,   -28,   -30,
   -64,   -64,   -64,   -55,   -64,   -53,   -64,   -64,   -64,   -64,
   -64,   -32,   -47,   -64,   -64,   -54,   -64,   -57,   -64,   -59,
   -61,   -64,   -63,   -64,   -56,   -64,   -64,   -64,   -64,   -64,
   -64,   -50,   -58,   -64,   -48,   -64,   -62,   -64,   -49 ]

racc_goto_table = [
     2,    46,    32,    47,    53,    92,    77,     1,    50,    52,
   nil,   nil,   nil,    57,    58,   nil,    60,   nil,    62,    63,
    64,    65,    66,    67,    68,    69,    70,    71,    72,    73,
   115,   nil,    75,    78,   nil,   nil,   nil,   nil,    82,   nil,
   nil,    88,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,    79,   nil,   nil,   nil,    83,    85,    86,    87,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,    97,   nil,
   nil,   nil,   nil,   nil,   101,   nil,   nil,   nil,   nil,    91,
   nil,   nil,   nil,    96,   nil,    98,    99,   100,   nil,   nil,
   nil,    32,   nil,   nil,   106,   nil,    32,   108,    32,    32,
    32,   nil,   nil,   113,   nil,   nil,   116,   nil,   117,   nil,
   nil,   118,   nil,   119,   nil,   nil,    32,    32,   123,    32,
   125,   nil,   nil,    32,   nil,   127,   nil,    32 ]

racc_goto_check = [
     2,     3,     4,    15,     8,    17,    16,     1,     3,    18,
   nil,   nil,   nil,     3,     3,   nil,     3,   nil,     3,     3,
     3,     3,     3,     3,     3,     3,     3,     3,     3,     3,
    17,   nil,     3,     3,   nil,   nil,   nil,   nil,     3,   nil,
   nil,    15,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,     4,   nil,   nil,   nil,     4,     4,     4,     4,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,     3,   nil,
   nil,   nil,   nil,   nil,     3,   nil,   nil,   nil,   nil,     2,
   nil,   nil,   nil,     2,   nil,     2,     2,     2,   nil,   nil,
   nil,     4,   nil,   nil,     4,   nil,     4,     4,     4,     4,
     4,   nil,   nil,     4,   nil,   nil,     2,   nil,     2,   nil,
   nil,     4,   nil,     2,   nil,   nil,     4,     4,     2,     4,
     4,   nil,   nil,     4,   nil,     2,   nil,     4 ]

racc_goto_pointer = [
   nil,     7,     0,   -16,     0,   nil,   nil,   nil,   -21,   nil,
   nil,   nil,   nil,   nil,   nil,   -20,   -42,   -75,   -16 ]

racc_goto_default = [
   nil,   nil,   nil,     3,     4,     7,     8,     9,    10,    11,
    12,    13,    14,    15,    16,   nil,   nil,   nil,   nil ]

racc_reduce_table = [
  0, 0, :racc_error,
  0, 37, :_reduce_1,
  1, 37, :_reduce_2,
  1, 38, :_reduce_3,
  3, 38, :_reduce_4,
  2, 38, :_reduce_5,
  1, 38, :_reduce_6,
  1, 40, :_reduce_none,
  1, 40, :_reduce_none,
  1, 39, :_reduce_none,
  1, 39, :_reduce_none,
  1, 39, :_reduce_none,
  1, 39, :_reduce_none,
  1, 39, :_reduce_none,
  1, 39, :_reduce_none,
  1, 39, :_reduce_none,
  1, 39, :_reduce_none,
  1, 39, :_reduce_none,
  1, 39, :_reduce_none,
  3, 39, :_reduce_19,
  1, 41, :_reduce_20,
  1, 41, :_reduce_21,
  1, 41, :_reduce_22,
  1, 41, :_reduce_23,
  1, 41, :_reduce_24,
  1, 42, :_reduce_25,
  2, 42, :_reduce_26,
  3, 42, :_reduce_27,
  4, 42, :_reduce_28,
  2, 51, :_reduce_29,
  3, 51, :_reduce_30,
  1, 52, :_reduce_31,
  3, 52, :_reduce_32,
  3, 43, :_reduce_33,
  3, 43, :_reduce_34,
  3, 43, :_reduce_35,
  3, 43, :_reduce_36,
  3, 43, :_reduce_37,
  3, 43, :_reduce_38,
  3, 43, :_reduce_39,
  3, 43, :_reduce_40,
  3, 43, :_reduce_41,
  3, 43, :_reduce_42,
  3, 43, :_reduce_43,
  3, 43, :_reduce_44,
  2, 43, :_reduce_45,
  3, 45, :_reduce_46,
  5, 46, :_reduce_47,
  8, 46, :_reduce_48,
  10, 46, :_reduce_49,
  7, 46, :_reduce_50,
  1, 54, :_reduce_51,
  1, 54, :_reduce_none,
  3, 54, :_reduce_53,
  0, 53, :_reduce_54,
  1, 53, :_reduce_55,
  3, 53, :_reduce_56,
  5, 47, :_reduce_57,
  7, 47, :_reduce_58,
  5, 48, :_reduce_59,
  1, 44, :_reduce_60,
  5, 49, :_reduce_61,
  8, 49, :_reduce_62,
  5, 50, :_reduce_63 ]

racc_reduce_n = 64

racc_shift_n = 129

racc_token_table = {
  false => 0,
  :error => 1,
  :IF => 2,
  :ELSE => 3,
  :WHILE => 4,
  :DEF => 5,
  :CLASS => 6,
  :NEWLINE => 7,
  :NUMBER => 8,
  :STRING => 9,
  :TRUE => 10,
  :FALSE => 11,
  :NIL => 12,
  :IDENTIFIER => 13,
  :CONSTANT => 14,
  :END => 15,
  :MODULE => 16,
  "." => 17,
  "!" => 18,
  "*" => 19,
  "/" => 20,
  "+" => 21,
  "-" => 22,
  ">" => 23,
  ">=" => 24,
  "<" => 25,
  "<=" => 26,
  "==" => 27,
  "!=" => 28,
  "&&" => 29,
  "||" => 30,
  "=" => 31,
  "," => 32,
  ";" => 33,
  "(" => 34,
  ")" => 35 }

racc_nt_base = 36

racc_use_result_var = true

Racc_arg = [
  racc_action_table,
  racc_action_check,
  racc_action_default,
  racc_action_pointer,
  racc_goto_table,
  racc_goto_check,
  racc_goto_default,
  racc_goto_pointer,
  racc_nt_base,
  racc_reduce_table,
  racc_token_table,
  racc_shift_n,
  racc_reduce_n,
  racc_use_result_var ]

Racc_token_to_s_table = [
  "$end",
  "error",
  "IF",
  "ELSE",
  "WHILE",
  "DEF",
  "CLASS",
  "NEWLINE",
  "NUMBER",
  "STRING",
  "TRUE",
  "FALSE",
  "NIL",
  "IDENTIFIER",
  "CONSTANT",
  "END",
  "MODULE",
  "\".\"",
  "\"!\"",
  "\"*\"",
  "\"/\"",
  "\"+\"",
  "\"-\"",
  "\">\"",
  "\">=\"",
  "\"<\"",
  "\"<=\"",
  "\"==\"",
  "\"!=\"",
  "\"&&\"",
  "\"||\"",
  "\"=\"",
  "\",\"",
  "\";\"",
  "\"(\"",
  "\")\"",
  "$start",
  "Root",
  "Expressions",
  "Expression",
  "Terminator",
  "Literal",
  "Call",
  "Operator",
  "Constant",
  "Assign",
  "Def",
  "Class",
  "Module",
  "If",
  "While",
  "ArgListWithParens",
  "ArgList",
  "ParamList",
  "SingletonObject" ]

Racc_debug_parser = false

##### State transition tables end #####

# reduce 0 omitted

module_eval(<<'.,.,', 'grammar.y', 48)
  def _reduce_1(val, _values, result)
     result = Nodes.new([]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'grammar.y', 49)
  def _reduce_2(val, _values, result)
     result = val[0] 
    result
  end
.,.,

module_eval(<<'.,.,', 'grammar.y', 54)
  def _reduce_3(val, _values, result)
     result = Nodes.new(val) 
    result
  end
.,.,

module_eval(<<'.,.,', 'grammar.y', 55)
  def _reduce_4(val, _values, result)
     result = val[0] << val[2] 
    result
  end
.,.,

module_eval(<<'.,.,', 'grammar.y', 57)
  def _reduce_5(val, _values, result)
     result = val[0] 
    result
  end
.,.,

module_eval(<<'.,.,', 'grammar.y', 58)
  def _reduce_6(val, _values, result)
     result = Nodes.new([]) 
    result
  end
.,.,

# reduce 7 omitted

# reduce 8 omitted

# reduce 9 omitted

# reduce 10 omitted

# reduce 11 omitted

# reduce 12 omitted

# reduce 13 omitted

# reduce 14 omitted

# reduce 15 omitted

# reduce 16 omitted

# reduce 17 omitted

# reduce 18 omitted

module_eval(<<'.,.,', 'grammar.y', 79)
  def _reduce_19(val, _values, result)
     result = val[1] 
    result
  end
.,.,

module_eval(<<'.,.,', 'grammar.y', 84)
  def _reduce_20(val, _values, result)
     result = NumberNode.new(val[0]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'grammar.y', 85)
  def _reduce_21(val, _values, result)
     result = StringNode.new(val[0]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'grammar.y', 86)
  def _reduce_22(val, _values, result)
     result = TrueNode.new 
    result
  end
.,.,

module_eval(<<'.,.,', 'grammar.y', 87)
  def _reduce_23(val, _values, result)
     result = FalseNode.new 
    result
  end
.,.,

module_eval(<<'.,.,', 'grammar.y', 88)
  def _reduce_24(val, _values, result)
     result = NilNode.new 
    result
  end
.,.,

module_eval(<<'.,.,', 'grammar.y', 94)
  def _reduce_25(val, _values, result)
     result = CallNode.new(nil, val[0], []) 
    result
  end
.,.,

module_eval(<<'.,.,', 'grammar.y', 96)
  def _reduce_26(val, _values, result)
     result = CallNode.new(nil, val[0], val[1]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'grammar.y', 98)
  def _reduce_27(val, _values, result)
     result = CallNode.new(val[0], val[2], []) 
    result
  end
.,.,

module_eval(<<'.,.,', 'grammar.y', 101)
  def _reduce_28(val, _values, result)
     result = CallNode.new(val[0], val[2], val[3]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'grammar.y', 105)
  def _reduce_29(val, _values, result)
     result = [] 
    result
  end
.,.,

module_eval(<<'.,.,', 'grammar.y', 106)
  def _reduce_30(val, _values, result)
     result = val[1] 
    result
  end
.,.,

module_eval(<<'.,.,', 'grammar.y', 110)
  def _reduce_31(val, _values, result)
     result = val 
    result
  end
.,.,

module_eval(<<'.,.,', 'grammar.y', 111)
  def _reduce_32(val, _values, result)
     result = val[0] << val[2] 
    result
  end
.,.,

module_eval(<<'.,.,', 'grammar.y', 116)
  def _reduce_33(val, _values, result)
     result = CallNode.new(val[0], val[1], [val[2]]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'grammar.y', 117)
  def _reduce_34(val, _values, result)
     result = CallNode.new(val[0], val[1], [val[2]]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'grammar.y', 118)
  def _reduce_35(val, _values, result)
     result = CallNode.new(val[0], val[1], [val[2]]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'grammar.y', 119)
  def _reduce_36(val, _values, result)
     result = CallNode.new(val[0], val[1], [val[2]]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'grammar.y', 120)
  def _reduce_37(val, _values, result)
     result = CallNode.new(val[0], val[1], [val[2]]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'grammar.y', 121)
  def _reduce_38(val, _values, result)
     result = CallNode.new(val[0], val[1], [val[2]]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'grammar.y', 122)
  def _reduce_39(val, _values, result)
     result = CallNode.new(val[0], val[1], [val[2]]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'grammar.y', 123)
  def _reduce_40(val, _values, result)
     result = CallNode.new(val[0], val[1], [val[2]]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'grammar.y', 126)
  def _reduce_41(val, _values, result)
     result = CallNode.new(val[0], val[1], [val[2]]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'grammar.y', 127)
  def _reduce_42(val, _values, result)
     result = CallNode.new(val[0], val[1], [val[2]]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'grammar.y', 128)
  def _reduce_43(val, _values, result)
     result = CallNode.new(val[0], val[1], [val[2]]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'grammar.y', 129)
  def _reduce_44(val, _values, result)
     result = CallNode.new(val[0], val[1], [val[2]]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'grammar.y', 131)
  def _reduce_45(val, _values, result)
     result = CallNode.new(val[1], val[0], []) 
    result
  end
.,.,

module_eval(<<'.,.,', 'grammar.y', 136)
  def _reduce_46(val, _values, result)
     result = AssignNode.new(val[0], val[2]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'grammar.y', 143)
  def _reduce_47(val, _values, result)
     result = DefNode.new(nil, val[1], [], val[3]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'grammar.y', 146)
  def _reduce_48(val, _values, result)
     result = DefNode.new(nil, val[1], val[3], val[6]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'grammar.y', 149)
  def _reduce_49(val, _values, result)
     result = DefNode.new(val[1], val[3], val[5], val[8]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'grammar.y', 152)
  def _reduce_50(val, _values, result)
     result = DefNode.new(val[1], val[3], [], val[5]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'grammar.y', 156)
  def _reduce_51(val, _values, result)
     result = val[0] 
    result
  end
.,.,

# reduce 52 omitted

module_eval(<<'.,.,', 'grammar.y', 158)
  def _reduce_53(val, _values, result)
     result = val[1] 
    result
  end
.,.,

module_eval(<<'.,.,', 'grammar.y', 162)
  def _reduce_54(val, _values, result)
     result = [] 
    result
  end
.,.,

module_eval(<<'.,.,', 'grammar.y', 163)
  def _reduce_55(val, _values, result)
     result = val 
    result
  end
.,.,

module_eval(<<'.,.,', 'grammar.y', 164)
  def _reduce_56(val, _values, result)
     result = val[0] << val[2] 
    result
  end
.,.,

module_eval(<<'.,.,', 'grammar.y', 171)
  def _reduce_57(val, _values, result)
     result = ClassNode.new(val[1], nil, val[3]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'grammar.y', 174)
  def _reduce_58(val, _values, result)
     result = ClassNode.new(val[1], val[3], val[5]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'grammar.y', 181)
  def _reduce_59(val, _values, result)
     result = ModuleNode.new(val[1], val[3]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'grammar.y', 186)
  def _reduce_60(val, _values, result)
     result = ConstantNode.new(val[0]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'grammar.y', 192)
  def _reduce_61(val, _values, result)
     result = IfNode.new(val[1], val[3], nil) 
    result
  end
.,.,

module_eval(<<'.,.,', 'grammar.y', 197)
  def _reduce_62(val, _values, result)
     result = IfNode.new(val[1], val[3], val[6]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'grammar.y', 203)
  def _reduce_63(val, _values, result)
     result = WhileNode.new(val[1], val[3]) 
    result
  end
.,.,

def _reduce_none(val, _values, result)
  val[0]
end

end   # class Parser
