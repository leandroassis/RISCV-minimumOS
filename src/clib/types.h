#ifndef TYPES_H
    #define TYPES_H
    
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

enum t_typename {
    TYPENAME_INT64,
    TYPENAME_INT32,
    TYPENAME_INT16,
    TYPENAME_INT8,
    TYPENAME_UINT64,
    TYPENAME_UINT32,
    TYPENAME_UINT16,
    TYPENAME_UINT8,
    TYPENAME_CHAR,
    TYPENAME_FLOAT,
    TYPENAME_DOUBLE,
    TYPENAME_LONG_DOUBLE,
    TYPENAME_VOID,
    TYPENAME_POINTERTOCHAR,
    TYPENAME_OTHER
};

// _Generic macro just works for C11, not C++
#define type(X) _Generic((X),                                                          \
        unsigned char: TYPENAME_UINT8,                                                 \
        char: TYPENAME_CHAR,                                                           \
        short int: TYPENAME_INT16,            unsigned short int: TYPENAME_UINT16,     \
        int: TYPENAME_INT32,                  unsigned int: TYPENAME_UINT32,           \
        long long int: TYPENAME_INT64,        unsigned long long int: TYPENAME_UINT64, \
        float: TYPENAME_FLOAT,                double: TYPENAME_DOUBLE,                 \
        long double: TYPENAME_LONG_DOUBLE,                                             \
        void *: TYPENAME_VOID,                char *: TYPENAME_POINTERTOCHAR,          \
        default: TYPENAME_OTHER)

#endif