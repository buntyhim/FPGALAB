/******************************************************************************
Challenge Problem 2
NAND Data Structure
By : HIMANSHU YADAV  IS21MTECH11003                 

*******************************************************************************/

#include <stdio.h>

char nandlogic (char a, char b)
{
  return ~(a & b);  //Actual NAND logic
}

struct NAND         //A NAND structure 
{
  char IN1;         // has two inputs
  char IN2;

  char (*OUT) (char, char); // A function to calculate the output

};


int main ()
{
  char num, one = 0x01;
  char A=0x00,B=0x00,C=0x00,D=0x00;
  
  for (num = 0x00; num<0x10; num++)               //loop to iterate through all usecases
    {
        A = num>>3;    B = num>>2;    C = num>>1;    D = num>>0; //changing the inputs , D is LSB
        
        // logic to implement ((AB)'(CD)')' using NAND Gates
        // NAND Gate connections
        struct NAND nand1 = { A, B, &nandlogic };
        struct NAND nand2 = { C, D, &nandlogic };
        struct NAND nand3 = { nand1.OUT (nand1.IN1, nand1.IN2), nand2.OUT (nand2.IN1, nand2.IN2), &nandlogic };
        
        printf("\n  %x %x %x %x", one&A, one&B, one&C, one&D); 
        printf ("\t%x", one & nand3.OUT (nand3.IN1, nand3.IN2));
    }
  return 0;
}
