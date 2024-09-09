module Arduino
  extend self

  # the setup routine runs once when you press reset
  def setup : Nil
  end

  # the loop function runs over and over again forever
  def loop : Nil
  end
end

# :nodoc:
fun setup : Nil
  LibC.__crystal_main(0, ::Pointer(LibC::Char).null)
  Arduino.setup
end

# :nodoc:
fun loop : Nil
  Arduino.loop
end
