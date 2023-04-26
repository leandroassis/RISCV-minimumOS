#include "kernel.h"

extern "C" void kernel_main(){
    //printf("%d", magic_number); how i do that?????
    printf("Bem vindo ao RISCV OS!\n");
    printf("$> ");
}

void printf(string str){
    // to do: permitir enviar kwargs
    while(*str != '\0'){
        WRITE_UART(*str);
        str++;
    }
}