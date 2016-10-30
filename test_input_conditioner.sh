#!/bin/bash

#Run the tests
iverilog -o testConditioner inputconditioner.t.v inputconditioner.v
./testConditioner 
rm inputconditioner.vcd	#remove unwanted files
rm inputconditioner.t