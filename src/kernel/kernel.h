/*
    path: kernel.h
    create_date: 2023-04-25
*/

#ifndef KERNEL_H
    #define KERNEL_H

// Memory mapped IO
#define UART_ADDR 0x10000000

// Memory mapped IO macros
#define WRITE_UART(val) ((*(volatile uint32 *)UART_ADDR) = (val))

#endif




