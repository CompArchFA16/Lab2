all : inputconditioner.o shiftregister.o midpoint.o spimemory.o

inputconditioner.o : inputconditioner.v inputconditioner.t.v
	iverilog inputconditioner.t.v -o inputconditioner.o

shiftregister.o : shiftregister.v shiftregister.t.v
	iverilog shiftregister.t.v -o shiftregister.o

midpoint.o : midpoint.v
	iverilog midpoint.v -o midpoint.o

spimemory.o : spimemory.v spimemory.t.v *.v
	iverilog spimemory.t.v -o spimemory.o
