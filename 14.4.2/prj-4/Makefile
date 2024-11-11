all: main.o stats.o
	gcc -g -no-pie -o main.out main.o stats.o

main.o: main.c
	gcc -g -Wall -c main.c

stats.o: stats.asm
	yasm -Worphan-labels -g dwarf2 -f elf64 stats.asm -l stats.lst

clean:
	rm -v *.lst *.o *.out

