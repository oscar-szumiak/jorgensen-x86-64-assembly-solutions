all: main.out

main.out: buffering.o main.o
	ld -g -o main.out main.o buffering.o

main.o: main.asm
	yasm -g dwarf2 -f elf64 main.asm -l main.lst

buffering.o: buffering.asm
	yasm -g dwarf2 -f elf64 buffering.asm -l buffering.lst

clean:
	rm -v *.lst *.o *.out

