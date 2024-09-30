all: main.o stats.o
	ld -g -o main.out main.o stats.o

main.o: main.asm
	yasm -g dwarf2 -f elf64 main.asm -l main.lst

stats.o: stats.asm
	yasm -g dwarf2 -f elf64 stats.asm -l stats.lst

debug:
	gdb main.out < in.gdb

clean:
	rm -v *.lst *.o *.out out.txt

