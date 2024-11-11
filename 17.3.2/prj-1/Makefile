all: buffering.o

buffering.o: buffering.asm
	yasm -Worphan-labels -g dwarf2 -f elf64 buffering.asm -l buffering.lst

clean:
	rm -v *.lst *.o

