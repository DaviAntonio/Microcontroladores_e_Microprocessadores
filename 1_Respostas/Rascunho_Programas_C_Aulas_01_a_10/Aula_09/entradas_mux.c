/*Escreva um código em C que lê 9 botões multiplexados por 6 pinos, e 
 * pisca os LEDs da placa Launchpad de acordo com os botões. Por
 * exemplo, se o primeiro botão é pressionado, os LEDs piscam uma vez;
 * se o segundo botão é pressionado, os LEDs piscam duas vezes; e assim
 * por diante. Se mais de um botão é pressionado, os LEDs não piscam.
 * P1.1		P1.2		P1.3	P1.4	P1.5	P1.7
 * 1		2		3
 * 4		5		6
 * 7		8		9
*/

#include <msp430.h>
#include <legacymsp430.h>

#define LED1 BIT0
#define LED2 BIT6
#define LEDS (LED1 | LED2)

void configura_para_ler_teclado(void)
{
	/* Os pinos usados são P1.1, P1.2, P1.3, P1.4, P1.5, P1.7
	 * P1.0 e P1.6 são sempre saídas
	 */
	P1DIR |= LEDS;
	/* Começar desligado */
	P1OUT &= ~LEDS;
	
	/* No início, P1.1, P1.2 e P1.3 são saídas em 0 */
	P1DIR |= (BIT1 + BIT2 + BIT3);
	P1OUT |= ~(BIT1 + BIT2 + BIT3);
	
	/* No início P1.4, P1.5 e P1.7 são entradas com pull up */
	/* Habilitar pull up */
	P1DIR |= ~(BIT4 + BIT5 + BIT7);
	P1REN |= (BIT4 + BIT5 + BIT7);
	P1OUT |= (BIT4 + BIT5 + BIT7);
	
	/* Habilitar interrupção por borda de descida (1)*/
	P1IES |= (BIT4 + BIT5 + BIT7);
	/* A interrupção acontecerá nestes pinos */
	P1IE |= (BIT4 + BIT5 + BIT7);
}

void pisca(int nbotao)
{
	/* atraso */
	long int n = 0xFF;
	P1DIR |= LEDS;
	
	if((nbotao > 9)||(nbotao < 1))
		nbotao = 0;
	
	for(; nbotao >= 0; nbotao--){
		P1OUT ^= LEDS;
		while(n--);
	}
}

interrupt(PORT1_VECTOR) ISR_qual_botao(void)
{
	char linha;
	int nlinha;
	int botao;
	
	linha = P1IFG;
	/* Zerar a indicação de interrupção */
	P1IFG = 0x00;
	
	/* Achar o número da linha que foi pressionada a tecla */
	switch(linha){
		case 0x02:
		nlinha = 1;
		break;
		
		case 0x04:
		nlinha = 2;
		break;
		
		case 0x08:
		nlinha = 3;
		break;
	}
	
	/* Procurar a coluna onde foi apertada */
	/* Inverter as entradas e saídas */
	P1DIR |= LEDS;
	
	/* P1.1, P1.2 e P1.3 são entradas em pull up */
	P1DIR |= ~(BIT1 + BIT2 + BIT3);
	P1REN |= (BIT1 + BIT2 + BIT3);
	P1OUT |= (BIT1 + BIT2 + BIT3);
	
	/* P1.4, P1.5 e P1.7 são saídas em 0 */
	P1DIR |= (BIT4 + BIT5 + BIT7);
	P1OUT |= ~(BIT4 + BIT5 + BIT7);
	
	/* Verificar entrada */
	if(((P1IN & BIT1) == 0) && (nlinha == 1))
		botao = 1;
	if(((P1IN & BIT2) == 0) && (nlinha == 1))
		botao = 2;
	if(((P1IN & BIT3) == 0) && (nlinha == 1))
		botao = 3;
	
	if(((P1IN & BIT1) == 0) && (nlinha == 2))
		botao = 4;
	if(((P1IN & BIT2) == 0) && (nlinha == 2))
		botao = 5;
	if(((P1IN & BIT3) == 0) && (nlinha == 2))
		botao = 6;
	
	if(((P1IN & BIT1) == 0) && (nlinha == 3))
		botao = 7;
	if(((P1IN & BIT2) == 0) && (nlinha == 3))
		botao = 8;
	if(((P1IN & BIT3) == 0) && (nlinha == 9))
		botao = 9;
	
	pisca(botao);
	
	configura_para_ler_teclado();
}

int main(void)
{
	/* Parar o watchdog timer */
	WDTCTL = WDTPW + WDTHOLD;
	/* Os pinos usados são P1.1, P1.2, P1.3, P1.4, P1.5, P1.7
	 * P1.0 e P1.6 são sempre saídas
	 */
	P1DIR |= LEDS;
	/* Começar desligado */
	P1OUT &= ~LEDS;
	
	/* No início, P1.1, P1.2 e P1.3 são saídas em 0 */
	P1DIR |= (BIT1 + BIT2 + BIT3);
	P1OUT |= ~(BIT1 + BIT2 + BIT3);
	
	/* No início P1.4, P1.5 e P1.7 são entradas com pull up */
	/* Habilitar pull up */
	P1DIR |= ~(BIT4 + BIT5 + BIT7);
	P1REN |= (BIT4 + BIT5 + BIT7);
	P1OUT |= (BIT4 + BIT5 + BIT7);
	
	/* Habilitar interrupção por borda de descida (1)*/
	P1IES |= (BIT4 + BIT5 + BIT7);
	/* A interrupção acontecerá nestes pinos */
	P1IE |= (BIT4 + BIT5 + BIT7);
	/* Habilitar interrupçoes mascaráveis */
	_BIS_SR(GIE);
	
	while(1);
	return 0;
}
