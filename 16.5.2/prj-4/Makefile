all: sum.out

sum.out: sum.asm
	yasm -Worphan-labels -g dwarf2 -f elf64 sum.asm -l sum.lst
	ld -g -o sum.out sum.o

clean:
	rm *.lst *.o *.out

