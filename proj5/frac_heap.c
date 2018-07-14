/* 
  Name: Jason Gorelik
  File: frac_heap.c
  class: CMSC 313
  date: 4.18.2018
  
                              Proj 5


 */
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "frac_heap.h"

#define MAX 20

static fraction fracArray[MAX];
unsigned int head = 0;

/* initializees heap, using sign to link the free blocks */
void init_heap(void)
{
  int i;
  int j;
  for (j = 0; j < MAX; j++)
    {
      fracArray[j].sign = j+1;
    }
  for(i = 0; i < MAX; i++)
  {
    if(i < 20)
      fracArray[i].sign = i+1;
  }
}
/* adds fraction object, links head to newest object*/
fraction* new_frac(void)
{
  int i;
  fraction* target;
  if(head == MAX)
    { 
      printf("%s", "List is full");
      return NULL;
    }
  for(i=0; i < MAX; i++)
  {
    if(fracArray[i].denominator == 0)
    {
       head = fracArray[i].sign;
       target = &fracArray[i];
      
       return target;
    }
  }

}

/* delete fraction method */
void del_frac(fraction *frac)
{
  unsigned int temp;
  unsigned int temp1;
  int i;
  signed int j = -1;
  for(i = 0; i < MAX; i++)
  {
    
    if(fracArray[i].denominator == 0)
    {
      /* if theres free blocks between objects, theres cleanup on keeping indexes*/

      j = i; /*holds value of last sign = 0 */
      fracArray[i].sign = fracArray[i].sign-1;
      temp1 = fracArray[i].sign;
    }
    /* when object finds obect in array */
    if(frac == &fracArray[i] && fracArray[i].denominator != 0)
    {
      /* links head to begining of free block after deleting object */
      /* if/else statment link head to newest block depending on circumstances */
      /* different methods used for certain situation */
      if(j == -1)
      {
	fracArray[i].sign = fracArray[head].sign-1;
	head = i;
	fracArray[i].numerator = 0;
	fracArray[i].denominator = 0;
	
	return;
      }
      else
      {
       
	temp1 = temp1+1;
	fracArray[i].sign = temp1;
	fracArray[i].numerator = 0;
	fracArray[i].denominator = 0;
	
	return;
      }
    }
  }
  /* if theres no value, program exits */
  printf("%s", "Error, no value\n");
  exit(0);


}
/* dump heap*/
void dump_heap(void)
{
  unsigned int first_free= 0;
  int i= 0;
  while(first_free ==0)
  {
    if(fracArray[i].denominator == 0)
      first_free = i;
    i++;
    
  }
  if(first_free >= 20)
    first_free = -1;
  printf("%s", "\n**** BEGIN HEAP DUMP ***\n");
  printf("%s", "first_free = ");
  printf("%d\n\n", first_free);
  int j;
  for(j = 0; j < MAX; j++)
  {
   
    printf("  %d", j);
    printf("%s", ": ");
    printf("%d  ", fracArray[j].sign);
    printf("%d  ", fracArray[j].numerator);
    printf("%d  \n", fracArray[j].denominator);
  }
  printf("%s", "**** END HEAP DUMP ***\n");
}
