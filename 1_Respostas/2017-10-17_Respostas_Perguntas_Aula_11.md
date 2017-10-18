# Respostas às Perguntas Aula 11
## Data: 17/10/2017
1. Defina a função `void Atraso(volatile unsigned int x);` que fornece um atraso de `x` milissegundos. Utilize o Timer_A para a contagem de tempo, e assuma que o SMCLK já foi configurado para funcionar a 1 MHz. Esta função poderá ser utilizada diretamente nas outras questões desta prova.

```C
#include <msp430.h>

#define LED1 BIT0
#define LED2 BIT6
#define LEDS (LED1|LED2)

void Atraso(volatile unsigned int x)
{
	int i;
	
	for(i = 0; i < 1000; i++){ 
	/* 1000 contagens de 1 us = 1 ms, mas conta o zero (up) */
	TA0CCR0 = x - 1;
	
	/* Usar SMCLK, não dividi-lo e contar em modo up */
	TA0CTL = TASSEL_2 + ID_0 + MC_1;
	
	/* Espera terminar contagem */
	while((TA0CTL & TAIFG) == 0);
	}
	
	/* Parar e zerar o timer */
	TA0CTL = MC_0 + TACLR;
	TA0CTL &= ~TAIFG;
}

int main(void)
{
	/* Parar o watchdog timer */
	WDTCTL = WDTPW + WDTHOLD;
	
	/* SMCLK = MCLK = 1 MHz */
	BCSCTL1 = CALBC1_1MHZ;
	DCOCTL = CALDCO_1MHZ;
	
	/* Colocar LEDS como saída */
	P1DIR |= LEDS;
	
	/* Desligados */
	P1OUT |= ~LEDS;

	while(1){
		Atraso(5);
		P1OUT ^= LEDS;
		Atraso(5);
	}

	return 0;
}

```

3. Pisque os LEDs da Launchpad numa frequência de 20 Hz.

```C
#include <msp430.h>

#define LED1 BIT0
#define LED2 BIT6
#define LEDS (LED1|LED2)

void Atraso(volatile unsigned int x)
{
	int i;
	
	for(i = 0; i < 1000; i++){ 
	/* 1000 contagens de 1 us = 1 ms, mas conta o zero (up) */
	TA0CCR0 = x - 1;
	
	/* Usar SMCLK, não dividi-lo e contar em modo up */
	TA0CTL = TASSEL_2 + ID_0 + MC_1;
	
	/* Espera terminar contagem */
	while((TA0CTL & TAIFG) == 0);
	}
	
	/* Parar e zerar o timer */
	TA0CTL = MC_0 + TACLR;
	TA0CTL &= ~TAIFG;
}

int main(void)
{
	/* Parar o watchdog timer */
	WDTCTL = WDTPW + WDTHOLD;
	
	/* SMCLK = MCLK = 1 MHz */
	BCSCTL1 = CALBC1_1MHZ;
	DCOCTL = CALDCO_1MHZ;
	
	/* Colocar LEDS como saída */
	P1DIR |= LEDS;
	
	/* Desligados */
	P1OUT |= ~LEDS;

	while(1){
		Atraso(25);
		P1OUT ^= LEDS;
		Atraso(25);
	}

	return 0;
}
```

4. Pisque os LEDs da Launchpad numa frequência de 1 Hz.

```C
#include <msp430.h>

#define LED1 BIT0
#define LED2 BIT6
#define LEDS (LED1|LED2)

void Atraso(volatile unsigned int x)
{
	int i;
	
	for(i = 0; i < 1000; i++){ 
	/* 1000 contagens de 1 us = 1 ms, mas conta o zero (up) */
	TA0CCR0 = x - 1;
	
	/* Usar SMCLK, não dividi-lo e contar em modo up */
	TA0CTL = TASSEL_2 + ID_0 + MC_1;
	
	/* Espera terminar contagem */
	while((TA0CTL & TAIFG) == 0);
	}
	
	/* Parar e zerar o timer */
	TA0CTL = MC_0 + TACLR;
	TA0CTL &= ~TAIFG;
}

int main(void)
{
	/* Parar o watchdog timer */
	WDTCTL = WDTPW + WDTHOLD;
	
	/* SMCLK = MCLK = 1 MHz */
	BCSCTL1 = CALBC1_1MHZ;
	DCOCTL = CALDCO_1MHZ;
	
	/* Colocar LEDS como saída */
	P1DIR |= LEDS;
	
	/* Desligados */
	P1OUT |= ~LEDS;

	while(1){
		Atraso(500);
		P1OUT ^= LEDS;
		Atraso(500);
	}

	return 0;
}
```

5. Pisque os LEDs da Launchpad numa frequência de 0,5 Hz.

```C
#include <msp430.h>

#define LED1 BIT0
#define LED2 BIT6
#define LEDS (LED1|LED2)

void Atraso(volatile unsigned int x)
{
	int i;
	
	for(i = 0; i < 1000; i++){ 
	/* 1000 contagens de 1 us = 1 ms, mas conta o zero (up) */
	TA0CCR0 = x - 1;
	
	/* Usar SMCLK, não dividi-lo e contar em modo up */
	TA0CTL = TASSEL_2 + ID_0 + MC_1;
	
	/* Espera terminar contagem */
	while((TA0CTL & TAIFG) == 0);
	}
	
	/* Parar e zerar o timer */
	TA0CTL = MC_0 + TACLR;
	TA0CTL &= ~TAIFG;
}

int main(void)
{
	/* Parar o watchdog timer */
	WDTCTL = WDTPW + WDTHOLD;
	
	/* SMCLK = MCLK = 1 MHz */
	BCSCTL1 = CALBC1_1MHZ;
	DCOCTL = CALDCO_1MHZ;
	
	/* Colocar LEDS como saída */
	P1DIR |= LEDS;
	
	/* Desligados */
	P1OUT |= ~LEDS;

	while(1){
		Atraso(1000);
		P1OUT ^= LEDS;
		Atraso(1000);
	}

	return 0;
}
```

6. Repita as questões 2 a 5 usando a interrupção do Timer A para acender ou apagar os LEDs.

7. Defina a função `void paralelo_para_serial(void);` que lê o byte de entrada via porta P1 e transmite os bits serialmente via pino P2.0. Comece com um bit em nivel alto, depois os bits na ordem P1.0 - P1.1 - … - P1.7 e termine com um bit em nível baixo. Considere um período de 1 ms entre os bits.

8. Faça o programa completo que lê um byte de entrada serialmente via pino P2.0 e transmite este byte via porta P1. O sinal serial começa com um bit em nivel alto, depois os bits na ordem 0-7 e termina com um bit em nível baixo. Os pinos P1.0-P1.7 deverão corresponder aos bits 0-7, respectivamente. Considere um período de 1 ms entre os bits.

9. Defina a função `void ConfigPWM(volatile unsigned int freqs, volatile unsigned char ciclo_de_trabalho);` para configurar e ligar o Timer_A em modo de comparação. Considere que o pino P1.6 já foi anteriormente configurado como saída do canal 1 de comparação do Timer_A, que somente os valores {100, 200, 300, …, 1000} Hz são válidos para a frequência, que somente os valores {0, 25, 50, 75, 100} % são válidos para o ciclo de trabalho, e que o sinal de clock SMCLK do MSP430 está operando a 1 MHz.


















