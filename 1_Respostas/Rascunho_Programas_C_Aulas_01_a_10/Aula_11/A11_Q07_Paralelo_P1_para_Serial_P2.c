/***********************************************************************
 * Lê o byte de entrada via porta P1 e transmite os bits serialmente via
 * pino P2.0. Comece com um bit em nivel alto, depois os bits na ordem 
 * P1.0 - P1.1 - … - P1.7 e termine com um bit em nível baixo.
 * Considere um período de 1 ms entre os bits.
 **********************************************************************/

#include <msp430.h>
#include <legacymsp430.h>	/* Habilita interrupções */

#define TODOSPINOS 0xFF
#define TEMPOBITS_US 1000

/***********************************************************************
 * Funções
 **********************************************************************/
void configura_atraso_us(unsigned int x)
{
	/* Configurar quantos us contará, máximo de 2^16 */
	TA0CCR0 = x - 1;
	
	/* Usar SMCLK; não dividi-lo; contar em modo (up), de 0 a TA0CCR0
	 * e ativar a interrupção de término de contagem */
	TA0CTL = TASSEL_2 + ID_0 + MC_1 + TAIE;
}

void paralelo_para_serial(void)
{
	static unsigned char nporta = 0;
	
	/* Os pinos vão de 0 a 7 e são preservados entre as chamadas
	 * da função */
	nporta = (nporta + 1) % 10;
	
	/* Enviar o 1o bit em nível alto */
	if(nporta == 0)
		P2OUT |= BIT0;
	
	/* Varrer P1 e colocar o nível de P2.0 de acordo */
	if((nporta > 0) && (nporta < 9)){
		if(P1IN & (1 << (nporta - 1)))
			P2OUT |= BIT0;
		else
			P2OUT &= ~BIT0;
	}
	
	/* Enviar o último bit em nível baixo */
	if(nporta == 9)
		P2OUT &= ~BIT0;
		
		
}

/***********************************************************************
 * Rotinas de interrupção
 **********************************************************************/
interrupt(TIMER0_A0_VECTOR) terminou_tempo_ms(void)
{
	/* Desligar a flag de interrupção */
	TA0CTL &= ~TAIFG;
	paralelo_para_serial();
}

int main(void)
{
	/* Parar o watchdog timer */
	WDTCTL = WDTPW + WDTHOLD;
	
	/* Configurar MCLK e SMCLK em 1 MHz */
	BCSCTL1 = CALBC1_1MHZ;
	DCOCTL = CALDCO_1MHZ;
	
	/* Configurar P1 tudo como entrada */
	P1DIR = TODOSPINOS;
	
	/* Configurar P2.0 como saída */
	P2DIR |= BIT0;
	
	configura_atraso_us(TEMPOBITS_US);
	
	/* Desligar MCLK, o processador e ativar interrupções
	 * mascaráveis */
	_BIS_SR(LPM0_bits + GIE);
	
	/* Não chegará a este ponto, pois a CPU foi desligada */ 
	return 0;
}
