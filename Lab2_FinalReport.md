# Lab 2 Computer Architecture Report


## Input Conditioner


### Test Bench Explanation
The purpose of the input conditioner is to take a signal from a button or switch and clean it up enough to be read without noise by the system. It also detects the rising edge and falling edge of the input signal and sends flags to other parts of the circuit based on these signals. In order to test the input conditioner, we looked at 3 cases. The first case was a test to see whether or not the circuit would let several inputs in short succession through the circuit. If the circuit had an output that wasn’t zero, this test would fail. Luckily, it passed, and showed that the counter and circuit works. The second case is when the button is not pressed long enough. For this, we sent an input signal in that was much shorter than the counter. If our input conditioner is working, we expect no output signal because it would have been interpreted as noise. The third case is a test to see if the rising edge and falling edge signals are actually synchronized with the output signal. To test this, we sent an input signal through the circuit and checked if the other signals matched when the output began/ended. This passed.


### Wait Time Analysis


Given that the clock is 50 MHz = 50 * 10^6 Hz
And given that the wait time is unit 10


How long in seconds will it take until we reach the wait time with our clock?


1s/(50 x 10^6) cycles * 10 cycles = 1s/(5 x 10^6) = 0.2 us


### Circuit Diagram


![Input Conditioner Circuit Diagram](https://github.com/tj-kim/Lab2/blob/master/input_conditioner.jpg)


## Shift Register


### Test Bench Explanation


The test bench execution for the shift register was very similar to that of HW 4 with test case passes. We also implemented previous table test bench styles, to give users of the test bench more insight in potential errors. We make an assumption that the initial condition of the shift register memory is ‘xxxxxxxx’ with wires without a known value. 


The first test case just examines the initial condition of the shift register. If all the values stored in the shift register memory are unidentifiable, it will pass.


The second test case tests if we can advance peripheralClkEdge by 1, and put 1 in the LSB of the shift register memory. This tests that the shift register advances by 1 properly, and can input a 1. Also we know that the parallelout output functions correctly.


The third test case sets a parallelinput, but has parallelload off. So the shiftregister memory should not change from test case 2. We are testing if parallelload functions properly.


The fourth test case is the same as the third test case except parallelload is 1. We should load the correct value into the shift register memory and output it in parallelout. Serialout should also have the corresponding value now.


The fifth test case just proves that we can advance peripheralClkEdge again and input a 1 to the LSB. We want to see if this functions if parallel load is off, and all wires in the shift register memory already have a value from the previous iteration.
The sixth test case tests the same thing as test case 5, but checks we can input a 0 to the LSB while peripheralClkEdge shifts the memory.


The seventh test case is an important one. We designed our shift register so that when peripheralClkEdge and Parallelload were both asserted, Parallelload would have priority. Here we do that and checks if the previous setup holds true.


The eighth and last test case is a redundant one, but checks if we can input 1 to the LSB once again while peripheral clock goes.




## SPI Memory
Using the provided schematic, we created a new module for the SPI memory. In order to correctly enable certain elements of the system, we created a finite state machine that changes state based on the input conditions. For instance, the tri-state buffer before the output pin should only be enabled during a read operation.


### Finite State Machine
As part of our test plan, we first made sure that the FSM worked as specified in the diagram. We wrote a simple test bench that writes 0xFF to the address 0x7F (seven 1s) and checked that each state triggered the correct output pins.


#### Write To SPI
We checked this by looking at the outputs of GTKWave.


![Write to SPI](https://github.com/tj-kim/Lab2/blob/master/images/fsm_write.png)



When the Read flag is OFF, the FSM correctly iterates through the “Write” portion of the FSM. The process is: Get, Got, Write1 (times 8), Write2, Done.


![Got](https://github.com/tj-kim/Lab2/blob/master/images/fsm_got.png)


*Get*


* Next State = Got (if counter = 8)
* Triggered Outputs = (none)


*Got*


* Next State = Write1 (if Read = OFF)
* Triggered Outputs = counter_reset, ADDR_WE

![Write1](https://github.com/tj-kim/Lab2/blob/master/images/fsm_write1.png)



*Write1*


* Next State = Write2 (if counter = 8)
* Triggered Outputs = (none)


![Write2](https://github.com/tj-kim/Lab2/blob/master/images/fsm_write2_done.png)



*Write2*


* Next State = Done
* Triggered Outputs = DM_WE


*Done*


* Next State = Get (if RESET)
* Triggered Outputs = counter_reset


#### Read From SPI


![Read From SPI](https://github.com/tj-kim/Lab2/blob/master/images/fsm_read.png)



When the Read flag is ON, the FSM iterates through the “Read” portion of the FSM. The process is: Get, Got, Read1, Read2, Read3 (times 8), Done.


![Read12](https://github.com/tj-kim/Lab2/blob/master/images/fsm_read12.png)



*Get*


* Next State = Got (if counter = 8)
* Triggered Outputs = (none)


*Got*


* Next State = Read1 (if Read = ON)
* Triggered Outputs = counter_reset, ADDR_WE


*Read1*


* Next State = Read2
* Triggered Outputs = (none)


*Read2*


* Next State = Read3
* Triggered Outputs = SR_WE


![Read3](https://github.com/tj-kim/Lab2/blob/master/images/fsm_read3_done.png)


*Read3*


* Next State = Done (if counter = 8)
* Triggered Outputs = MISO_BUFF


*Done*


* Next State = Get (if RESET)
* Triggered Outputs = counter_reset


### Full System in Verilog
We then put the pieces together, as recommended by the diagram, and we tested some simple cases in Verilog. We assumed that the intermediate modules (Input Conditioner, Shift Register, Data Memory, Tri-State Buffer) were all tested thoroughly and decided not to test these any further. Since many of the tests would eventually be written in C, we only tested one Read/Write operation before loading the program to the FPGA.


#### Chip Select
When the chip select pin is high, the output should always be Z. We added a check at the beginning of the program that makes sure this is always true.


#### Write Operation

![SPI Write](https://github.com/tj-kim/Lab2/blob/master/images/spi_write.png)

In this scenario, the two MOSI bits were 8’b10101010 (address = 0x55 and Read = OFF) and 8’b11001010 (value = 0xCA). When the counter reaches 8 the first time, the address becomes 0x55, and when the counter reaches 8 again, the data memory outputs 0xCA. Also, MISO should not output any values during this operation.


#### Read Operation

![SPI Read](https://github.com/tj-kim/Lab2/blob/master/images/spi_read.png)

We read from the register that was just written to (0x55), and got the value that we originally inputted (0xCA). The binary representation (8’b11001010) is then outputted to MISO.


### Full System on FPGA
We uploaded our schematic to the hardware, and used the test cases below. We wrote code in C to automate this test pattern.

* Write 0xCA to 0x55, read from 0x55
* Write a different value to 0x55, read again to make sure data was overwritten
* Write 8’b11111111 to 7’b1111111, read from 7’b1111111

For the first test, we got the following outputs from our code:

![First Test Outputs](https://github.com/tj-kim/Lab2/blob/master/images/test_variables.png)




## Work Plan Analysis
The work plan helped our team a lot, as we stuck to it pretty accurately during the entire span of this lab. We wrote components of the report as soon as we completed the relevant part. For example, we designed the circuit diagram and test case explanations as soon as we completed the inputconditioner portion. We did not work a lot during Wednesday to Thursday as work from other classes were piling and there was an extension, but we simply delayed the work plan by 2 days and stuck to it. 
