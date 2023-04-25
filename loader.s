.section ".text"
.extern kernelMain
.globl _start

_start:
    la sp, _stack_start
    la a1, _bss_start
    la a2, _bss_end
    jal ra, InitializeBSS    
    call kernelMain
    
InitializeBSS:
    sd a1, 0(x0)
    addi a1, a1, -8 # possivelmente fazer com instruções vetoriais
    bgt a1, a2, InitializeBSS
    jalr x0, 0(ra)

_hlt:
    j _hlt
