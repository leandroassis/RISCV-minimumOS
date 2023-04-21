.section ".text"
.extern kernelMain
.globl _start

_start:
    la sp, _stack_start
    j InitializeBSS    
    call kernelMain
    
InitializeBSS:
    ld a1, _bss_start
    ld a2, _bss_end
    j loop

loop:
    sd a1, 0 # fix this
    addi a1, a1, 8
    blt a1, a2, loop
    ret

_hlt:
    j _hlt
