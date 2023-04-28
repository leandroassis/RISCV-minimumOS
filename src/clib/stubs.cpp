#include "stubs.h"
#include "types.h"
#include "../kernel/kernel.h"

template <typename fmt>
void write(fmt data){

    switch(type(data)){
        case TYPENAME_INT64 | TYPENAME_UINT64 | TYPENAME_INT32 | TYPENAME_UINT32 | TYPENAME_INT16 | TYPENAME_UINT16 | TYPENAME_INT8 | TYPENAME_UINT8:
            write_uart(data + '0'); // needs itarate it digits of data
            break;
        case TYPENAME_FLOAT | TYPENAME_DOUBLE | TYPENAME_LONG_DOUBLE:
            write_uart(data);
            break;
        case TYPENAME_CHAR:
            char *tmp_ptr;
            *tmp_ptr = data;
            write_uart(tmp_ptr);
            break;
        case TYPENAME_POINTERTOCHAR:
            write_uart(data);
            break;
        default:
            break;
    }
}

void write_uart(const char* str){
    while(*str) WRITE_UART(*str++);
}