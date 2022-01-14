//Code written on January 14, 2022
//By Himanshu Yadav
//This program displays a verification truth table for (A+B)(C+D) Logic and it NOR Gate Rresentation

#include<stdio.h>

int main()
{
    unsigned char  num ;                            //input number
    unsigned char  A=0x00,B=0x00,C=0x00,D=0x00;	    //binary inputs
    unsigned char one = 0x01;
    unsigned char Org,Nor;                          //outputs 

    printf("Binary Input  (A+B)(C+D)  ((A+B)'+(C+D)')'\n");

    for (num = 0x00; num<0x10; num++) {             //loop to iterate through all usecases

        A = num>>3;    B = num>>2;    C = num>>1;    D = num>>0; //changing the inputs , D is LSB
        
        Org = (A|B)&(C|D);                          //Original Boolean Function
        Nor = ~((~(A|B))|(~(C|D)));                 //NOR gate equivalent Boolean Function
       
        printf("  %x %x %x %x", one&A, one&B, one&C, one&D);    //Input ABCD
        printf("\t\t%x\t\t\t%x\n" , one&Org, one&Nor);          //Output Org, Nor
    
    }

    /*Output
        Binary Input  (A+B)(C+D)  ((A+B)'+(C+D)')'
        0 0 0 0	        0		    0
        0 0 0 1	        0		    0
        0 0 1 0	        0		    0
        0 0 1 1	        0		    0
        0 1 0 0	        0		    0
        0 1 0 1	        1		    1
        0 1 1 0	        1		    1
        0 1 1 1	        1		    1
        1 0 0 0	        0		    0
        1 0 0 1	        1		    1
        1 0 1 0	        1		    1
        1 0 1 1	        1		    1
        1 1 0 0	        0		    0
        1 1 0 1	        1		    1
        1 1 1 0	        1		    1
        1 1 1 1	        1		    1
    */
    
    return 0;
}