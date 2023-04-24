.section ".text"
.extern kernelMain
.globl _start

_start:
    la sp, _stack_start
    lui a1, _bss_start
    lui a2, _bss_end
    jal ra, InitializeBSS    
    call kernelMain
    
InitializeBSS:
    sd x0, 0(a1)
    addi a1, a1, 8 # possivelmente fazer com instruções vetoriais
    blt a1, a2, InitializeBSS
    jalr x0, 0(ra)

_hlt:
    j _hlt
