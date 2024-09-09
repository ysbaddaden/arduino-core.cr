# Arduino

A shard to program Arduino boards and AVR microcontrollers in general with the
Crystal programming language.

## Status

Dump of an experimental build of the arduino core library + initial bindings.

## Requirements

Debian, Ubuntu and derivates:

```console
$ sudo apt install gcc-avr avr-libc avrdude arduino-core picocom
```

While picocom isn't required, it will be helpful for accessing the `Serial`
console.

## Usage

See `Makefile` to build `libarduino.a` from arduino-core for your board. The
Makefile is preconfigured for Ubuntu and the Arduino Uno board.

See `Makefile` and the `samples` folder for example programs based on the
official Arduino skteches.

## License

Distributed under the Apache-2.0 license.
