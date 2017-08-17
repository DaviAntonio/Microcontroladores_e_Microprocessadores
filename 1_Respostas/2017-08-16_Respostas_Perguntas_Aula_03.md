1. Dada uma variável `a` do tipo `char` (um byte), escreva os trechos de código em C para:
	(a) Somente setar o bit menos significativo de `a`.
```C
a |= 0x01;
```
	(b) Somente setar dois bits de `a`: o menos significativo e o segundo menos significativo.
```C
a |= 0x03;
```
	(c) Somente zerar o terceiro bit menos significativo de `a`.
```C
a &= (~0x04);
```
	(d) Somente zerar o terceiro e o quarto bits menos significativo de `a`.
```C
a &= (~0x0C);
```
	(e) Somente inverter o bit mais significativo de `a`.
```C
a ^= 0x80;
```
	(f) Inverter o nibble mais significativo de `a`, e setar o nibble menos significativo de `a`.
```C
a ^= 0xF0;
a |= 0x0F;
```

2. Considerando a placa Launchpad do MSP430, escreva o código em C para piscar os dois LEDs ininterruptamente.
```C
#include <msp430g2553.h>
#define LED1 BIT0
#define LED2 BIT6
#define LEDS (LED1|LED2)

int main(void)
{
	WDTCTL = WDTPW | WDTHOLD;
	P1DIR |= LEDS; // Definir LEDS como saída
	P1OUT = 0x00; // Inicia a saída em nível baixo
	while(1)
		P1OUT ^= LEDS; // Piscar os LEDS (toggle)
	return 0;
}
```

3. Considerando a placa Launchpad do MSP430, escreva o código em C para piscar duas vezes os dois LEDs sempre que o usuário pressionar o botão.
```C
#include <msp430g2553.h>
#define LED1 BIT0
#define LED2 BIT6
#define LEDS (LED1|LED2)
#define BTN BIT3

int main(void)
{
	WDTCTL = WDTPW | WDTHOLD;
	P1DIR |= LEDS; // Definir LEDS como saída
	P1OUT = 0x00; // Inicia a saída em nível baixo
	while(1) {
		while(((P1IN&BTN) =! 0);
		// Não fazer nada enquanto botão não é ativado
		P1OUT ^= LEDS;
		P1OUT ^= LEDS; // Pisca 1 vez
		P1OUT ^= LEDS;
		P1OUT ^= LEDS; // 2 vezes
		// Quando apertar o botão (nível baixo), piscar
		while(((P1IN&BTN) == 0);
		// Não piscar mais de 2 vezes se segurar o botão
	}
	return 0;
}
```

4. Considerando a placa Launchpad do MSP430, faça uma função em C que pisca os dois LEDs uma vez.
```C
#include <msp430g2553.h>
#define LED1 BIT0
#define LED2 BIT6
#define LEDS (LED1|LED2)

void pisca_leds (void)
{
	P1OUT ^= LEDS;
	P1OUT ^= LEDS;

}
```

5. Reescreva o código da questão 2 usando a função da questão 4.
```C
#include <msp430g2553.h>
#define LED1 BIT0
#define LED2 BIT6
#define LEDS (LED1|LED2)

void pisca_leds (void)
{
	P1OUT ^= LEDS;
	P1OUT ^= LEDS;

}

int main(void)
{
	WDTCTL = WDTPW | WDTHOLD;
	P1DIR |= LEDS; // Definir LEDS como saída
	P1OUT = 0x00; // Inicia a saída em nível baixo
	while(1)
		pisca_leds(); // Piscar os LEDS (toggle)
	return 0;
}
```

6. Reescreva o código da questão 3 usando a função da questão 4.
```C
#include <msp430g2553.h>
#define LED1 BIT0
#define LED2 BIT6
#define LEDS (LED1|LED2)
#define BTN BIT3

void pisca_leds (void)
{
	P1OUT ^= LEDS;
	P1OUT ^= LEDS;

}

int main(void)
{
	int i;
	WDTCTL = WDTPW | WDTHOLD;
	P1DIR |= LEDS; // Definir LEDS como saída
	P1OUT = 0x00; // Inicia a saída em nível baixo
	while(1) {
		while(((P1IN&BTN) =! 0);
		// Não fazer nada enquanto botão não é ativado
		for(i = 0; i < 2; i++)
			pisca_leds();
			// Quando apertar o botão (nível baixo), piscar
		while(((P1IN&BTN) == 0);
		// Não piscar mais de 2 vezes se segurar o botão
	}
	return 0;
}
```
