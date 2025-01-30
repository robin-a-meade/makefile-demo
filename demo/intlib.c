#include <stdio.h>
#include "intlib.h"

/*
    GETINTS: prompts for and returns 2 ints
    return value of 0 means both ints sucessfully gotten from kbd
    any other value indicates an error. return vals not to be used
*/
int getInts(int *a, int *b)
{
    printf("Enter 2 ints sep. by whitespace: ");

    return scanf("%d%d", a, b) - 2;
}


/*
    SWAPINTS: uses pointers to exchange values of incoming args
*/
void swapInts(int *a, int *b)
{
    int temp = *a;
    *a = *b;
    *b = temp;
}


/*
    PRINT: takes copy args - no need to modify args
*/
void printInts(int a, int b)
{
    printf("1st arg: %d, 2nd arg: %d\n", a, b);
}

