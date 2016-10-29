# Final Writeup

## Input Conditioner

### Structural Circuit for Input Conditioner

![InputConditioner](inputConditioner.png)

## Shift Register

### Testing Strategy

The testing strategy we used for our shift register was simply testing parallel load, then doing serial load for 8 bits, and then testing parallel load again. The reasoning for our test strategy is that it tests all major functionality of our shift register, and ensures that it does not get stuck in a state for any reason (ie. only able to parallel load, or only able to serial load).

We believe this sufficiently tests the shift register without exhaustively going through all different possibilities.

## SPI Memory

### Testing Strategy

The testing strategy we used for our SPI memory was to `write` to an address via SPI, and then to read from that address via SPI. We visually verified correct functionality using GTKWAVE, and using `make spimemory` will compile everything and pull up gtkwave with the required waveforms available.


## Reflection / Analysis

