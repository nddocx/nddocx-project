all: compile run display
compile:
	iverilog tet.v
run:
	./a.out
display:
	gtkwave wave.vcd 
