#include "stubs.h"
#include "kernel.h"

template <typename ...Types>
void printf(string fmt, Types... agrs){
    while(*fmt) WRITE_UART(*fmt++);
}