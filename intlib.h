
/*
    INTLIB_H

    The #ifndef, #define and #endif are pre-processor commands to test whether
    a symbol INTLIB_H has been defined and if so - skip the whole block else
    continue on.  After the first time this file is included in a compilation,
    the symbol INTLIB_H is defined and the file will never get compiled again.
    This prevents redundant compilation which could result in redefinition of
    functions and compilation errors.

    This mechanism relieves the programmer from having to worry about whether
    some #include that is needed in many places (like stdlib.h) was actually
    pasted in multiple times in a single compilation.
*/


#ifndef INTLIB_H
  #define INTLIB_H

int getInts(int *a, int *b);
void swapInts(int *a, int *b);
void printInts(int a, int b);

#endif
