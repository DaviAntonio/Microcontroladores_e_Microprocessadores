#include <msp430.h>

int main(void)
{
	WDTCTL = WDTPW + WDTHOLD;
	asm("mov.w #8, R15 \n");
	asm("mov.b R15, &__P1DIR \n");
	asm("clr.b &__P1OUT \n");
	asm("mov.b #1, &__P1OUT \n");
	while(1);
	return 0;
}
