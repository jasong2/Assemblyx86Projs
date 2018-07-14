/****************************************************
 Name: Jason Gorelik
 File: frac_heap.h
 Date: 4/17/2018
                            Proj5
*****************************************************/

#ifndef FRAC_HEAP_H
#define FRAC_HEAP_H

typedef struct
{
  signed char sign;
  unsigned int numerator;
  unsigned int denominator;

}fraction;



void init_heap(void);
/*void print(void);*/
fraction *new_frac(void);
void del_frac(fraction *frac);
/*void dump_heap(void);
*/
#endif
