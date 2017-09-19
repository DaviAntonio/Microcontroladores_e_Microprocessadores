/* Fazer o charlieplex de 6 leds, de modo que aparentem estar acesos
 * ao mesmo tempo
P1.0----R-------------------------------------------------
                  |       |                       |       |
                L1▼     L2▲                       |       |
                  |       |                       |       |
P1.1----R--------------------------             L5▼     L6▲
                          |       |               |       |
                        L3▼     L4▲               |       |
                          |       |               |       |
P1.2----R-------------------------------------------------
*/

#include <msp430.h>

void main(void)
{
	/* Contador para passar em todos os LEDs */
	int i = 0;
	/* Parar o watchdog timer */
	WDTCTL = WDTPW + WDTHOLD;
	/* Para ligar L1
	 * fazemos P1.0 = 1, P1.1 = 0, P1.2 entrada
	 * L2
	 * P1.0 = 0, P1.1 = 1, P1.2 entrada
	 * (+) anodo ---▶|--- catodo (-)
	 */
	 char  anodo[6] = {BIT0, BIT1, BIT1, BIT2, BIT0, BIT2};
	 char catodo[6] = {BIT1, BIT0, BIT2, BIT1, BIT2, BIT0};
	 while(1){
		 /* Colocar todos os pinos como entrada, de modo que o
		  * que for escrito neles será bufferizado e será
		  * colocado como saída ao mudar o P1DIR correspondente.
		  */
		 P1DIR &= ~(BIT0 + BIT1 + BIT2);
		 /* O (+), 1 deve estar na porta correspondente */
		 P1OUT |= anodo[i];
		 /* O (-), 0, também */
		 P1OUT &= ~(catodo[i]);
		 /* As portas de saída são colocadas (1), e a outra 
		  * porta continua em entrada (0), alta impedância, para
		  * que o charlieplexing funcione. */
		 P1DIR |= anodo[i] + catodo[i];
		 /* Precisamos zerar o i assim que ele atingir o 6 ou
		  * ocorrerá erro.
		  * i sempre receberá o resto da divisão de i+1 por 6, 
		  * que retornará zero quando i for 6, pois o vetor é
		  * numerado de 0 a 5, contendo 6 posições. */
		 i = (i + 1)%6;
	 }
}
