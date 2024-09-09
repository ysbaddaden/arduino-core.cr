module Arduino
  def self.setup : Nil
    # initialize digital pin LED_BUILTIN as an output.
    pinMode(LED_BUILTIN, OUTPUT)
  end

  # the loop function runs over and over again forever
  def self.loop : Nil
    digitalWrite(LED_BUILTIN, HIGH) # turn the LED on (HIGH is the voltage level)
    delay(1000)                     # wait for a second
    digitalWrite(LED_BUILTIN, LOW)  # turn the LED off by making the voltage LOW
    delay(1000)                     # wait for a second
  end
end
