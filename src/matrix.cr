class Matrix
  DIRS1 = [
    {0, 1, '-'},
    {1, -1, '/'},
    {1, 0, '|'},
    {1, 1, '\\'},
  ]
  DIRS = DIRS1 + DIRS1.map { |dy, dx, edge| {-dy, -dx, edge} }

  @chars : Array(Array(Char))
  @connections = Hash(Char, Hash(Tuple(Int32, Int32), Char)).new { |h, k|
    h[k] = {} of Tuple(Int32, Int32) => Char
  }

  def debug(s : String)
  end

  def initialize(s : String)
    debug s
    @chars = s.each_line.map(&.chomp.chars).to_a
    @chars.each_with_index { |row, y|
      y = y.to_u32
      row.each_with_index { |c, x|
        next unless c.alpha?
        x = x.to_u32
        DIRS.each { |dy, dx, edge|
          next if @connections[c].has_key?({dy, dx})
          if self[y + dy, x + dx]? == edge
            cdy, cdx, cc = travel(y, x, dy, dx)
            @connections[c][{dy, dx}] = cc
            @connections[cc][{-cdy, -cdx}] = c
            debug "#{c} is connected to #{cc}"
          end
        }
      }
    }
  end

  def []?(y : UInt32, x : UInt32) : Char?
    # Note: If we use Int32 instead, we have to forbid negative indexing.
    row = @chars[y]?
    row && row[x]?
  end

  def to_s
    # We could cache this, but I'm lazy.
    sorted_chars = @connections.keys.sort
    sorted_chars.map { |c1|
      connections = Set.new(@connections[c1].values)
      sorted_chars.map { |c2|
        connections.includes?(c2) ? '1' : '0'
      }.join
    }.join('\n')
  end

  private def travel(y : UInt32, x : UInt32, dy : Int32, dx : Int32) : Tuple(Int32, Int32, Char)
    debug "Traveling #{dy}, #{dx} from #{y}, #{x}"
    cy = y + 2 * dy
    cx = x + 2 * dx
    until (cc = self[cy, cx]?).nil? || (cc && cc.alpha?) || cc == '#'
      cy += dy
      cx += dx
    end

    case cc
    when nil
      raise "went off the map traveling #{dy}, #{dx} from #{y}, #{x}"
    when '#'
      connect_dummy(cy, cx, dy, dx)
    else
      {dy, dx, cc}
    end
  end

  private def connect_dummy(y : UInt32, x : UInt32, except_dy : Int32, except_dx : Int32) : Tuple(Int32, Int32, Char)
    debug "Connecting dummy #{y}, #{x} but not #{except_dy}. #{except_dx}"
    dir = DIRS.reject { |dy, dx, _|
      dy == -except_dy && dx == -except_dx
    }.find { |dy, dx, edge|
      self[y + dy, x + dx]? == edge
    }
    raise "Too few edges out of dummy node at #{y}, #{x}" unless dir
    dy, dx, _ = dir
    travel(y, x, dy, dx)
  end
end
