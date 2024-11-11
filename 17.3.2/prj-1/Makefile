all: buffering.o

buffering.o: buffering.asm
	yasm -g dwarf2 -f elf64 buffering.asm -l buffering.lst

clean:
	rm -v *.lst *.o

