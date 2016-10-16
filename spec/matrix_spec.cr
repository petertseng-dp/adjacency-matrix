require "spec"
require "../src/matrix"

CASES = [
  {
    "a single node",
    "
a
",
    "
0
",
  },
  {
    "unconnected nodes",
    "
a  b
",
    "
00
00
",
  },
  {
    "nodes connected horizontally",
    "
a--b
",
    "
01
10
",
  },
  {
    "nodes connected vertically",
    "
a
|
|
b
",
    "
01
10
",
  },
  {
    "nodes connected on falling diagonal",
    "
a
 \\
  \\
   b
",
    "
01
10
",
  },
  {
    "nodes connected on rising diagonal",
    "
   a
  /
 /
b
",
    "
01
10
",
  },
  {
    "nodes connected via dummy node",
    "
a--#
   |
   |
   b
",
    "
01
10
",
  },
  {
    "nodes connected via dummy node in same direction",
    "
#---#
 \\   \\
  \\   \\
   a   b
",
    "
01
10
",
  },
  {
    "nodes connected via dummy node in same (other) direction",
    "
a   b
 \\   \\
  \\   \\
   #---#
",
    "
01
10
",
  },
  {
    "example 1 - three node-clique",
    "
a
|\\
| \\
|  \\
b---c
",
    "
011
101
110
",
  },
  {
    "edges crossing over each other",
    "
         a
        /|
       / |
d---------------e
 \\   /   |
  \\ /    |
   c     |
         |
         b
",
    "
01100
10000
10010
00101
00010
",
  },
  {
    "crossing over multiple edges successively",
    "
   e
b  |
 \\ |g
  \\||
   \\|
s---\\-----t
   ||\\
   || \\
   f|  \\
    |   c
    h
",
    "
01000000
10000000
00010000
00100000
00000100
00001000
00000001
00000010
",
  },
  {
    "example in input specification",
    "
a-----b
|\\   / \\
| \\ /   \\
|  /     e
| / \\   /
|/   \\ /
c-----d
",
    "
01110
10101
11010
10101
01010
",
  },
  {
    "crossing over many edges",
    "
    z  y  x  w
  a-|\\-|\\-|\\-|-b
    | \\| \\| \\|
    v  u  t  s
",
    "
0100000000
1000000000
0000001100
0000000110
0000000011
0000000001
0010000000
0011000000
0001100000
0000110000
",
  },
  {
    "example 2",
    "
a  b--c
|    /
|   /
d  e--f
 \\    |
  \\   |
g--h--#
",
    "
00010000
00100000
01001000
10000001
00100100
00001001
00000001
00010110
",
  },
  {
    "example 3 - many dummy nodes",
    "
a   #   #   #   #   #   #   b
 \\ / \\ / \\ / \\ / \\ / \\ / \\ / \\
  /   /   /   /   /   /   /   #
 / \\ / \\ / \\ / \\ / \\ / \\ / \\ /
c   #   #   #   #   #   #   d
",
    "
0001
0011
0100
1100
",
  },
  {
    "example 4 - nodes next to each other",
    "
    ab-#
# e-|\\-|-#
|\\ \\# c# |
| #-#\\| \\|
#-----d  #
",
    "
00110
00001
10010
10101
01010
",
  },
  {
    "example 5 - nodes next to edges",
    "
   #--#
   | /        #
   |a--------/-\\-#
  #--\\-c----d   /
   \\  \\|     \\ / \\
   |\\  b      #   #
   | #  \\        /
   |/    #------#
   #
",
    "
0111
1011
1101
1110
",
  },
].map { |desc, input, output| {desc, input[1..-1], output.strip} }

describe Matrix do
  CASES.each { |desc, input, expected|
    it desc do
      Matrix.new(input).to_s.should eq(expected)
    end
  }
end
