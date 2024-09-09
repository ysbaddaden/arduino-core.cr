require "../src/hardware_serial"

# AnalogReadSerial
#
# Reads an analog input on pin 0, prints the result to the Serial Monitor.
# Graphical representation is available using Serial Plotter (Tools > Serial Plotter menu).
# Attach the center pin of a potentiometer to pin A0, and the outside pins to +5V and ground.
#
# This example code is in the public domain.
#
# https://www.arduino.cc/en/Tutorial/BuiltInExamples/AnalogReadSerial
module Arduino
  def setup
    # initialize serial communication at 9600 bits per second
    Serial.begin(9600)
  end

  def loop
    sensorValue = analogRead(A0) # read the input on analog pin 0
    Serial.println(sensorValue)  # print out the value you read
    delay(1)                     # delay in between reads for stability
  end
end
