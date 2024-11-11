all: cmd-line-args.out cmd-line-args-corrected.out

cmd-line-args.out: cmd-line-args.asm
	yasm -Worphan-labels -g dwarf2 -f elf64 cmd-line-args.asm -l cmd-line-args.lst
	gcc -g -no-pie -o cmd-line-args.out cmd-line-args.o

cmd-line-args-corrected.out: cmd-line-args-corrected.asm
	./../../asm64 cmd-line-args-corrected

clean:
	rm *.lst *.o *.out

