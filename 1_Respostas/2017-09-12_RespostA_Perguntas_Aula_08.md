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

4. Escreva um código em C que pisca os LEDs ininterruptamente somente se o botão for pressionado.

5. Escreva um código em C que acende os LEDs quando o botão é pressionado. Deixe o MSP430 em modo de baixo consumo, e habilite a interrupção do botão.







