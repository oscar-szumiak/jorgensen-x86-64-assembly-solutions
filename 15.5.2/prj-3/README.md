# Project notes

## Stack based code execution

By default on modern Linux systems trying to run code in data segments (stack, heap etc.) causes a segmentation fault due to the NX (no-execute) bit in ELF executables. NX-bit protection can be disabled for specific binaries with the 'execstack' program.

## Injection code (shellcode) issues

The injection code given in the book works when called directly but fails when called from within a function. This is due to the values of rsi and rdx being set to incorrect values for the execve system call. In the modified code these two registers are set to zero.

## Potential ideas useful for testing code injection

- [X] - direct injection (preinjected-code.asm)
- [X] - print rsp in hex before user input
- [ ] - print entered input as hex for verification
- [ ] - scripted input stack buffer overflow (via expect)

