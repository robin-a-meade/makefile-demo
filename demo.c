/*  demo.c - demo program for make command
    - COMPILATION COMMAND assumes 5 files in same dir:
        makeDemo.c arraylib.c arraylib.h intlib.c intlib.h
    - TO COMPILE:  gcc -o demo  makeDemo.c intlib.c arraylib.c
    - TO EXECUTE:  ./demo
*/

#include <stdlib.h>
#include <stdio.h>
#include "arraylib.h"   /* prototype for array swap and print functs */


int main(int argc, char *argv[])
{
    int a[] = { 2, 3, 5, 7, 11 };
    const int aLen = 5;

    int b[] = { 4, 6, 8, 12, 16 };
    const int bLen = 5;

    int c[10], d[7];
    const int cLen = 10;
    const int dLen = 7;

    printf("\nArrays a and b before swap:\n");
    printArray(a, aLen);
    printArray(b, bLen);

    swapArrayVals(a, aLen, b, bLen);

    printf("\nArrays a and b after swap:\n");
    printArray(a, aLen);
    printArray(b, bLen);

    printf("\nArrays c and d:\n");
    initArray(c, cLen, 2);
    initArray(d, dLen, 5);
    printArray(c, cLen);
    printArray(d, dLen);

    return 0;
}
