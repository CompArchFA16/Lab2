 #! /bin/bash
iverilog -Wall -o spi spimodule.t.v
./spi
gtkwave spi.vcd 