.equ MAGIC, 0x1badb002
.equ FLAGS, (1<<0 | 1<<1)
.equ CHECKSUM, -(MAGIC+FLAGS)

.section .multiboot
    .dword MAGIC
    .dword FLAGS
    .dword CHECKSUM

.section ".text.boot"
.globl _start

_start:
    la sp, _stack_start
    la a1, _bss_start
    la a2, _bss_end
    jal ra, initialize_bss
    li a0, FLAGS
    li a1, MAGIC
    call kernel_main

# to do: criar magic number pra inicializar via grub (iso)

initialize_bss:
    sd x0, 0(a1)
    addi a1, a1, 8
    ble a1, a2, initialize_bss
    jalr x0, 0(ra)

_hlt:
    j _hlt
