#include <msp430.h>

/*
 * Defina a função `void EscreveDigito(volatile char dig);` que escreve 
 * um dos dígitos 0x0-0xF em um único display de 7 segmentos via porta
 * P1, baseado na figura abaixo. Considere que em outra parte do código
 * os pinos P1.0-P1.6 já foram configurados para corresponderem aos LEDs
 * A-G, e que estes LEDs possuem resistores externos para limitar a
 * corrente.

        ---  ==> A
       |   |
 F <== |   | ==> B
       |   |
        ---  ==> G
       |   |
 E <== |   | ==> C
       |   |
        ---  ==> D
 */

void EscreveDigito(volatile char dig)
{
	/* Zerar P1OUT dos LEDs sempre que chamar a função */
	P1OUT &= ~0x7F;
	/* Considerar a ordem G...A = P1.6 ... P1.0 pois
	* P1OUT = P1.7...P1.0 */
	/* Catodo comum (-), se anodo (+) é só inverter ~ */
	const char zero = 	0x3F;
	const char one = 	0x06;
	const char two =	0x5B;
	const char three =	0x4F;
	const char four =	0x66;
	const char five =	0x6D;
	const char six =	0x7D;
	const char seven = 	0x07;
	const char eight = 	0x7F;
	const char nine = 	0x6F;
	const char A10 =	0x77;
	const char B11 = 	0x7C;
	const char C12 =	0x39;
	const char D13 =	0x5E;
	const char E14 =	0x79;
	const char F15 =	0x71;
	
	switch(dig){
		case '0':
		P1OUT |= zero;
		break;
		
		case '1':
		P1OUT |= one;
		break;
		
		case '2':
		P1OUT |= two;
		break;
		
		case '3':
		P1OUT |= three;
		break;
		
		case '4':
		P1OUT |= four;
		break;
		
		case '5':
		P1OUT |= five;
		break;
		
		case '6':
		P1OUT |= six;
		break;
		
		case '7':
		P1OUT |= seven;
		break;
		
		case '8':
		P1OUT |= eight;
		break;
		
		case '9':
		P1OUT |= nine;
		break;
		
		case 'A':
		P1OUT |= A10;
		break;
		
		case 'B':
		P1OUT |= B11;
		break;
		
		case 'C':
		P1OUT |= C12;
		break;
		
		case 'D':
		P1OUT |= D13;
		break;
		
		case 'E':
		P1OUT |= E14;
		break;
		
		case 'F':
		P1OUT |= F15;
		break;
	}
}

void main(void)
{
	char sequencia[16] = {'0', '1', '2', '3', '4', '5', '6', '7',
				'8', '9', 'A', 'B', 'C', 'D', 'E', 'F'};
	int i = 0;
	/* Usar como catodos P2.0 e P2.1 */
	/* Selecionar os P1.0 a P1.6 como saídas */
	P1DIR |= 0x7F;
	
	/* Selecionar como saídas P2.0 e P2.1 */
	P2DIR |= (BIT0 + BIT1);
	
	while(1){
		EscreveDigito(sequencia[i]);
		P2OUT |= BIT0;
		P2OUT &= ~BIT1;
		
		P2OUT |= BIT1;
		P2OUT &= ~BIT0;
		
		i = (i + 1)%16;
	}
} 
