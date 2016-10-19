all : inputconditioner.o shiftregister.o midpoint.o

inputconditioner.o : inputconditioner.v inputconditioner.t.v
	iverilog inputconditioner.t.v -o inputconditioner.o

shiftregister.o : shiftregister.v shiftregister.t.v
	iverilog shiftregister.t.v -o shiftregister.o

midpoint.o : midpoint.v
	iverilog midpoint.v -o midpoint.o
