file_name := int-op

all:
	./../../asm64 $(file_name)

debug:
	gdb $(file_name).out < gdbIn.txt

clean:
	rm -v $(file_name).lst $(file_name).o $(file_name)

