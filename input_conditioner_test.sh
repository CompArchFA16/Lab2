#!/bin/bash
iverilog -o input_conditioner_test inputconditioner.t.v
./input_conditioner_test
gtkwave inputconditioner.vcd