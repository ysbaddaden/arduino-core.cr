lib LibC
  alias Print = StaticArray(UInt8, 2)

  # fun _ZN5Print7printlnEPK19__FlashStringHelper(Void*, __FlashStringHelper*) : SizeT
  # fun _ZN5Print7printlnERK6String(Void*, String*) : SizeT
  fun _ZN5Print5printEPKc(Void*, Char*) : SizeT
  fun _ZN5Print5printEc(Void*, Char) : SizeT
  fun _ZN5Print5printEhi(Void*, UChar, Int) : SizeT
  fun _ZN5Print5printEii(Void*, Int, Int) : SizeT
  fun _ZN5Print5printEji(Void*, UInt, Int) : SizeT
  fun _ZN5Print5printEli(Void*, Long, Int) : SizeT
  fun _ZN5Print5printEmi(Void*, ULong, Int) : SizeT
  fun _ZN5Print5printEdi(Void*, Double, Int) : SizeT
  # fun _ZN5Print7printlnERK9Printable(Void*, Printable*) : SizeT

  # fun _ZN5Print5printEPK19__FlashStringHelper(Void*, __FlashStringHelper*) : SizeT
  # fun _ZN5Print5printERK6String(Void*, String*) : SizeT
  # fun _ZN5Print7printlnEPKc(Void*, Char*) : SizeT
  # fun _ZN5Print7printlnEhi(Void*, UChar, Int) : SizeT
  fun _ZN5Print7printlnEii(Void*, Int, Int) : SizeT
  # fun _ZN5Print7printlnEji(Void*, UInt, Int) : SizeT
  # fun _ZN5Print7printlnEli(Void*, Long, Int) : SizeT
  # fun _ZN5Print7printlnEmi(Void*, ULong, Int) : SizeT
  # fun _ZN5Print7printlnEdi(Void*, Double, Int) : SizeT
  fun _ZN5Print7printlnEv(Void*) : SizeT
  # fun _ZN5Print5printERK9Printable(Void*, Printable*) : SizeT
end

module Arduino
  module PrintMethods
    enum Base : LibC::Int
      Dec  = 10
      Hex  = 16
      Oct  =  8
      Bin  =  2
      None =  0

      def to_unsafe
        value
      end
    end

    abstract def write(b : UInt8) : SizeT

    # @[NoInline]
    def write(buffer : Bytes) : SizeT
      n = SizeT.new!(0)
      buffer.each { |byte| n &+= write(byte) }
      n
    end

    # def write(buffer : LibC::Char*) : SizeT
    #  write(buffer.as(UInt8*), LibC.strlen(buffer))
    # end

    # @[AlwaysInline]
    # def print(char : Char) : SizeT
    #  write(char.ord)
    # end

    @[AlwaysInline]
    def print(str : String) : SizeT
      write(str.to_slice)
    end

    # @[AlwaysInline]
    # def print(c : LibC::Char) : SizeT
    #  write(c)
    # end

    @[AlwaysInline]
    def print(b : LibC::UChar, base : LibC::Int) : SizeT
      LibC._ZN5Print5printEhi(@this, b, base)
    end

    @[AlwaysInline]
    def print(num : LibC::Int, base : Base = :dec) : SizeT
      LibC._ZN5Print5printEii(@this, num, base)
    end

    @[AlwaysInline]
    def print(num : LibC::UInt, base : Base = :dec) : SizeT
      LibC._ZN5Print5printEji(@this, num, base)
    end

    @[AlwaysInline]
    def print(num : Long, base : Base = :dec) : SizeT
      LibC._ZN5Print5printEli(@this, num, base)
    end

    @[AlwaysInline]
    def print(num : ULong, base : Base = :dec) : SizeT
      LibC._ZN5Print5printEmi(@this, num, base)
    end

    @[AlwaysInline]
    def print(num : Double, digits : LibC::Int = 2) : SizeT
      LibC._ZN5Print5printEdi(@this, num, digits)
    end

    @[AlwaysInline]
    def println : SizeT
      LibC._ZN5Print7printlnEv(@this)
      # print('\r') &+ print('\n')
    end

    # def println(char : Char) : SizeT
    #  print(char) &+ println
    # end

    # def println(str : String) : SizeT
    #  print(str) &+ println
    # end

    # def println(c : LibC::Char) : SizeT
    #  print(c) &+ println
    # end

    # def println(b : LibC::UChar, base : LibC::Int) : SizeT
    #  print(b) &+ println
    # end

    @[AlwaysInline]
    def println(num : LibC::Int, base : Base = :dec) : SizeT
      # print(num, base) &+ println
      LibC._ZN5Print7printlnEii(@this, num, base.value)
    end

    # def println(num : LibC::UInt, base : Base = :dec) : SizeT
    #  print(num, base) &+ println
    # end

    # def println(num : Long, base : Base = :dec) : SizeT
    #  print(num, base) &+ println
    # end

    # def println(num : ULong, base : Base = :dec) : SizeT
    #  print(num, base) &+ println
    # end

    # def println(num : Double, digits : LibC::Int = 2_i16) : SizeT
    #  print(num, digits) &+ println
    # end
  end
end
