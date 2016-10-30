#!/bin/bash

#Run the tests
iverilog -o testshiftregister shiftregister.t.v
./testshiftregister
rm shiftregister.vcd	#remove unwanted files
rm shiftregister.t