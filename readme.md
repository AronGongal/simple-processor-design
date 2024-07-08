# Simple Processor Design


## Description
This is a simple multicycle processor design made for a college computer architecture course. The design was written in the hardware description language Verilog, and simulated using Icarus Verilog and GTKWave. It implements a custom instruction set architecture based on MIPS.

The multicycle architecture involves executing each instruction in a multiple clock cycles, rather than in one long cycle. This is more efficient than a single-cycle architecture, but less efficent than a pipelined architecture, which most modern processors use.

The processor consists of memory, which stores data and program instructions, and a CPU, which processes data as specified from the instructions. The CPU itself is made up of a datapath, which performs various computing operations, and a control unit that determines the exact flow of data through the datapath.

The instructions that the processor executes can involve arithmetic/logic operations, reading/writing from memory, and jumping to other instructions of a program. Each program was written in assembly, then manually translated to binary.

The CPU and memory modules are connected in a top module, and the module for each program instantiates the top module with the specified instruction and data files. Each module is represented with its own Verilog file (e.g. `cpu.v` and `top.v`).

Two sample programs are included with the source code. Program 1 simply performs addition of two values and places the result in another register. The provided data file has integers 20 and 22 for a sum of 42. Program 2 iterates through a `for` loop from value 0 to 10, adding the iterator value to a variable at every iteration for a result of 55.


## Installation
You will need Icarus Verilog to compile each program.

To compile a program, execute this command:

```% iverilog -o <program>.vvp <program>.v```

where <program> is the name of either one of the provided sample programs, `program1` and `program2`.


## Usage
To view the waveforms of the results, you will need GTKWave.

Run each vvp file with this command:

```% vvp <program>.vvp```

Then view the dumped waveforms using this command:

```% gtkwave <program>.vcd```


## Credits
Created by Aron Gongal

Thanks to *Digital Design and Computer Architecture* by Harris and Harris for helping with completing the project.


## License
Licensed under the GNU General Public License v3.0.
