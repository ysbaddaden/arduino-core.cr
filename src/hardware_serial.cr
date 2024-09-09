require "./stream"

lib LibC
  alias HardwareSerial = StaticArray(UInt8, 32)

  fun _ZN14HardwareSerial9availableEv(Void*) : Int
  fun _ZN14HardwareSerial4peekEv(Void*) : Int
  fun _ZN14HardwareSerial4readEv(Void*) : Int
  fun _ZN14HardwareSerial5flushEv(Void*)
  fun _ZN14HardwareSerial5writeEh(Void*, UInt8) : SizeT
  fun _ZN14HardwareSerial5beginEm(Void*, ULong)
  fun _ZN14HardwareSerial5beginEmh(Void*, ULong, UInt8)
  fun _ZN14HardwareSerial3endEv(Void*)
  fun _Z14serialEventRunv

  $serial = Serial : HardwareSerial
end

module Arduino
  struct HardwareSerial
    include PrintMethods
    include StreamMethods

    def initialize(this : LibC::HardwareSerial*)
      @this = this.as(Void*)
    end

    @[AlwaysInline]
    def begin(a : ULong) : Nil
      LibC._ZN14HardwareSerial5beginEm(@this, a)
    end

    @[AlwaysInline]
    def begin(a : ULong, b : UInt8) : Nil
      LibC._ZN14HardwareSerial5beginEmh(@this, a)
    end

    # @[AlwaysInline]
    # def end : Nil
    #  LibC._ZN14HardwareSerial3endEv(@this)
    # end

    # @[AlwaysInline]
    # def available : LibC::Int
    #  LibC._ZN14HardwareSerial9availableEv(@this)
    # end

    # @[AlwaysInline]
    # def peek : LibC::Int
    #  LibC._ZN14HardwareSerial4peekEv(@this)
    # end

    # @[AlwaysInline]
    # def read : LibC::Int
    #  LibC._ZN14HardwareSerial4readEv(@this)
    # end

    # @[AlwaysInline]
    # def flush : LibC::Int
    #  LibC._ZN14HardwareSerial5flushEv(@this)
    # end

    # @[AlwaysInline]
    def write(b : UInt8) : SizeT
      LibC._ZN14HardwareSerial5writeEh(@this, b)
    end

    # @[AlwaysInline]
    # def write(n : LibC::Long | LibC::ULong | LibC::Int | LibC::UInt) : LibC::SizeT
    #  write n.to_u8!
    # end
  end

  Serial = HardwareSerial.new(pointerof(LibC.serial))
end
