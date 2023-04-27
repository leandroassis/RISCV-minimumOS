#include "kernel.h"
#include "stubs.h"

extern "C" void kernel_main(){
    uint8 teste = 0x48;

    printf("Bem vindo ao RISCV OS %d!\n", teste);
}