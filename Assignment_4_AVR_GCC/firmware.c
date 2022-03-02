#include <avr/io.h>
#include <util/delay.h>

unsigned char NOR(unsigned char X, unsigned char Y) //NOR function
{
    return ~(X|Y); 
}

unsigned char num ;                             //input number
unsigned char A=0x00,B=0x00,C=0x00,D=0x00;	    //binary inputs
unsigned char sev_seg[16] = {0x02, 0x9e, 0x24, 0x0c, 0x98, 0x48, 0x40, 0x1e, 0x00, 0x08, 0x10, 0xc0, 0x62, 0x84, 0x60, 0x70};
unsigned char Org, Nor; 
 
int main (void)
{
  /* Arduino boards have a LED at PB5 */
 //set PB5, pin 13 of arduino as output
  DDRB = 0x05;
DDRD = 0xFE;
  while (1) {
	for (num = 0x00; num<0x10; num++)               //loop to iterate through all usecases
    	{
        	A = num>>3;    B = num>>2;    C = num>>1;    D = num>>0; //changing the inputs , D is LSB
        	Org = (A|B)&(C|D);                          //Original Boolean Function
        	Nor = NOR( NOR(A, B), NOR(C, D) );          //NOR gate equivalent Boolean Function
		PORTD = sev_seg[num];
		PORTB = (Org<<2)|Nor;
    		_delay_ms(500);
	}
  }

  /* . */
  return 0;

}
