# Notes

## Print register as hex

Easy reading and entering of relative address based on rsp.

## Print input as hex

For verification of correct input.

## Scripted exploit

Figure out whether it is possible to script the exploit:

1. Feed injectionCode.hex as input into program
2. Read value of rsp, calculate offset and input it overwriting rip

## Check if exploit works

Write version that explicitly injects the exploit code into the stack and overwrites the rip value.

## Check if exploit would work without function call

Implement same procedure without any function call.

