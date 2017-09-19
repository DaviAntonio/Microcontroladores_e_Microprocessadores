/*
* Acender e apagar os LEDs quando botão é pressionado.
* Usando interrupção na P1.3 (botão) e LPM (baixo consumo)
*/

#include <msp430.h>
#include <legacymsp430.h>	// Habilita interrupções

#define LED1 BIT0
#define LED2 BIT6
#define LEDS (LED1 | LED2)
#define BTN BIT3

interrupt(PORT1_VECTOR) ISR_botao_P13(void)
{
// A interrupção retira do modo de baixo consumo
// Ligar e desligar LEDs quando apertar o botão (inicia desligado)
	if((P1IN & BTN) == 0)
		P1OUT ^= LEDS;
/* Limpar o aviso de interrupção, para que ela não seja chamada eternamente
*/
	P1IFG &= ~BTN;
}

int main(void)
{
// Parar o watchdog timer
	WDTCTL = WDTPW | WDTHOLD;
// Configurar os LEDs como saída
	P1DIR |= LEDS;
// Setar o BTN P1.3 como entrada (0)
	P1DIR &= ~BTN;
// Configurar pull-up e pull-down no BTN P1.3
	P1REN |= BTN;
// Escolher pull-down
	P1OUT |= BTN;
// Ligar interrupção por borda de descida (1) no botão P1.3, pois é pull-down
	P1IES |= BTN;
// Habilitar interrupção na porta P1.3, o botão
	P1IE |= BTN;
// Permitir as interrupções mascaráveis
	_BIS_SR(GIE);

// Começar com LEDs desligados
	P1OUT &= ~LEDS;
	
// Colocar no modo de mais baixo consumo
	_BIS_SR(LPM4_bits);
	
// Não alcançar o return
	while(1);

	return 0;
}
