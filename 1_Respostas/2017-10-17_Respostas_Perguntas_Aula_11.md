# Respostas às Perguntas Aula 11
## Data: 17/10/2017
1. Defina a função `void Atraso(volatile unsigned int x);` que fornece um atraso de `x` milissegundos. Utilize o Timer_A para a contagem de tempo, e assuma que o SMCLK já foi configurado para funcionar a 1 MHz. Esta função poderá ser utilizada diretamente nas outras questões desta prova.
```C
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
```

2. Pisque os LEDs da Launchpad numa frequência de 100 Hz.

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

# Frequencia 100 Hz

```C
#include <msp430.h>
#include <legacymsp430.h>	/* Habilita interrupções */

#define LED1 BIT0
#define LED2 BIT6
#define LEDS (LED1|LED2)

#define TEMPO_MS_METADE 5

/*
 * freq = 100 Hz;	tempo = 10 ms;		tempo/2 = 5ms
 * freq = 20 Hz;	tempo = 50 ms;		tempo/2 = 25 ms
 * freq = 1 Hz;		tempo = 1000 ms;	tempo/2 = 500 ms
 * freq = 0,5 Hz;	tempo = 2000 ms;	tempo/2 = 1000 ms
 */

void Configura_Timer(volatile unsigned int x)
{
	/* 1000 contagens de 1 us = 1 ms, mas conta o zero (up) */
	TA0CCR0 = x - 1;
	
	/* Usar SMCLK, não dividi-lo, contar em modo up e ligar a
	 * interrupção de término da contagem */
	TA0CTL = TASSEL_2 + ID_0 + MC_1 + TAIE;
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
	P1OUT |= ~LEDS;

	Configura_Timer(TEMPO_MS_METADE);

	_BIS_SR(GIE + LPM0_bits);
	
	/* Nunca chegará */

	return 0;
}

interrupt(TIMER0_A1_VECTOR) InterrupcaoP1(void)
{
	TA0CTL &= ~TAIFG;
	
	static int i = 0;
	
	i = (i + 1) % 1000;
	
	if(i == 0)
		P1OUT ^= LEDS;
}


```

# Frequencia 20 Hz

```C
#include <msp430.h>
#include <legacymsp430.h>	/* Habilita interrupções */

#define LED1 BIT0
#define LED2 BIT6
#define LEDS (LED1|LED2)

#define TEMPO_MS_METADE 25

/*
 * freq = 100 Hz;	tempo = 10 ms;		tempo/2 = 5ms
 * freq = 20 Hz;	tempo = 50 ms;		tempo/2 = 25 ms
 * freq = 1 Hz;		tempo = 1000 ms;	tempo/2 = 500 ms
 * freq = 0,5 Hz;	tempo = 2000 ms;	tempo/2 = 1000 ms
 */

void Configura_Timer(volatile unsigned int x)
{
	/* 1000 contagens de 1 us = 1 ms, mas conta o zero (up) */
	TA0CCR0 = x - 1;
	
	/* Usar SMCLK, não dividi-lo, contar em modo up e ligar a
	 * interrupção de término da contagem */
	TA0CTL = TASSEL_2 + ID_0 + MC_1 + TAIE;
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
	P1OUT |= ~LEDS;

	Configura_Timer(TEMPO_MS_METADE);

	_BIS_SR(GIE + LPM0_bits);
	
	/* Nunca chegará */

	return 0;
}

interrupt(TIMER0_A1_VECTOR) InterrupcaoP1(void)
{
	TA0CTL &= ~TAIFG;
	
	static int i = 0;
	
	i = (i + 1) % 1000;
	
	if(i == 0)
		P1OUT ^= LEDS;
}


```

# Frequencia 1 Hz

```C
#include <msp430.h>
#include <legacymsp430.h>	/* Habilita interrupções */

#define LED1 BIT0
#define LED2 BIT6
#define LEDS (LED1|LED2)

#define TEMPO_MS_METADE 500

/*
 * freq = 100 Hz;	tempo = 10 ms;		tempo/2 = 5ms
 * freq = 20 Hz;	tempo = 50 ms;		tempo/2 = 25 ms
 * freq = 1 Hz;		tempo = 1000 ms;	tempo/2 = 500 ms
 * freq = 0,5 Hz;	tempo = 2000 ms;	tempo/2 = 1000 ms
 */

void Configura_Timer(volatile unsigned int x)
{
	/* 1000 contagens de 1 us = 1 ms, mas conta o zero (up) */
	TA0CCR0 = x - 1;
	
	/* Usar SMCLK, não dividi-lo, contar em modo up e ligar a
	 * interrupção de término da contagem */
	TA0CTL = TASSEL_2 + ID_0 + MC_1 + TAIE;
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
	P1OUT |= ~LEDS;

	Configura_Timer(TEMPO_MS_METADE);

	_BIS_SR(GIE + LPM0_bits);
	
	/* Nunca chegará */

	return 0;
}

interrupt(TIMER0_A1_VECTOR) InterrupcaoP1(void)
{
	TA0CTL &= ~TAIFG;
	
	static int i = 0;
	
	i = (i + 1) % 1000;
	
	if(i == 0)
		P1OUT ^= LEDS;
}


```

# Frequencia 0,5 Hz

```C
#include <msp430.h>
#include <legacymsp430.h>	/* Habilita interrupções */

#define LED1 BIT0
#define LED2 BIT6
#define LEDS (LED1|LED2)

#define TEMPO_MS_METADE 1000

/*
 * freq = 100 Hz;	tempo = 10 ms;		tempo/2 = 5ms
 * freq = 20 Hz;	tempo = 50 ms;		tempo/2 = 25 ms
 * freq = 1 Hz;		tempo = 1000 ms;	tempo/2 = 500 ms
 * freq = 0,5 Hz;	tempo = 2000 ms;	tempo/2 = 1000 ms
 */

void Configura_Timer(volatile unsigned int x)
{
	/* 1000 contagens de 1 us = 1 ms, mas conta o zero (up) */
	TA0CCR0 = x - 1;
	
	/* Usar SMCLK, não dividi-lo, contar em modo up e ligar a
	 * interrupção de término da contagem */
	TA0CTL = TASSEL_2 + ID_0 + MC_1 + TAIE;
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
	P1OUT |= ~LEDS;

	Configura_Timer(TEMPO_MS_METADE);

	_BIS_SR(GIE + LPM0_bits);
	
	/* Nunca chegará */

	return 0;
}

interrupt(TIMER0_A1_VECTOR) InterrupcaoP1(void)
{
	TA0CTL &= ~TAIFG;
	
	static int i = 0;
	
	i = (i + 1) % 1000;
	
	if(i == 0)
		P1OUT ^= LEDS;
}


```

7. Defina a função `void paralelo_para_serial(void);` que lê o byte de entrada via porta P1 e transmite os bits serialmente via pino P2.0. Comece com um bit em nivel alto, depois os bits na ordem P1.0 - P1.1 - … - P1.7 e termine com um bit em nível baixo. Considere um período de 1 ms entre os bits.

```C
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
```

8. Faça o programa completo que lê um byte de entrada serialmente via pino P2.0 e transmite este byte via porta P1. O sinal serial começa com um bit em nivel alto, depois os bits na ordem 0-7 e termina com um bit em nível baixo. Os pinos P1.0-P1.7 deverão corresponder aos bits 0-7, respectivamente. Considere um período de 1 ms entre os bits.

```C
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

```

9. Defina a função `void ConfigPWM(volatile unsigned int freqs, volatile unsigned char ciclo_de_trabalho);` para configurar e ligar o Timer_A em modo de comparação. Considere que o pino P1.6 já foi anteriormente configurado como saída do canal 1 de comparação do Timer_A, que somente os valores {100, 200, 300, …, 1000} Hz são válidos para a frequência, que somente os valores {0, 25, 50, 75, 100} % são válidos para o ciclo de trabalho, e que o sinal de clock SMCLK do MSP430 está operando a 1 MHz.

```C
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
```

Exemplo de Código usando a função
```C
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

```















