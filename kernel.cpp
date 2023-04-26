#include "kernel.h"

extern "C" void kernel_main(void *multiboot_structure, uint32 magic_number){
    //printf("%d", magic_number); how i do that?????
    printf("Bem vindo ao RISCV OS!\n");
    printf("$> ");
    while(1){
    }
}

void printf(string str){
    // to do: permitir enviar kwargs
    while(*str != '\0'){
        WRITE_UART(*str);
        str++;
    }
}