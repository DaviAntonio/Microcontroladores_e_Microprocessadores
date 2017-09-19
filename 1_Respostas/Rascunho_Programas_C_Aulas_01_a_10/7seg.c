#include <stdio.h>

void EscreveDigito(volatile char dig, char * P1OUT)
{
	/* Zerar P1OUT dos LEDs sempre que chamar a função */
	*P1OUT &= ~0x7F;
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
		*P1OUT |= zero;
		break;
		
		case '1':
		*P1OUT |= one;
		break;
		
		case '2':
		*P1OUT |= two;
		break;
		
		case '3':
		*P1OUT |= three;
		break;
		
		case '4':
		*P1OUT |= four;
		break;
		
		case '5':
		*P1OUT |= five;
		break;
		
		case '6':
		*P1OUT |= six;
		break;
		
		case '7':
		*P1OUT |= seven;
		break;
		
		case '8':
		*P1OUT |= eight;
		break;
		
		case '9':
		*P1OUT |= nine;
		break;
		
		case 'A':
		*P1OUT |= A10;
		break;
		
		case 'B':
		*P1OUT |= B11;
		break;
		
		case 'C':
		*P1OUT |= C12;
		break;
		
		case 'D':
		*P1OUT |= D13;
		break;
		
		case 'E':
		*P1OUT |= E14;
		break;
		
		case 'F':
		*P1OUT |= F15;
		break;
		
		default:
		*P1OUT |= 0xFE;
	}
}

int main(void)
{
	char P1IN;
	char P1OUT;
	char * saida = &P1OUT;
	puts("\nDigite char\n");
	scanf("%c", &P1IN);
	EscreveDigito(P1IN, &P1OUT);
	printf("\n Dentro de P1OUT do MSP temos: %X\n", *saida);
	return 0;
}
