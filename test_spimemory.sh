iverilog -o spimemory.t datamemory.v fsm.v inputconditioner.v shiftregister.v spimemory.v spimemory.t.v
./spimemory.t
rm ./spimemory.t
