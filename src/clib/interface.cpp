#include "stubs.h"
#include "../kernel/kernel.h"
#include "types.h"

template <typename fmt, typename ...Types>
void printf(fmt data, Types... agrs){
    write(data);
    printf(agrs...);
}