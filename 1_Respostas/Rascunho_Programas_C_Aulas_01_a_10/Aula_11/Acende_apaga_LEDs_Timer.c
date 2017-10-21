#include <msp430.h>
#include <legacymsp430.h>	/* Habilita interrupções */

#define LED1 BIT0
#define LED2 BIT6
#define LEDS (LED1|LED2)

#define TEMPO_MS_METADE 1000

/*
 * freq = 100 Hz;	tempo = 10 ms;		tempo/2 = 5ms
 * freq = 20 Hz;	tempo = 50 ms;		tempo/2 = 25 ms
 * freq = 1 Hz;		tempo = 1000 ms;	tempo/2 = 500 ms
 * freq = 0,5 Hz;	tempo = 2000 ms;	tempo/2 = 1000 ms
 */

void Configura_Timer(volatile unsigned int x)
{
	/* 1000 contagens de 1 us = 1 ms, mas conta o zero (up) */
	TA0CCR0 = x - 1;
	
	/* Usar SMCLK, não dividi-lo, contar em modo up e ligar a
	 * interrupção de término da contagem */
	TA0CTL = TASSEL_2 + ID_0 + MC_1 + TAIE;
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
	P1OUT |= ~LEDS;

	Configura_Timer(TEMPO_MS_METADE);

	_BIS_SR(GIE + LPM0_bits);
	
	/* Nunca chegará */

	return 0;
}

interrupt(TIMER0_A1_VECTOR) InterrupcaoP1(void)
{
	TA0CTL &= ~TAIFG;
	
	static int i = 0;
	
	i = (i + 1) % 1000;
	
	if(i == 0)
		P1OUT ^= LEDS;
}

