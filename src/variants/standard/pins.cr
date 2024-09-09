module Arduino
  NUM_DIGITAL_PINS  = 20
  NUM_ANALOG_INPUTS =  6

  SS   = 10_u8
  MOSI = 11_u8
  MISO = 12_u8
  SCK  = 13_u8

  SDA         = 18_u8
  SCL         = 19_u8
  LED_BUILTIN = 13_u8

  A0 = 14_u8
  A1 = 15_u8
  A2 = 16_u8
  A3 = 17_u8
  A4 = 18_u8
  A5 = 19_u8
  A6 = 20_u8
  A7 = 21_u8

  macro analogInputToDigitalPin(p)
    {{p}} < 6_u8 ? {{p}} &+ 14_u8 : -1_u8
  end

  macro digitalPinHasPWM(p)
    {% if flag?(:atmega8) %}
      {{p}} == 9_u8 || {{p}} == 10_u8 || {{p}} == 11_u8
    {% else %}
      {{p}} == 3_u8 || {{p}} == 5_u8 || {{p}} == 6_u8 || {{p}} == 9_u8 || {{p}} == 10_u8 || {{p}} == 11_u8
    {% end %}
  end

  # TODO: digitalPinToPCICR, digitalPinToPCICRbit, digitalPinToPCMSK, digitalPinToPCMSKbit
  # TODO: ARDUINO_MAIN (requires PROGMEN aka addrspace(1) attribute aka @[AddressSpace(1)] annotation (?)
end
