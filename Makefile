# Variable definitions
CC=iverilog

# Recipes

all:
	echo "none"

inputconditioner: inputconditioner.t.v inputconditioner.v
	$(CC) $< && ./a.out

shiftregister: shiftregister.t.v shiftregister.v
	$(CC) $< && ./a.out
