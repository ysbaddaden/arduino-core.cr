require "primitives"

@[Extern]
struct St
  @i : Int16
  @j : Int8
  @i1 : UInt64
  @i2 : UInt64

  def i
    @i
  end

  def j
    @j
  end

  def initialize(@i, @j)
    @i1 = 0
    @i2 = 0
  end

  def increment(i, j)
    @i &+= i
    @j &+= j
  end
end

@[NoInline]
fun xcall(s : St*) : St*
  s.value.increment(4, 3)
  s
end

@[NoInline]
fun main2 : Int16
  st1 = St.new(0, 2)
  xcall(pointerof(st1))
  return st1.@i &+ st1.@j
end
