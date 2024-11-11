file_name := error-check-string-to-int

all:
	./../../asm64 $(file_name)

debug:
	gdb $(file_name).out < in.gdb

clean:
	rm $(file_name).lst $(file_name).o $(file_name).out out.txt

