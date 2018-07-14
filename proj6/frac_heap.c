/* 
Name: Jason Gorelik
Email: jasong2@umbc.edu
Date: 4/25/2018

                            Proj6
*/

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "frac_heap.h"

union fraction_block_u
{
  union fraction_block_u *next;
  fraction frac;
};
typedef union fraction_block_u fraction_block;

static union fraction_block_u *head;
static union fraction_block_u *current;
static union fraction_block_u *fracListStart;
/* initilialize heap*/
void init_heap(void)
{ 
  
  head = NULL;
}
/* new fraction */
fraction *new_frac(void)
{
  fraction_block *target;
  /* if head has no links */
  if(head == NULL)
  {
    /* create new malloc */
    current = (fraction_block *)malloc(5*sizeof(fraction_block));
    printf("%s", "called malloc(");
    printf("%d", sizeof(current));
    printf("%s", "): ");
    printf("%s", "returned ");
    printf("%p\n", current);
    fracListStart = current;
        
    /* fraction sent back */
    target = &current->frac;
    current++;
    
    head = current;
    
    int i;
    for(i = 0; i < 3; i++)
    {
      current->next = current++; 
    }
    return (&target->frac);
  }
  /* otherwise */
  else
  {    
    /* if theres free links left, do this */
    if(head->next != NULL)
    {     
     
      current = head;
      target = &current->frac;
      current++;
      head = current;
      
      return (&target->frac);
    }
    /* if head has 1 free left, use free, and make new malloc */   
    else
    {
      fraction_block *temp;
            
      
      target = &head->frac; /* use free */

      /* new malloc, connect to head->next */
      head->next = (fraction_block *)malloc(5 * sizeof(fraction_block));
      printf("%s", "called malloc(");
      printf("%d", sizeof(current));
      printf("%s", "): ");
      printf("%s", "returned ");
      printf("%p\n", current);

      head++;
      temp = head;
    
      int j;
      for(j = 0; j < 4; j++)
      {
	temp->next = temp++;
      }
      temp = NULL;
      return (&target->frac);
        
     }
  }
}
/* delete fraction */
/* Am able to move head to free position, and use free position in free list*/
/* However, had trouble making the new frac go to previous head location in free list link 
   afterwards */
void del_frac(fraction *frac)
{
  fraction_block *temp;
  fraction_block *prev;
  fraction_block *tempHead;
 
  temp = fracListStart;
  temp++;
 
  temp = fracListStart;
  while(temp->next != NULL)
  {
    if(frac == &temp->frac)
      {
        prev = temp--;
	temp++;
	prev->next = temp->next;
    
	tempHead = head;
	head = temp;
	head->next = tempHead++;
	
        tempHead->next = temp;
	return;
      }
    temp++;
  }
}
/* dump heap */
void dump_heap(void)
{  
   fraction_block *iterator;
   iterator = fracListStart;
   printf("%s", "**** BEGIN HEAP DUMP ****\n\n");
   while(iterator->next != NULL)
   {
     printf("%p   ", iterator);
     printf("%s", "\n");
      
     iterator++;
   }
   printf("%s\n\n", "**** END HEAP DUMP ****");
}
