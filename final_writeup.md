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

To test the SPI memory on the FPGA, we would write a for loop to write and read a different value to every byte of the datamemory, to ensure that all bytes are working. However, we could not get the memory properly working on the FPGA, so we could not actually perform this testing.


## Reflection / Analysis

We overestimated the time for the begining parts of the project. The input conditioner and shift register were slightly faster than we thought initially. The SPI mememory and FSM were much slower than we thought. We continually ran into errors and have been struggling to get the last parts to play nicely together. We also need to change from the reccomended circuit diagram which took some time. We've also stuggled for a long time with the FPGA and loading our code onto it.

We relied too heavily on the supplied FSM and circuit diagram, which made our implementation for the FSM extremely tricky. After spending too much time trying to get the suggested version working, we decided to design our own. This version ran into issues because it relied on SCLK, instead of CLK, because the recommended schematic did not include CLK input for the FSM. This was rather frustrating for us because we spent more time than we should have trying to implement the FSM in the way that we thought was expected. 

Lastly, getting the FPGA working was incredibly frustrating because it did not work for any good reasons. We suspect it had to do with the computer we were testing on.
