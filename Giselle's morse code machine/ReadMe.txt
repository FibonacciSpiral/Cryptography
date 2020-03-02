These project files contain everything you need to instantiate and use the morse code machine.
The wrapper file just ties all the inputs and output to the actual ports on the DE1Soc so if you 
aren't using a DE1Soc, then don't worry about Wrapper. MorseCodeTA is actually the control module,
it instantiates and controls the other modules. If you just want to play with the morse code machine,
then simply instantiate MorseCodeTA and pass in the desired inputs and outputs.

If you're curious about how the morse code pattern is determined, then check out PatternMux.

This machine can output every letter of the alphabet. I hope you like it!

*Also this machine requires a 50 MHz clock as an input. In my FPGA, this clock is called CLOCK_50.
Xylinx probably has a clock like this as well.