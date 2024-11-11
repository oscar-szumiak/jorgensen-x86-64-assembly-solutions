all: unsafe-read-string.out preinjected-code.out injectionCode.out

unsafe-read-string.out: unsafe-read-string.asm
	yasm -Worphan-labels -g dwarf2 -f elf64 unsafe-read-string.asm -l unsafe-read-string.lst
	ld -g -o unsafe-read-string.out unsafe-read-string.o
	execstack -s unsafe-read-string.out

preinjected-code.out: preinjected-code.asm
	yasm -Worphan-labels -g dwarf2 -f elf64 preinjected-code.asm -l preinjected-code.lst
	ld -g -o preinjected-code.out preinjected-code.o
	execstack -s preinjected-code.out

injectionCode.out: injectionCode.asm
	yasm -Worphan-labels -g dwarf2 -f elf64 injectionCode.asm -l injectionCode.lst
	ld -g -o injectionCode.out injectionCode.o

debug:
	gdb preinjected-code.out < in.gdb

clean:
	rm -v *.lst *.o *.out out.txt

