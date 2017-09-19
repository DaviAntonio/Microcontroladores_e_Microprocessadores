# Respostas às Perguntas Aula 09
## Data: 18/09/2017
1. Escreva uma função em C que faz o debounce de botões ligados à porta P1.

```C
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
}
```

2. Escreva um código em C que lê 9 botões multiplexados por 6 pinos, e pisca os LEDs da placa Launchpad de acordo com os botões. Por exemplo, se o primeiro botão é pressionado, os LEDs piscam uma vez; se o segundo botão é pressionado, os LEDs piscam duas vezes; e assim por diante. Se mais de um botão é pressionado, os LEDs não piscam.







