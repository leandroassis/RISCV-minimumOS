/*
    path: kernel.h
    create_date: 2023-04-25
*/

#ifndef KERNEL_H
#define KERNEL_H


// Memory mapped IO
#define UART_ADDR 0x10000000

// variable types
typedef long long int64;
typedef int int32;
typedef short int16;
typedef char int8;

typedef unsigned long long uint64;
typedef unsigned int uint32;
typedef unsigned short uint16;
typedef unsigned char uint8;
typedef const char* string;

// Kernel functions
void printf(string str);
void write(string, uint32);

// Memory mapped IO macros
#define WRITE_UART(val) ((*(volatile uint32 *)UART_ADDR) = (val))

#endif




