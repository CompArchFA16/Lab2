Test Sequence
===

1. Press *Button 0* to reset the data in the shift register to *0xA5* (*0b10100101*).
2. Ensure the LEDs light up to show: *10100101*
3. Set *Switch 0* to *1*.
4. Toggle *Switch 1* high and then low.
5. Check LEDs to light up with *01001011*
6. Set *Switch 0* to *0*.
7. Toggle *Switch 1* high and then low.
8. Check LEDs to light up with *10010110*
9. Press *Button 0* to reset the data again.
10. Ensure the LEDs light up to show: *10100101*

We have now tested all functionality of the FPGA.


Video
===
Video is in *midpoint_test.MOV* and goes through the test sequence labeled above, but only showing the lowest 4 bits.
