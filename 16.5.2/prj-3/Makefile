all: cat.out

cat.out: cat.asm
	yasm -Worphan-labels -g dwarf2 -f elf64 cat.asm -l cat.lst
	ld -g -o cat.out cat.o

clean:
	rm *.lst *.o *.out

