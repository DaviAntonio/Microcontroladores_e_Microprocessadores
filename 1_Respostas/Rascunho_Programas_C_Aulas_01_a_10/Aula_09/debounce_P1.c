#include <msp430.h>
#include <legacymsp430.h>

#define LED1 BIT0
#define LED2 BIT6
#define LEDS (LED1 | LED2)
/* A placa só possui um botão em P1.3, uma entrada. Para permitir mais
 * botões, deve-se mudar a definição da macro BTN, de modo que em um
 * número binário de 8 bits os bits 1 indiquem os pinos que serão
 *  entradas */
#define BTN BIT3


interrupt(PORT1_VECTOR) ISR_debounce_delay_P1(void)
{
	/*
	Para usar essa função é preciso
	Configurar LEDS como saída
	P1DIR |= LEDS;
	A placa possui somente um botão (entrada) na porta P1.3 (0)
	P1DIR &= ~BTN;
	Configurar pull-up e pull-down
	P1REN |= BTN;
	Escolher pull-down no BTN (1)
	P1OUT |= BTN;
	Ligar interrupção por borda de descida (1) no botão P1.3,
	pois é pull-down
	P1IES |= BTN;
	Habilitar interrupção na porta P1.3, o botão
	P1IE |= BTN;
	Permitir as interrupções mascaráveis
	_BIS_SR(GIE);
	 */
	
	/* Desativar o sinal de ocorrência de interrupção para evitar
	 * um loop infinito de chamada de interrupções */
	P1IFG &= ~BTN;
	/* Criar um pequeno atraso */
	unsigned char n = 0xFF;
	while(n--);
	
	if((P1IN & BTN) == 0)
		P1OUT ^= LEDS;
	
	
	
}

int main(void)
{
	/* Parar o watchdog timer */
	WDTCTL = WDTPW | WDTHOLD;
	
	/* Configurar LEDS como saída */
	P1DIR |= LEDS;
	
	/* A placa possui somente um botão (entrada) na porta P1.3 (0) */
	P1DIR &= ~BTN;
	/* Configurar pull-up e pull-down */
	P1REN |= BTN;
	/* Escolher pull-down no BTN (1) */
	P1OUT |= BTN;
	
	/* Ligar interrupção por borda de descida (1) no botão P1.3,
	 *  pois é pull-down */
	P1IES |= BTN;
	/* Habilitar interrupção na porta P1.3, o botão */
	P1IE |= BTN;
	/* Permitir as interrupções mascaráveis */
	_BIS_SR(GIE);
		
	/* Começar desligado */
	P1OUT &= ~LEDS;
		
	while(1);
	
	return 0;
}
