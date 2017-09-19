/*
* Piscar os LEDs initerruptamente, LED1 e LED2, com atraso arbitrário, mas o
* intervalo de ligado é 2 vezes o intervalo desligado.
*/

#include <msp430.h>

#define LED1 BIT0
#define LED2 BIT6
#define LEDS (LED1 | LED2)


void atraso(volatile unsigned int n)
{
	while(n--);
}

int main(void)
{
// Parar o watchdog timer
	WDTCTL = WDTPW | WDTHOLD;
// Configurar os LEDs como saída
	P1DIR |= LEDS;
// Piscar LEDs ininterruptamente
	while(1){
// Ligado
		P1OUT |= LEDS;
		atraso(0xFFFF);
		atraso(0xFFFF);
// Desligado
		P1OUT ^= LEDS;
		atraso(0xFFFF);
	}
	return 0;
}
