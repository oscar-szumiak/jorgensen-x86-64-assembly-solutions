all: addLine.out

addLine.out: buffering.o addLine.o
	ld -g -o addLine.out addLine.o buffering.o

addLine.o: addLine.asm
	yasm -g dwarf2 -f elf64 addLine.asm -l addLine.lst

buffering.o: buffering.asm
	yasm -g dwarf2 -f elf64 buffering.asm -l buffering.lst

clean:
	rm -v *.lst *.o *.out

