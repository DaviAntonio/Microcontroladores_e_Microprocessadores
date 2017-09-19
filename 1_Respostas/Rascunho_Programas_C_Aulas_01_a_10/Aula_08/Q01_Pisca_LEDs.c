/* 
* Piscar os LEDs initerruptamente, LED1 e LED2, com atraso arbitrário
*/

#include <msp430.h>

#define LED1 BIT0
#define LED2 BIT6
#define LEDS (LED1 | LED2)


int main(void)
{
// Inteiros possuem 2 bytes no MSP430
	int n;
// Parar o watchdog timer
	WDTCTL = WDTPW | WDTHOLD;
// Configurar os LEDs como saída
	P1DIR |= LEDS;
// Piscar LEDs ininterruptamente
	while(1){
		n = 0xFFFF;
		P1OUT ^= LEDS;
// Atraso arbitrário
		while(n--);
	}
	return 0;
}
