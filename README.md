# ASM2

ASM2 is the better version of the as command, it takes your code and adds your own modules to ~/.assemblyModules

## Using Modules

ASM2 uses ld -s <object> <modules> <extModules> -o <output>, you can also use -j to add 1-time modules for compiling

in assembly i can write bl exit and have it not work unless i find or make a module and use asm2 -m exitModule.s -o exit.o which bl exit will now work when compiled with modules. 

## Module Examples

Exit Module For AARCH64:

.global exit

.section .text
exit:
  mov x8, #93
  svc #0


Script With Exit Module

.global _start

.section .text
_start:
  mov x0, #0
  bl exit


compiling: 
`
asm2 -j exitModule.o -o main.o -f main main.s
`
or
`
asm -m exitModule.s -o exit.o
asm -o main.o -f main main.s
`

### Modules
Installing incompatable modules can break asm2, so you can use asm2 -l to list modules
`asm2 -l`

`/home/pvpgod/brokenModule.s.o`
and then use
`asm2 -d brokenModule.s.o` to remove it

There are 2 modules for aarch64/arm64 assembly located at the OptionalModules(https://github.com/pvp-god70254/asm2/tree/master/OptionalModules) Folder
