# Calorimeter
A pipelined SPARCv9 simulator based on the specs of a Sun Blade 100

"A calorimeter is a device used for calorimetry, or the process of measuring the heat of chemical reactions or physical changes as well as heat capacity." - https://en.wikipedia.org/wiki/Calorimeter

In layman's terms, a calorimeter is a big ol' box you burn stuff in that you use to measure how much energy that stuff releases.

## Sources of Truth
https://www.cs.utexas.edu/~novak/sparcv9.pdf
https://en.wikipedia.org/wiki/SPARC
https://static.aminer.org/pdf/PDF/000/109/980/ultrasparc_ii_the_advancement_of_ultracomputing.pdf
https://www.oracle.com/servers/technologies/opensparc-overview.html
https://docs.oracle.com/cd/E19127-01/blade100.ws/816-1796-13/816-1796-13.pdf


I don't know how I'm gonna use all of this but I think it'll be useful to have them here for now

## Motivation and Inspiration
I've decided to start this portion of the crate-motor project as a way to simulate the SPARC processor in Swift. Though I have access to physical hardware, getting a program onto the machine is a bit of a pain.

My inspiration for this project is my current work in CMSC411, where we are implementing a pipelined MIPS simulator (another RISC architecture of similar vintage to SPARC.)