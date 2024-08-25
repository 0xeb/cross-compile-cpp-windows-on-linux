#include <stdio.h>
#include "routine.h"

int main() 
{
    printf("Hello, World!\n");
#if !defined(_WIN32)
    // TODO: fix link error in 32-bits build
    printf("The answer is %d\n", add(5, 6));
#endif    
    return 0;
}