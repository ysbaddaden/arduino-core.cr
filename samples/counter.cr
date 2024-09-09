require "../src/hardware_serial"

module Arduino
  @@counter = 0_i16

  def setup
    Serial.begin(9600)
  end

  def loop
    @@counter &+= 1_i16
    Serial.print("Counter: ")
    Serial.print(@@counter)
    Serial.println
    delay(50)
  end
end
