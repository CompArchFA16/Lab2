#!/bin/bash
iverilog -o ic_test inputconditioner.t.v
./ic_test
gtkwave inputconditioner.vcd