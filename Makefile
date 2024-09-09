# https://dev.to/creativcoder/how-to-run-rust-on-arduino-uno-40c0
# https://hardwarefun.com/tutorials/compiling-arduino-sketches-using-makefile
# https://atadiat.com/en/e-arduino-core-source-files-make-new-core-building-steps/
#
# https://github.com/Optiboot/optiboot
# https://github.com/sudar/Arduino-Makefile

.POSIX:

# BOARD (Arduino UNO)
ARDUINO_BOARD=uno
MCU=avr5
MCPU=atmega328p
F_CPU=16000000L
VARIANT=standard
# ARDUINO_ARCH_<build.arch>
# ARDUINO_<build.board>

# ARDUINO CORE
ARDUINO=105
ARDUINO_DIR=/usr/share/arduino
ARDUINO_CORE_DIR=$(ARDUINO_DIR)/hardware/arduino/cores/arduino
ARDUINO_VARIANT_DIR=$(ARDUINO_DIR)/hardware/arduino/variants/$(VARIANT)

# SOFTWARE
AR=avr-ar
CC=avr-gcc
CRYSTAL=../crystal/.build/crystal
CXX=avr-g++
OBJCOPY=avr-objcopy
RANLIB=avr-ranlib
STRIP=avr-strip

# FLAGS
ARDUINO_FLAGS=-mmcu=$(MCPU) -DF_CPU=$(F_CPU) -DARDUINO=$(ARDUINO)
CFLAGS=-I$(ARDUINO_CORE_DIR) -I$(ARDUINO_VARIANT_DIR) -Os -ffunction-sections -fdata-sections
CXXFLAGS=-I$(ARDUINO_CORE_DIR) -I$(ARDUINO_VARIANT_DIR) -Os -ffunction-sections -fdata-sections -fno-threadsafe-statics -fno-devirtualize
LDFLAGS=-Os -mmcu=$(MCPU) -Wl,--gc-sections # -Wl,--print-gc-sections
CRFLAGS=--prelude=../src/boards/$(ARDUINO_BOARD) --target=avr-unknown-unknown --mcpu=$(MCPU) --no-debug -Oz --single-module

# ARDUINO CORE
ARDUINO_CORE_OBJECTS=build/new.o build/avr-libc/malloc.o build/avr-libc/realloc.o build/main.o \
                     build/wiring_analog.o build/wiring.o build/wiring_digital.o build/wiring_pulse.o \
                     build/wiring_shift.o build/WInterrupts.o build/CDC.o build/HardwareSerial.o \
                     build/HID.o build/IPAddress.o build/Print.o build/Stream.o build/Tone.o \
                     build/USBCore.o build/WMath.o build/WString.o

all: samples/blink.hex samples/analog_read_serial.hex

# extract hex file for upload (e.g. avrdude)
samples/%.hex: samples/%.elf
	#$(OBJCOPY) -j .text -j .data -O ihex $< $@
	$(OBJCOPY) -O ihex $< $@

# link elf files
samples/%.elf: samples/%.o libarduino-core.a
	$(CC) $(LDFLAGS) -o $@ $< libarduino-core.a -lc -lm

# Crystal
samples/%.o: samples/%.cr
	CRYSTAL_PATH=lib:../src $(CRYSTAL) build --cross-compile $(CRFLAGS) $< -o $@

# compile the arduino-core library
libarduino-core.a: $(ARDUINO_CORE_OBJECTS)
	$(AR) rcs libarduino-core.a $(ARDUINO_CORE_OBJECTS)
	$(RANLIB) libarduino-core.a

# C
#recipe.c.o.pattern="{compiler.path}{compiler.c.cmd}" {compiler.c.flags} -mmcu={build.mcu} -DF_CPU={build.f_cpu} -DARDUINO={runtime.ide.version} -DARDUINO_{build.board} -DARDUINO_ARCH_{build.arch} {compiler.c.extra_flags} {build.extra_flags} {includes} "{source_file}" -o "{object_file}"
build/%.o: $(ARDUINO_CORE_DIR)/%.c
	$(CC) -c $(ARDUINO_FLAGS) $(CFLAGS) $< -o $@

# C++
#recipe.cpp.o.pattern="{compiler.path}{compiler.cpp.cmd}" {compiler.cpp.flags} -mmcu={build.mcu} -DF_CPU={build.f_cpu} -DARDUINO={runtime.ide.version} -DARDUINO_{build.board} -DARDUINO_ARCH_{build.arch} {compiler.cpp.extra_flags} {build.extra_flags} {includes} "{source_file}" -o "{object_file}"
build/%.o: $(ARDUINO_CORE_DIR)/%.cpp
	$(CXX) -c $(ARDUINO_FLAGS) $(CXXFLAGS) $< -o $@

# ASM
#recipe.S.o.pattern="{compiler.path}{compiler.c.cmd}" {compiler.S.flags} -mmcu={build.mcu} -DF_CPU={build.f_cpu} -DARDUINO={runtime.ide.version} -DARDUINO_{build.board} -DARDUINO_ARCH_{build.arch} {compiler.S.extra_flags} {build.extra_flags} {includes} "{source_file}" -o "{object_file}"
#build/%.o: $(ARDUINO_CORE_DIR)/%.S

# C (samples)
%.o: %.c
	$(CC) -c $(ARDUINO_FLAGS) $(CFLAGS) $< -o $@

# CPP (samples)
%.o: %.cpp
	$(CXX) -c $(ARDUINO_FLAGS) $(CXXFLAGS) -o $@ $<

%.elf: %.o libarduino-core.a
	$(CC) $(LDFLAGS) -o $@ $< libarduino-core.a -lc -lm

clean: .phony
	rm -f libarduino-core.a build/*.o samples/*.o samples/*.elf samples/*.hex

.phony:
