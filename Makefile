run-inputconditioner: build-inputconditioner
	./inputconditioner.o

build-inputconditioner:
	iverilog -Wall -o inputconditioner.o inputconditioner.t.v

run-shiftregister: build-shiftregister
	./shiftregister.o

build-shiftregister:
	iverilog -Wall -o shiftregister.o shiftregister.t.v

build-midpoint:
	iverilog -Wall -o midpoint.o midpoint.v

clean:
	rm *.o *.out *.vcd
