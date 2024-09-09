require "./lib_c"
require "./lib_crystal"
require "./main"

lib LibC
  # fun init()

  fun pinMode(UInt8, UInt8)
  fun digitalWrite(UInt8, UInt8)
  fun digitalRead(UInt8) : Int
  fun analogRead(UInt8) : Int
  fun analogReference(UInt8)
  fun analogWrite(UInt8, Int)

  fun millis : ULong
  fun micros : ULong
  fun delay(ULong)
  fun delayMicroseconds(UInt)
  fun pulseIn(UInt8, UInt8, ULong) : ULong

  fun shiftOut(UInt8, UInt8, UInt8, UInt8)
  fun shiftIn(UInt8, UInt8, UInt8) : UInt8

  fun attachInterrupt(UInt8, Proc(Nil), Int)
  fun detachInterrupt(UInt8)

  # fun setup()
  # fun loop()
end

module Arduino
  # alias Int = LibC::Int
  # alias UInt = LibC::UInt
  alias SizeT = LibC::SizeT
  alias Long = LibC::Long
  alias ULong = LibC::ULong
  alias Float = LibC::Float
  alias Double = LibC::Double

  HIGH = 1_u8
  LOW  = 0_u8

  INPUT        = 0_u8
  OUTPUT       = 1_u8
  INPUT_PULLUP = 2_u8

  PI         =   3.1415926535897932384626433832795_f32
  HALF_PI    =   1.5707963267948966192313216916398_f32
  TWO_PI     =    6.283185307179586476925286766559_f32
  DEG_TO_RAD = 0.017453292519943295769236907684886_f32
  RAD_TO_DEG =   57.295779513082320876798154814105_f32

  SERIAL  = 0
  DISPLAY = 0

  LSBFIRST = 0
  MSBFIRST = 1

  CHANGE  = 1
  FALLING = 2
  RISING  = 3

  {% if flag?(:attiny24) || flag?(:attiny44) || flag?(:attiny84) || flag?(:attiny25) || flag?(:attiny45) || flag?(:attiny85) %}
    DEFAULT  = 0
    EXTERNAL = 1
    INTERNAL = 2
  {% else %}
    {% if flag?(:atmega1280) || flag?(:atmega2560) || flag?(:atmega1284) || flag?(:atmega1284p) || flag?(:atmega644) || flag?(:atmega644a) || flag?(:atmega644p) || flag?(:atmega644ap) %}
      INTERNAL1V1 = 2
      INTERNAL2V56 = 3
    {% else %}
     INTERNAL = 3
    {% end %}

    DEFAULT = 1
    EXTERNAL = 0
  {% end %}

  NOT_A_PIN  = 0
  NOT_A_PORT = 0

  {% if flag?(:ARDUINO_MAIN) %}
    PA =  1
    PB =  2
    PC =  3
    PD =  4
    PE =  5
    PF =  6
    PG =  7
    PH =  8
    PJ = 10
    PK = 11
    PL = 12
  {% end %}

  NOT_ON_TIMER =  0
  TIMER0A      =  1
  TIMER0B      =  2
  TIMER1A      =  3
  TIMER1B      =  4
  TIMER2       =  5
  TIMER2A      =  6
  TIMER2B      =  7
  TIMER3A      =  8
  TIMER3B      =  9
  TIMER3C      = 10
  TIMER4A      = 11
  TIMER4B      = 12
  TIMER4C      = 13
  TIMER4D      = 14
  TIMER5A      = 15
  TIMER5B      = 16
  TIMER5C      = 17

  CLOCK_CYCLES_PER_MICROSECOND = F_CPU / 1_000_000

  macro clockCyclesPerMicrosecond
    CLOCK_CYCLES_PER_MICROSECOND
  end

  macro clockCyclesToMicroseconds(a)
    {{a}} / CLOCK_CYCLES_PER_MICROSECOND
  end

  macro microsecondsToClockCycles(a)
    {{a}} * CLOCK_CYCLES_PER_MICROSECOND
  end

  @[AlwaysInline]
  def pinMode(pin : UInt8, mode : UInt8)
    LibC.pinMode(pin, mode)
  end

  @[AlwaysInline]
  def digitalWrite(pin : UInt8, val : UInt8)
    LibC.digitalWrite(pin, val)
  end

  @[AlwaysInline]
  def digitalRead(pin : UInt8) : LibC::Int
    LibC.digitalRead(pin, val)
  end

  @[AlwaysInline]
  def analogRead(pin : UInt8) : LibC::Int
    LibC.analogRead(pin)
  end

  @[AlwaysInline]
  def analogReference(mode : UInt8)
    LibC.analogReference(mode)
  end

  @[AlwaysInline]
  def analogWrite(pin : UInt8, val : LibC::Int)
    LibC.analogWrite(pin, val)
  end

  @[AlwaysInline]
  def millis : ULong
    LibC.millis
  end

  @[AlwaysInline]
  def micros : ULong
    LibC.micros
  end

  @[AlwaysInline]
  def delay(ms : ULong)
    LibC.delay(ms)
  end

  @[AlwaysInline]
  def delayMicroseconds(us : LibC::UInt)
    LibC.delay(us)
  end

  @[AlwaysInline]
  def pulseIn(pin : UInt8, state : UInt8, timeout : ULong) : ULong
    LibC.pulseIn(pin, state, timeout)
  end

  @[AlwaysInline]
  def shiftOut(dataPin : UInt8, clockPin : UInt8, bitOrder : UInt8, val : UInt8)
    LibC.shiftOut(dataPin, clockPin, bitOrder, val)
  end

  @[AlwaysInline]
  def shiftIn(dataPin : UInt8, clockPin : UInt8, bitOrder : UInt8) : UInt8
    LibC.shiftIn(dataPin, clockPin, bitOrder)
  end

  @[AlwaysInline]
  def attachInterrupt(interruptNum : UInt8, userfunc : Proc(Nil), mode : Int)
    LibC.attachInterrupt(interruptNum, userfunc, mode)
  end

  @[AlwaysInline]
  def detachInterrupt(interruptNum : UInt8)
    LibC.detachInterrupt(interruptNum)
  end
end
