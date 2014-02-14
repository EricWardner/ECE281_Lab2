ECE281_Lab2
===========

Lab2

##PreLab

#####Truth Table

|  A B Cin |  Sum |Cout|
|:--:|:--: |:--:|
| 000  |  0|0|  
| 001  |  1|0|  
| 100  |  1|0| 
| 101  |  0|1|
| 010  |  1|0| 
| 011  |  0|1|
| 110  |  0|1|
| 111  |  1|1|

Sum = A'B'C + A'BC' + ABC + AB'C'
Cout = BC + AB + AC

#####Schematic
The schematic below represents the behavior of the VHDL code.
![alt tag](https://raw.github.com/EricWardner/ECE281_Lab2/master/Lab2Schematic.png)

Documentation - http://cs.smith.edu/ had a good example of the schematic

#####VHDL Code
Three STD_OUT signals were created for AB, BC, and AC. They were used to define Cout. The behavioral code looked as follows

```VHDL
begin
BC <= B and Cin;
AB <= A and B;
AC <= A and Cin;

Sum <= A xor B xor Cin;
Cout <= BC or AB or AC;

end Behavioral;
```
For the testbench, every possible combination of inputs was used to test the outputs. When comparing the output waveform to the initial truth table all outputs matched.

#####Testbench Output
![alt tag](https://raw.github.com/EricWardner/ECE281_Lab2/master/Lab2Capture.PNG)

######Debugging
When first creating the behavioral section I forgot to declare AB, BC, and AC signals which made the code not function. this problem could also have been aleviated by useing parenthasis when defining outputs ```VHDL Cout = (A and B) or (B and C) or (A and C) ```

When creating the Testbench the test inputs were defined wrong, rather than using "Cin", "C" was used.

Compenent's names cannot start with numbers

##Lab

####Design Process
The overarching goal of the lab was to implement the single bit adder from the prelab as a 4 bit adder device that could subtract and detect overflow.

The goal of implementing the single bit adder was acomplished using structural programming techniques. By making the single bit adder a component, it could be used 4 times to calculate the sum of two 4 bit binary numbers. The "Single_Bit_Adder" was created with three inputs (A, B, and Cin) and two outputs (Sum, Cout). The behavioral code for one of these single bit adder components looked as follows
```VHDL
architecture Behavioral of Single_Bit_Adder is

begin

Sum <= A xor B xor Cin;
Cout <= (B and Cin) or (A and B) or (A and Cin);

end Behavioral;
```

The next step was to chain together this Single_Bit_Adder component four times in an overall "Full_Adder" structural code. By chaining together the single bit adder components 4 times, a 4 bit addition could be calculated. The chain of components looked as follows
![alt tag](https://raw.github.com/EricWardner/ECE281_Lab2/master/StructureCapture.PNG)
```VHDL
	ZeroBit: Single_Bit_Adder PORT MAP(
		A => A(0),
		B => B(0),
		Cin => SubSwitch,
		Sum => Sum(0),
		Cout => Cout0
	);
	
	OneBit: Single_Bit_Adder PORT MAP(
		A => A(1),
		B => B(1),
		Cin => Cout0,
		Sum => Sum(1),
		Cout => Cout1
	);
	
	TwoBit: Single_Bit_Adder PORT MAP(
		A => A(2),
		B => B(2),
		Cin => Cout1,
		Sum => Sum(2),
		Cout => Cout2
	);

	ThreeBit: Single_Bit_Adder PORT MAP(
		A => A(3),
		B => B(3),
		Cin => Cout2,
		Sum => Sum(3),
		Cout => Overflow
	);
```
An Overflow was detected if there was any carry out for the most significant bit.

Once the syntax was ironed out, a .ucf file was created then the code was uploaded to the FPGA and tested for functionality.
[![Adder Test](http://img.youtube.com/vi/rA5CHW5-bmc/0.jpg)](http://www.youtube.com/watch?v=rA5CHW5-bmc)
The test was a success. From left to right the first four switches are A, the second four switched are B. The last four lights represent the answer and the first light comes on if there is an overflow.

#####Self-checking looping testbench
The testbench was the next challenge to overcome. 


