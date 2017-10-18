#include <msp430.h>

#define LED1 BIT0
#define LED2 BIT6
#define LEDS (LED1|LED2)

void Atraso(volatile unsigned int x)
{
	int i;
	
	for(i = 0; i < 1000; i++){ 
	/* 1000 contagens de 1 us = 1 ms, mas conta o zero (up) */
	TA0CCR0 = x - 1;
	
	/* Usar SMCLK, não dividi-lo e contar em modo up */
	TA0CTL = TASSEL_2 + ID_0 + MC_1;
	
	/* Espera terminar contagem */
	while((TA0CTL & TAIFG) == 0);
	}
	
	/* Parar e zerar o timer */
	TA0CTL = MC_0 + TACLR;
	TA0CTL &= ~TAIFG;
}

int main(void)
{
	/* Parar o watchdog timer */
	WDTCTL = WDTPW + WDTHOLD;
	
	/* SMCLK = MCLK = 1 MHz */
	BCSCTL1 = CALBC1_1MHZ;
	DCOCTL = CALDCO_1MHZ;
	
	/* Colocar LEDS como saída */
	P1DIR |= LEDS;
	
	/* Desligados */
	P1OUT |= ~LEDS;

	while(1){
		Atraso(5);
		P1OUT ^= LEDS;
		Atraso(5);
	}

	return 0;
}
