# CompArch Fall 2016 Lab 2 Midpoint Checkin
*Katie Hite, William Lu, and Ian Hill*

### Test sequence
- Load bitstream to FPGA: LEDs should read `0000`
- Parallel Load: LEDs should read `0101`
- Load bit 1: LEDs should read `1011`
- Load bit 1: LEDs should read `0111`
- Load bit 1: LEDs should read `1111`
- Load bit 1: LEDs should read `1111`
- Load bit 0: LEDs should read `1110`
- Load bit 0: LEDs should read `1100`
- Load bit 0: LEDs should read `1000`
- Load bit 0: LEDs should read `0000`
- Load bit 1: LEDs should read `0001`
- Load bit 0: LEDs should read `0010`
- Load bit 1: LEDs should read `0101`
- Load bit 0: LEDs should read `1010`
- Parallel Load: LEDs should read `0101`

### Explaination
This simple sequence provides a cursory test that:
- the input conditioner debounces the input from the button and the switches
- the input conditioner properly registers a positive and negative clock edge
-  the input conditioner (probably) synchronizes its input to the internal clock
-  the shift register can accept a constant to load in parallel
-  the shift register only accepts serial input when the peripheral clock edge is high
-  the shift register properly accepts serial input
-  the shift register outputs the expected values for the first 4 bits of its 8 bit bus

### Video
[Test Sequence Video](https://youtu.be/JxTmxKwu8cY)