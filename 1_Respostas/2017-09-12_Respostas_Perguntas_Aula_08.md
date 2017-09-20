# Respostas às Perguntas Aula 08
## Data: 12/09/2017
Para todas as questões, utilize os LEDs e/ou os botões da placa Launchpad do MSP430.

1. Escreva um código em C que pisca os LEDs ininterruptamente.

```C
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
```

2. Escreva um código em C que pisca os LEDs ininterruptamente. No ciclo que pisca os LEDs, o tempo que os LEDs ficam ligados deve ser duas vezes maior do que o tempo que eles ficam desligados.


```C
/*
* Piscar os LEDs initerruptamente, LED1 e LED2, com atraso arbitrário, mas o
* intervalo de ligado é 2 vezes o intervalo desligado.
*/

#include <msp430.h>

#define LED1 BIT0
#define LED2 BIT6
#define LEDS (LED1 | LED2)


void atraso(volatile unsigned int n)
{
	while(n--);
}

int main(void)
{
// Parar o watchdog timer
	WDTCTL = WDTPW | WDTHOLD;
// Configurar os LEDs como saída
	P1DIR |= LEDS;
// Piscar LEDs ininterruptamente
	while(1){
// Ligado
		P1OUT |= LEDS;
		atraso(0xFFFF);
		atraso(0xFFFF);
// Desligado
		P1OUT ^= LEDS;
		atraso(0xFFFF);
	}
	return 0;
}
```

3. Escreva um código em C que acende os LEDs quando o botão é pressionado.

```C
BTN;
/*
* Acender os LEDs quando botão é pressionado e desligar quando o botão é solto.
*/

#include <msp430.h>

#define LED1 BIT0
#define LED2 BIT6
#define LEDS (LED1 | LED2)
#define BTN BIT3

int main(void)
{
// Parar o watchdog timer
	WDTCTL = WDTPW | WDTHOLD;
// Configurar os LEDs como saída
	P1DIR |= LEDS;
// Setar o BTN 3 como entrada (0)
	P1DIR &= ~BTN;
// Configurar pull-up e pull-down
	P1REN |= BTN;
// Escolher pull-up
	P1OUT |= BTN;
// Começar desligado
	P1OUT &= ~LEDS;

	while(1){
	if((P1IN & BTN) == 0)
// Acender os LEDs
		P1OUT |= LEDS;
	else
// Desligar LEDs ao soltar
		P1OUT &= ~LEDS;
	}
	return 0;
}
```

4. Escreva um código em C que pisca os LEDs ininterruptamente somente se o botão for pressionado.

```C
/*
* Piscar os LEDs quando botão é pressionado.
*/

#include <msp430.h>
#include <legacymsp430.h>	// Habilita interrupções

#define LED1 BIT0
#define LED2 BIT6
#define LEDS (LED1 | LED2)
#define BTN BIT3


void atraso(volatile unsigned int n)
{
	while(n--);
}

interrupt(PORT1_VECTOR) ISR_botao_P13(void)
{
// A interrupção retira do modo de baixo consumo
// Piscar LEDs ininterruptamente enquanto botão apertado
	while(1){
		if((P1IN & BTN) == 0){
// Piscar os LEDs
			P1OUT ^= LEDS;
// Sem o atraso é difícil ver os LEDs piscando
			atraso(0xFFFF);
		}else{
// Desligar LEDs ao soltar
			P1OUT &= ~LEDS;
			break;
		}
	}
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
// Escolher pull-up
	P1OUT |= BTN;
// Ligar interrupção por borda de descida (1) no botão P1.3, pois é pull-up
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
```

5. Escreva um código em C que acende os LEDs quando o botão é pressionado. Deixe o MSP430 em modo de baixo consumo, e habilite a interrupção do botão.


```C
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
// Escolher pull-up
	P1OUT |= BTN;
// Ligar interrupção por borda de descida (1) no botão P1.3, pois é pull-up
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
```




