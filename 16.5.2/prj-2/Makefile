all: cmd-line-args-function.out

cmd-line-args-function.out: cmd-line-args-function.asm
	yasm -Worphan-labels -g dwarf2 -f elf64 cmd-line-args-function.asm -l cmd-line-args-function.lst
	ld -g -o cmd-line-args-function.out cmd-line-args-function.o

clean:
	rm *.lst *.o *.out

