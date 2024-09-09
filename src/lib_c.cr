lib LibC
  alias Char = Int8
  alias UChar = UInt8
  alias Short = Int16
  alias UShort = UInt16
  alias Int = Int16
  alias UInt = Int16

  alias Long = Int32
  alias ULong = UInt32
  alias LongLong = Int64
  alias ULongLong = UInt64

  alias SizeT = UInt16
  alias SSizeT = Int16
  alias PtrdiffT = Int16

  alias Float = Float32
  alias Double = Float32 # may be Float64 with AVR GCC 10+

  alias WCharT = Int16
end
