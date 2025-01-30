#include <stdlib.h>
#include <stdio.h>
#include "arraylib.h"   /* prototypes of the functions below */
#include "intlib.h" /* needed for the swapInts function */


void initArray(int array[], int count, int scalingFactor)
{
    int i;

    for (i = 0; i < count; ++i)
        array[i] = i * scalingFactor;
}


void swapArrayVals(int a[], int aCount, int b[], int bCount)
{
    int i;

    if (aCount != bCount)
        return; /* don't try to swap diff sized arrays */

    for (i = 0; i < aCount; ++i)
        swapInts(&a[i], &b[i]);
}


void printArray(int array[], int count)
{
    int i;

    printf("array: [");
    for (i = 0; i < count-1; ++i)
        printf("%3d, ", array[i]);
    printf("%3d]\n", array[count-1]);
}
