/* *******************************************************************
   Name :Jason Gorelik
   File :sort_books.c
   Date :5/3/2018
   CMSC 313 Assembly
   Proj4: Sort Books
******************************************************************/
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "book.h"
/*
 * Following is straight from the project description
 */

extern int bookcmp(const struct book *, const struct book *);

typedef int (* COMP_FUNC_PTR) (const void*, const void*) ;

/*
 * sort_books(): receives an array of struct book's, of length
 * numBooks.  Sorts the array in-place (i.e., actually modifies
 * the elements of the array).
 *
 * This is almost exactly what was given in the pseudocode in
 * the project spec--need to replace STUBS with real code
 */


void sort_books(struct book books[], int numBooks) 
{
  int (* fptr) (const struct book, const struct book);
  
  
  fptr = &bookcmp;
  qsort(books, numBooks, sizeof(struct book), (COMP_FUNC_PTR)fptr);
  
   
}
/* print books */
void print_books(struct book books[], int numBooks)
{
  if(numBooks ==0)
  {  
    printf("%s ", "Error, empty array");
    return;
  }
  
  int i;
  for(i = 0; i < numBooks; i++)
    {
      printf("%s ", books[i].title, ", ");
      printf("%s ", books[i].author, ", ");
      printf("%s ", books[i].subject, ", ");
      printf("%d ", books[i].year, ", ");
      printf("\n");
    }
  
}

