# TODO: consider implementing custom primitives that would enable, or disable,
# some default behavior, such as checked math overflows, or cross integer bit
# sizes arithmetic, etc.
require "primitives"
require "intrinsics"

require "nano/char"
require "nano/enum"
require "nano/float"
require "nano/int"
require "nano/nil"
require "nano/number"
require "nano/object"
require "nano/pointer"
require "nano/range"
require "nano/slice"
require "nano/static_array"
require "nano/string"

# require "nano/errno"
# require "nano/exception"
# require "nano/panic"

lib LibC
  fun __crystal_main(Int32, Char*)
  fun abort : NoReturn
end

module Arduino
end

# Prints *message* to the serial console (if available) then enters an infinite
# loop, optionally blinking the internal led *blink* times repeatedly.
def panic!(message : String, blink : Int32 = 0) : NoReturn
  {% if Arduino.has_constant?(:Serial) %}
    Arduino::Serial.println '\n'
    Arduino::Serial.print "panic: "
    Arduino::Serial.println message
  {% end %}

  {% if Arduino.has_constant?(:LED_BUILTIN) %}
    if blink > 0
      while true
        3.times do
          Arduino.delay 250
          Arduino.digitalWrite(Arduino::LED_BUILTIN, Arduino::LOW)
          Arduino.delay 250
          Arduino.digitalWrite(Arduino::LED_BUILTIN, Arduino::HIGH)
        end
        Arduino.delay 1500
        Arduino.digitalWrite(Arduino::LED_BUILTIN, Arduino::LOW)
      end
    end
  {% end %}

  LibC.abort
end

fun __crystal_raise_overflow : NoReturn
  panic! "math overflow"
end
