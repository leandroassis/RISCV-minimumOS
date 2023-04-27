.section ".text.boot"
.globl _start

_start:
    la sp, _stack_start
    la a1, _bss_start
    la a2, _bss_end
    jal ra, initialize_bss
    call kernel_main
    j _hlt

# to do: criar magic number pra inicializar via grub (iso)

initialize_bss:
    sd x0, 0(a1)
    addi a1, a1, 8
    ble a1, a2, initialize_bss
    jalr x0, 0(ra)

_hlt:
    j _hlt
