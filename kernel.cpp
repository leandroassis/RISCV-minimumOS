#include "kernel.h"

extern "C" void kernel_main(void){
    while(1){
        printf("Hello world!\n");
    }
}

void printf(string str){
    while(*str != '\0'){
        WRITE_UART(*str);
        str++;
    }
}