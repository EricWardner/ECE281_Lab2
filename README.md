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
