all: main.o stats.o stringHandling.o
	ld -g -o main.out main.o stats.o stringHandling.o

main.o: main.asm
	yasm -g dwarf2 -f elf64 main.asm -l main.lst

stats.o: stats.asm
	yasm -g dwarf2 -f elf64 stats.asm -l stats.lst

stringHandling.o: stringHandling.asm
	yasm -g dwarf2 -f elf64 stringHandling.asm -l stringHandling.lst

debug:
	gdb main.out < in.gdb

clean:
	rm -v *.lst *.o *.out out.txt

