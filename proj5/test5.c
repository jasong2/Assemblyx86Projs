/*
 *  File: main5.c
 *
 *  This file tests out the functions in frac_heap.c
 */

#include <stdio.h>
#include <stdlib.h>
#include "frac_heap.h"

/*
 * Compute the greatest common divisor using Euclid's algorithm
 */
unsigned int gcd ( unsigned int a, unsigned int b) {

   if (b == 0) return a ;

   return gcd (b, a % b) ;
}

/*
 * Print a fraction out nicely
 */
void print_frac (fraction *fptr) {

   if (fptr->sign < 0) printf("-") ;

   printf("%d/%d", fptr->numerator, fptr->denominator) ;

}

/*
 * Initialize a fraction
 */
fraction *init_frac (signed char s, unsigned int n, unsigned int d) {
   
   fraction *fp ;

   fp = new_frac() ;
   fp->sign = s ;
   fp->numerator = n ;
   fp->denominator = d ;

   return fp ;
}

/*
 * Add two fractions
 * Return value is a pointer to allocated space.
 * This must be deallocated using del_frac().
 */
fraction *add_frac(fraction *fptr1, fraction *fptr2) {
   unsigned int lcm, div, g, m1, m2  ;
   fraction *answer ;


   g = gcd(fptr1->denominator, fptr2->denominator) ;
   lcm = (fptr1->denominator / g) * fptr2->denominator ;

   m1 = (fptr1->denominator / g) ;
   m2 = (fptr2->denominator / g) ;
   lcm = m1 * fptr2->denominator ;

   answer = new_frac() ;
   answer->denominator = lcm ;

   if (fptr1->sign == fptr2->sign) {

      answer->sign = fptr1->sign ;
      answer->numerator = fptr1->numerator * m2 + fptr2->numerator * m1 ;

   } else if (fptr1->numerator >= fptr2->numerator) {

      answer->sign = fptr1->sign ;
      answer->numerator = fptr1->numerator * m2 - fptr2->numerator * m1 ;

   } else {

      answer->sign = fptr2->sign ;
      answer->numerator = fptr2->numerator * m2 - fptr1->numerator * m1 ;

   }

   div = gcd(answer->numerator, answer->denominator) ;
   answer->numerator /= div ;
   answer->denominator /= div ;

   return answer ;

}

/* program test filling up list and deleting */
int main() 
{
  fraction *fp1, *fp2, *fp3, *fp4, *fp5;
  fraction *fp6, *fp7, *fp8, *fp9, *fp10;
  fraction *fp11, *fp12, *fp13, *fp14, *fp15;
  fraction *fp16, *fp17, *fp18, *fp19, *fp20, *fp21;
   init_heap();
   fp1 = new_frac();
   fp1->sign = 1;
   fp1->numerator = 4;
   fp1->denominator = 5;
      
   fp2 = new_frac();
   fp2->sign = 1;
   fp2->numerator = 4;
   fp2->denominator = 5;
   fp3 = new_frac();
   fp3->sign = 1;
   fp3->numerator = 4;
   fp3->denominator = 5;
   fp4 = new_frac();
   fp4->sign = 1;
   fp4->numerator = 4;
   fp4->denominator = 5;
   fp5 = new_frac();
   fp5->sign = 1;
   fp5->numerator = 4;
   fp5->denominator = 5;
   fp6 = new_frac();
   fp6->sign = 1;
   fp6->numerator = 4;
   fp6->denominator = 5;
   fp7 = new_frac();
   fp7->sign = 1;
   fp7->numerator = 4;
   fp7->denominator = 5;
   fp8 = new_frac();
   fp8->sign = 1;
   fp8->numerator = 4;
   fp8->denominator = 5;
   fp9 = new_frac();
   fp9->sign = 1;
   fp9->numerator = 4;
   fp9->denominator = 5;
   fp10 = new_frac();
   fp10->sign = 1;
   fp10->numerator = 4;
   fp10->denominator = 5;
   
   fp11 = new_frac();
   fp11->sign = 1;
   fp11->numerator = 4;
   fp11->denominator = 5;
   fp12 = new_frac();
   fp12->sign = 1;
   fp12->numerator = 4;
   fp12->denominator = 5;
   fp13 = new_frac();
   fp13->sign = 1;
   fp13->numerator = 4;
   fp13->denominator = 5;
   fp14 = new_frac();
   fp14->sign = 1;
   fp14->numerator = 4;
   fp14->denominator = 5;
   fp15 = new_frac();
   fp15->sign = 1;
   fp15->numerator = 4;
   fp15->denominator = 5;
   fp16 = new_frac();
   fp16->sign = 1;
   fp16->numerator = 4;
   fp16->denominator = 5;
   fp17 = new_frac();
   fp17->sign = 1;
   fp17->numerator = 4;
   fp17->denominator = 5;
   fp18 = new_frac();
   fp18->sign = 1;
   fp18->numerator = 4;
   fp18->denominator = 5;
   fp19 = new_frac();
   fp19->sign = 1;
   fp19->numerator = 4;
   fp19->denominator = 5;
   fp20 = new_frac();
   fp20->sign = 1;
   fp20->numerator = 4;
   fp20->denominator = 5;
   dump_heap();
   fp21 = new_frac();
   fp21->sign = 1;
   fp21->numerator = 4;
   fp21->denominator = 5;
     
  
   dump_heap() ;

   return 0 ;
}
