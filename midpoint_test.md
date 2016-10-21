##Midpoint Check-in Test Sequence##

Test Sequence: https://www.youtube.com/watch?v=XQpx6vsjJXQ

```
Button0: ParallelLoad
Button1: shiftregistermem[7:4]
Button2: shiftregistermem[3:0]
Switch0: SerialDataIn
Switch1: PeripheralClkEdge
```

1. Press Button0 (serial in)
2. Set Switch0 high
3. Toggle Switch1 high to low
	"1" written to LED 0
4. Repeat 3 to serially write 1 bits into shiftregistermem
	"1" written to LED 0 while all bits shift to the left
5. Set Switch0 low
6. Toggle Switch1 high to low
	"0" written to LED 0
7. Repeat 6 to serially write 0 bits into shiftregistermem
	"0" written to LED 0 while all bits shift to the left
8. Press Button0 (parallel in) to write all data bits into shiftregistermem
	All LED bits reflect newly written 8 data bits	