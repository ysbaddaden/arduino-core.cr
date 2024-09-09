require "./print"

lib LibC
  alias Stream = StaticArray(UInt8, 10)

  # TRUE = 1
  # FALSE = 0

  # fun _ZN6Stream9timedReadEv(Void*) : Int
  # fun _ZN6Stream9timedPeekEv(Void*) : Int
  # fun _ZN6Stream13peekNextDigitEv(Void*) : Int
  fun _ZN6Stream10setTimeoutEm(Void*, ULong)
  # fun _ZN6Stream4findEPc(Void*, Char*) : Bool
  # fun _ZN6Stream4findEPcj(Void*, Char*, SizeT) : Bool
  # fun _ZN6Stream9findUntilEPcS0_(Void*, Char*, Char*) : Bool
  # fun _ZN6Stream9findUntilEPcjS0_j(Void*, Char*, SizeT, Char*, SizeT) : Bool
  fun _ZN6Stream8parseIntEv(Void*) : Long
  # fun _ZN6Stream8parseIntEc(Void*, Char) : Long
  fun _ZN6Stream10parseFloatEv(Void*) : Float
  # fun _ZN6Stream10parseFloatEc(Void*, Char) : Float
  fun _ZN6Stream9readBytesEPcj(Void*, Char*, SizeT) : SizeT
  fun _ZN6Stream14readBytesUntilEcPcj(Void*, Char, Char*, SizeT) : SizeT
  # fun _ZN6Stream10readStringEv(Void*) : String
  # fun _ZN6Stream15readStringUntilEc(Void*, Char) : String
end

module Arduino
  module StreamMethods
    @[AlwaysInline]
    def timeout=(timeout : ULong) : ULong
      LibC._ZN6Stream10setTimeoutEm(@this, timeout)
      timeout
    end

    # @[AlwaysInline]
    # def find(slice : Bytes) : Bool
    #   LibC._ZN6Stream4findEPcj(@this, slice.to_unsafe, slice.size) == 1
    # end

    # @[AlwaysInline]
    # def find(str : String) : Bool
    #   LibC._ZN6Stream4findEPcj(@this, str.to_unsafe, str.bytesize) == 1
    # end

    @[AlwaysInline]
    def parseInt(str : String) : Long
      LibC._ZN6Stream8parseIntEv(@this)
    end

    @[AlwaysInline]
    def parseInt(str : String) : Float
      LibC._ZN6Stream10parseFloatEv(@this)
    end

    @[AlwaysInline]
    def readBytes(slice : Bytes) : SizeT
      LibC._ZN6Stream8parseIntEv(@this)
    end

    @[AlwaysInline]
    def readBytesUntil(slice : Bytes, terminator : Char) : SizeT
      LibC._ZN6Stream8parseIntEv(@this, terminator.ord.to_u8!, slice.to_unsafe, slice.size)
    end

    # def readString : String
    # end

    # def readStringUntil(terminator : Char) : String
    # end
  end
end
