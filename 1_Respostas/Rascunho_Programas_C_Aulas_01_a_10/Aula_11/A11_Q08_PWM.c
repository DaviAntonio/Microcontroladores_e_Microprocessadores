/***********************************************************************
 * Configurar e ligar o Timer_A em modo de comparação. P1.6 já foi 
 * configurado como saída do canal 1 de comparação do Timer_A. 
 * Somente os valores {100, 200, 300, …, 1000} Hz são válidos para a 
 * frequência. Somente os valores {0, 25, 50, 75, 100} % são válidos
 * para o ciclo de trabalho. O sinal de clock SMCLK do MSP430 está 
 * operando a 1 MHz.
 **********************************************************************/

#include <msp430.h>
#include <legacymsp430.h>	/* Habilita interrupções */

/* Funções */
void ConfigPWM(volatile unsigned int freqs, volatile unsigned char \
ciclo_de_trabalho)
{
	float tempo, tempo_ligado;
	/* Converter para uma contagem em us */
	tempo = (float) 1e6*(1.0/(freqs + 0.0));
	/* No modo up, contar o tempo que fica ligado para o ciclo de
	 * trabalho */
	tempo_ligado = (float) ((ciclo_de_trabalho + 0.0)/100.0)*tempo;
	
	/* Configurar o canal de comparação 1 do Timer A0, modo reset
	 * set para o ciclo de trabalho maior corresponder a aumento em
	 * TA0CCR1 */
	TA0CCR0 = ((unsigned int) tempo) - 1;
	TA0CCR1 = (unsigned int) tempo_ligado;
	TA0CCTL1 = OUTMOD_7;
	
	/* Usar SMCLK; não dividi-lo; contar em modo (up), de 0 a 
	 * TA0CCR0 */
	TA0CTL = TASSEL_2 + ID_0 + MC_1;	
}

int main(void)
{
	/* Parar o watchdog timer */
	WDTCTL = WDTPW + WDTHOLD;
	
	/* Configurar MCLK e SMCLK em 1 MHz */
	BCSCTL1 = CALBC1_1MHZ;
	DCOCTL = CALDCO_1MHZ;
	
	/* P1.6 será uma saída e operará em modo de comparação*/
	P1DIR |= BIT6;
	P1SEL |= BIT6;
	P1SEL2 &= ~BIT6;
	
	ConfigPWM(100, 0);
	
	/* Desligar CPU */
	_BIS_SR(LPM0_bits);
	
	/* Nunca chegará */
	return 0;
}
