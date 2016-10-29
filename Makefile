# Variable definitions
CC=iverilog

# Recipes

all:
	echo "none"

inputconditioner: inputconditioner.t.v inputconditioner.v
	$(CC) $< && ./a.out

shiftregister: shiftregister.t.v shiftregister.v
	$(CC) $< && ./a.out

fsm: fsm.t.v fsm.v
	$(CC) $< && ./a.out

spimemory: spimemory.t.v spimemory.v
	$(CC) $< && ./a.out
	gtkwave spimemory_test.gtkw
