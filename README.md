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
An Overflow was attempted to be implemented with a statement that gave overflow if the addition of 2 positive numbers yielded a negative or the addition of 2 negative numbers yeilded a positive. This implementation was unsucessfull in detecting an overflow of two big numbers such as 8 and 8.
```VHDL
Overflow <= (A(3)and B(3) and (not sumInput(3)) and (not SubSwitch)) 
				or ((not A(3)) and (not B(3)) and sumInput(3) and (not SubSwitch));
```

Once the syntax was ironed out, a .ucf file was created then the code was uploaded to the FPGA and tested for functionality.

[![Adder Test](http://img.youtube.com/vi/rA5CHW5-bmc/0.jpg)](http://www.youtube.com/watch?v=rA5CHW5-bmc)

The test was a success. From left to right the first four switches are A, the second four switched are B. The last four lights represent the answer and the first light comes on if there is an overflow.

#####Self-checking looping testbench
The testbench was the next challenge to overcome. The goal was to check all 255 possible cominations of 1s and 0s by looping through and adding 1 to A or B on every loop. Ulitmately the following code prooved successfull.

```VHDL
A <= "0000";
	  B <= "0000";
	  SubSwitch <= '0';
	  
	  for i in 0 to 15 loop
			
			for j in 0 to 15 loop

				wait for 10 ns; 
					
					assert(Sum = A+B) report "Expected Sum =  "& integer'image(to_integer(unsigned((A)))) & " + " & integer'image(to_integer(unsigned((B)))) & " = "& integer'image(to_integer(unsigned((A+B))))&
					"Actual Sum: " & integer'image(to_integer(unsigned(Sum))) severity ERROR;
					
					assert(Sum = A*B) report "A + B = " & integer'image(to_integer(unsigned((A)))) & " + " & integer'image(to_integer(unsigned((B)))) & " = " & integer'image(to_integer(unsigned(Sum))) & " CORRECT!!" severity note;
					
					B <= B + "0001";
			end loop;
			
			A <= A + "0001";
		end loop;
```
The testbench was able to check itself using the ieee.std_logic_unsigned.ALL library. The output of the testbench looked as follows
![alt tag](https://raw.github.com/EricWardner/ECE281_Lab2/master/Lab2tbCapture.png)

#####Adding Subtraction Funcionality
Adding the subtraction functionality prooved to be an interesting challenge. It was known that a way to subtract binary numbers is to add the two's compliment of one number to the other. This was the strategy ultimately implemented. By creating a new component (a multiplexer) the FPGA was given the ability to convert the B input to it's twos complimetn at the press of a button. By pressign the button the Cin (carry in) value became a 1, which was added to the B logic vector as "0001" after B ahd been inverted. The code for the multiplexer looked as follows:
```VHDL
if Subber = '0' then
	O <= Input;
			
else
	O <= not Input;
		
end if;
```

When implemented with the rest of the components in the "Full_Adder" file, the final schematic appeared as follows
![alt tag](https://raw.github.com/EricWardner/ECE281_Lab2/master/finalSchematicLab2.jpg)

#####Testing and Debugging
Multiple problems occured in all levels of the design process

When creating the self checking test bench it took a bit of time to realize I was not using the sessecary library to preform addition and subtraction oporations (ieee.std_logic_unsigned.ALL). This problem was solved with google.

Initially the testbench did not give any output when something was correct. This was fixed by adding an assert("something untrue") statement and then the desired output.

Syntax was always an issue, I found it important to always check parenthesis and semi colons. 

An interesting feature was implemented with the subtraction operation. When a subtraction operation yields a positive number, the same light the overflow indicator is on will turn on. If the subtraction operation yields a negative number, it will turn off. 

Ultimately both the addition and subtraction tests were sucessfull. The self checking testbench appeared to work in testing all values. 

The overflow did not work completely it only detected overflow when the addition of two negative numbers yielded a positive

#####Documentation
http://www.seas.upenn.edu/~ese171/vhdl/VHDLTestbench.pdf - referenced for help with the looping testbench
http://www.cs.uregina.ca/Links/class-info/301/multiplexer/lecture.html - referenced for multiplexer implementation
C3C Taylor Boden explained why a mux was nessecary for implementation of the subtractor
C3C Tyler Spence helped with syntax issues 
