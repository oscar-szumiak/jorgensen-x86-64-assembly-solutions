file_name := reverse

all:
	./../../asm64 $(file_name)

debug:
	gdb $(file_name).out < in.gdb

clean:
	rm -v $(file_name).lst $(file_name).o $(file_name).out out.txt

