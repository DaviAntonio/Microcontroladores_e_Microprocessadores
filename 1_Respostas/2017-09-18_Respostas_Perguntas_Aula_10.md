# Respostas às Perguntas Aula 10
## Data: 18/09/2017
1. Projete o hardware necessário para o MSP430 controlar um motor DC de 12V e 4A. Utilize transistores bipolares de junção (TBJ) com Vbe = 0,7 V, beta = 100 e Vce(saturação) = 0,2 V. Além disso, considere que Vcc = 3 V para o MSP430, e que este não pode fornecer mais do que 10 mA por porta digital.

	Como será utilizado um motor DC, será necessário um diodo de proteção.
	Se usarmos apenas um transistor, o MSP proposto não conseguirá suprir a corrente suficiente na base.
	
	I_c = beta \* I_b => I_b = I_c / beta = 4 / 100 => **I_b = 40 mA**
	
	A solução é utilizar um par de Darlington para diminuir a corrente de base fornecida pelo MSP.
	
	I_c = (beta^2) \* I_b => I_b = I_c / (beta^2) = 4 / (100^2) => **I_b = 0,4 mA**
	
	O resistor na base, conectado à porta digital do MSP pode ser dimensionado pela seguinte equação:
	
	R_b = (Vcc - 2 \* Vbe) / I_b = (3 - 2 \* 0,7) / 0,4 \* 10^(-3) => **R_b = 4 k ohms**


2. Projete o hardware necessário para o MSP430 controlar um motor DC de 10V e 1A. Utilize transistores bipolares de junção (TBJ) com Vbe = 0,7 V e beta = 120. Além disso, considere que Vcc = 3,5 V para o MSP430, e que este não pode fornecer mais do que 10 mA por porta digital.

	Como será utilizado um motor DC, será necessário um diodo de proteção.
	Usando apenas um transistor, o MSP conseguirá fornecer a corrente necessária na base.
	
	I_c = beta \* I_b => I_b = I_c / beta = 1 / 120 => **I_b = 8,333 mA**
	
	O resistor na base, conectado à porta digital do MSP pode ser dimensionado pela seguinte equação:
	
	R_b = (Vcc - Vbe) / I_b = (3,5 - 0,7) \* 120 => **R_b = 336 ohms**

3. Projete o hardware utilizado para controlar 6 LEDs utilizando charlieplexing. Apresente os pinos utilizados no MSP430 e os LEDs, nomeados L1-L6.

```
P1.0----R-------------------------------------------------
                  |       |                       |       |
                L1▼     L2▲                       |       |
                  |       |                       |       |
P1.1----R--------------------------             L5▼     L6▲
                          |       |               |       |
                        L3▼     L4▲               |       |
                          |       |               |       |
P1.2----R-------------------------------------------------
```

4. Defina a função `void main(void){}` para controlar 6 LEDs de uma árvore de natal usando o hardware da questão anterior. Acenda os LEDs de forma que um ser humano veja todos acesos ao mesmo tempo.

```C
/* Fazer o charlieplex de 6 leds, de modo que aparentem estar acesos
 * ao mesmo tempo
P1.0----R-------------------------------------------------
                  |       |                       |       |
                L1▼     L2▲                       |       |
                  |       |                       |       |
P1.1----R--------------------------             L5▼     L6▲
                          |       |               |       |
                        L3▼     L4▲               |       |
                          |       |               |       |
P1.2----R-------------------------------------------------
*/

#include <msp430.h>

void main(void)
{
	/* Contador para passar em todos os LEDs */
	int i = 0;
	/* Parar o watchdog timer */
	WDTCTL = WDTPW + WDTHOLD;
	/* Para ligar L1
	 * fazemos P1.0 = 1, P1.1 = 0, P1.2 entrada
	 * L2
	 * P1.0 = 0, P1.1 = 1, P1.2 entrada
	 * (+) anodo ---▶|--- catodo (-)
	 */
	 char  anodo[6] = {BIT0, BIT1, BIT1, BIT2, BIT0, BIT2};
	 char catodo[6] = {BIT1, BIT0, BIT2, BIT1, BIT2, BIT0};
	 while(1){
		 /* Colocar todos os pinos como entrada, de modo que o
		  * que for escrito neles será bufferizado e será
		  * colocado como saída ao mudar o P1DIR correspondente.
		  */
		 P1DIR &= ~(BIT0 + BIT1 + BIT2);
		 /* O (+), 1 deve estar na porta correspondente */
		 P1OUT |= anodo[i];
		 /* O (-), 0, também */
		 P1OUT &= ~(catodo[i]);
		 /* As portas de saída são colocadas (1), e a outra 
		  * porta continua em entrada (0), alta impedância, para
		  * que o charlieplexing funcione. */
		 P1DIR |= anodo[i] + catodo[i];
		 /* Precisamos zerar o i assim que ele atingir o 6 ou
		  * ocorrerá erro.
		  * i sempre receberá o resto da divisão de i+1 por 6, 
		  * que retornará zero quando i for 6, pois o vetor é
		  * numerado de 0 a 5, contendo 6 posições. */
		 i = (i + 1)%6;
	 }
}

```

5. Defina a função `void main(void){}` para controlar 6 LEDs de uma árvore de natal usando o hardware da questão 3. Acenda os LEDs de forma que um ser humano veja os LEDs L1 e L2 acesos juntos por um tempo, depois os LEDs L3 e L4 juntos, e depois os LEDs L5 e L6 juntos.

```C
/* Fazer o charlieplex de 6 leds, de modo que aparentem estar acesos
 * ao mesmo tempo
P1.0----R-------------------------------------------------
                  |       |                       |       |
                L1▼     L2▲                       |       |
                  |       |                       |       |
P1.1----R--------------------------             L5▼     L6▲
                          |       |               |       |
                        L3▼     L4▲               |       |
                          |       |               |       |
P1.2----R-------------------------------------------------
*/

#include <msp430.h>

void main(void)
{
	/* Atraso */
	int n;
	/* Parar o watchdog timer */
	WDTCTL = WDTPW + WDTHOLD;
	/* Para ligar L1
	 * fazemos P1.0 = 1, P1.1 = 0, P1.2 entrada
	 * L2
	 * P1.0 = 0, P1.1 = 1, P1.2 entrada
	 * (+) anodo ---▶|--- catodo (-)
	 */
	 char  anodo[6] = {BIT0, BIT1, BIT1, BIT2, BIT0, BIT2};
	 char catodo[6] = {BIT1, BIT0, BIT2, BIT1, BIT2, BIT0};
	 while(1){
		 /* Colocar todos os pinos como entrada, de modo que o
		  * que for escrito neles será bufferizado e será
		  * colocado como saída ao mudar o P1DIR correspondente.
		  * P1DIR &= ~(BIT0 + BIT1 + BIT2);
		  */
		 
		 /* O (+), 1 deve estar na porta correspondente 
		  *  P1OUT |= anodo[i];
		  */
		
		 /* O (-), 0, também
		  * P1OUT &= ~(catodo[i]);
		  */
		 
		 /* As portas de saída são colocadas (1), e a outra 
		  * porta continua em entrada (0), alta impedância, para
		  * que o charlieplexing funcione. 
		  * P1DIR |= anodo[i] + catodo[i];
		  */
		 
		 n = 0xFF;
		 while(n--){
			 P1DIR &= ~(BIT0 + BIT1 + BIT2);
			 P1OUT |= anodo[0];
			 P1OUT &= ~(catodo[0]);
			 P1DIR |= anodo[0] + catodo[0];
			 
			 P1DIR &= ~(BIT0 + BIT1 + BIT2);
			 P1OUT |= anodo[1];
			 P1OUT &= ~(catodo[1]);
			 P1DIR |= anodo[1] + catodo[1];
		}
		
		n = 0xFF;
		 while(n--){
			 P1DIR &= ~(BIT0 + BIT1 + BIT2);
			 P1OUT |= anodo[2];
			 P1OUT &= ~(catodo[2]);
			 P1DIR |= anodo[2] + catodo[2];
			 
			 P1DIR &= ~(BIT0 + BIT1 + BIT2);
			 P1OUT |= anodo[3];
			 P1OUT &= ~(catodo[3]);
			 P1DIR |= anodo[3] + catodo[3];
		}
		
		n = 0xFF;
		 while(n--){
			 P1DIR &= ~(BIT0 + BIT1 + BIT2);
			 P1OUT |= anodo[4];
			 P1OUT &= ~(catodo[4]);
			 P1DIR |= anodo[4] + catodo[4];
			 
			 P1DIR &= ~(BIT0 + BIT1 + BIT2);
			 P1OUT |= anodo[5];
			 P1OUT &= ~(catodo[5]);
			 P1DIR |= anodo[5] + catodo[5];
		}
	 }
}

```

6. Defina a função `void EscreveDigito(volatile char dig);` que escreve um dos dígitos 0x0-0xF em um único display de 7 segmentos via porta P1, baseado na figura abaixo. Considere que em outra parte do código os pinos P1.0-P1.6 já foram configurados para corresponderem aos LEDs A-G, e que estes LEDs possuem resistores externos para limitar a corrente.

```
        ---  ==> A
       |   |
 F <== |   | ==> B
       |   |
        ---  ==> G
       |   |
 E <== |   | ==> C
       |   |
        ---  ==> D
```

```C
/*
 * Defina a função `void EscreveDigito(volatile char dig);` que escreve 
 * um dos dígitos 0x0-0xF em um único display de 7 segmentos via porta
 * P1, baseado na figura abaixo. Considere que em outra parte do código
 * os pinos P1.0-P1.6 já foram configurados para corresponderem aos LEDs
 * A-G, e que estes LEDs possuem resistores externos para limitar a
 * corrente.

        ---  ==> A
       |   |
 F <== |   | ==> B
       |   |
        ---  ==> G
       |   |
 E <== |   | ==> C
       |   |
        ---  ==> D
 */

#include <msp430.h>

void EscreveDigito(volatile char dig)
{
	/* Zerar P1OUT dos LEDs sempre que chamar a função */
	P1OUT &= ~0x7F;
	/* Considerar a ordem G...A = P1.6 ... P1.0 pois
	* P1OUT = P1.7...P1.0 */
	/* Catodo (-) comum, se anodo (+) é só inverter ~ */
	const char zero = 	0x3F;
	const char one = 	0x06;
	const char two =	0x5B;
	const char three =	0x4F;
	const char four =	0x66;
	const char five =	0x6D;
	const char six =	0x7D;
	const char seven = 	0x07;
	const char eight = 	0x7F;
	const char nine = 	0x6F;
	const char A10 =	0x77;
	const char B11 = 	0x7C;
	const char C12 =	0x39;
	const char D13 =	0x5E;
	const char E14 =	0x79;
	const char F15 =	0x71;
	
	switch(dig){
		case '0':
		P1OUT |= zero;
		break;
		
		case '1':
		P1OUT |= one;
		break;
		
		case '2':
		P1OUT |= two;
		break;
		
		case '3':
		P1OUT |= three;
		break;
		
		case '4':
		P1OUT |= four;
		break;
		
		case '5':
		P1OUT |= five;
		break;
		
		case '6':
		P1OUT |= six;
		break;
		
		case '7':
		P1OUT |= seven;
		break;
		
		case '8':
		P1OUT |= eight;
		break;
		
		case '9':
		P1OUT |= nine;
		break;
		
		case 'A':
		P1OUT |= A10;
		break;
		
		case 'B':
		P1OUT |= B11;
		break;
		
		case 'C':
		P1OUT |= C12;
		break;
		
		case 'D':
		P1OUT |= D13;
		break;
		
		case 'E':
		P1OUT |= E14;
		break;
		
		case 'F':
		P1OUT |= F15;
		break;
	}
}
```


7. Multiplexe 2 displays de 7 segmentos para apresentar a seguinte sequência em loop:
	00 - 11 - 22 - 33 - 44 - 55 - 66 - 77 - 88 - 99 - AA - BB - CC - DD - EE - FF

```C
#include <msp430.h>

/*
 * Defina a função `void EscreveDigito(volatile char dig);` que escreve 
 * um dos dígitos 0x0-0xF em um único display de 7 segmentos via porta
 * P1, baseado na figura abaixo. Considere que em outra parte do código
 * os pinos P1.0-P1.6 já foram configurados para corresponderem aos LEDs
 * A-G, e que estes LEDs possuem resistores externos para limitar a
 * corrente.

        ---  ==> A
       |   |
 F <== |   | ==> B
       |   |
        ---  ==> G
       |   |
 E <== |   | ==> C
       |   |
        ---  ==> D
 */

void EscreveDigito(volatile char dig)
{
	/* Zerar P1OUT dos LEDs sempre que chamar a função */
	P1OUT &= ~0x7F;
	/* Considerar a ordem G...A = P1.6 ... P1.0 pois
	* P1OUT = P1.7...P1.0 */
	/* Catodo comum (-), se anodo (+) é só inverter ~ */
	const char zero = 	0x3F;
	const char one = 	0x06;
	const char two =	0x5B;
	const char three =	0x4F;
	const char four =	0x66;
	const char five =	0x6D;
	const char six =	0x7D;
	const char seven = 	0x07;
	const char eight = 	0x7F;
	const char nine = 	0x6F;
	const char A10 =	0x77;
	const char B11 = 	0x7C;
	const char C12 =	0x39;
	const char D13 =	0x5E;
	const char E14 =	0x79;
	const char F15 =	0x71;
	
	switch(dig){
		case '0':
		P1OUT |= zero;
		break;
		
		case '1':
		P1OUT |= one;
		break;
		
		case '2':
		P1OUT |= two;
		break;
		
		case '3':
		P1OUT |= three;
		break;
		
		case '4':
		P1OUT |= four;
		break;
		
		case '5':
		P1OUT |= five;
		break;
		
		case '6':
		P1OUT |= six;
		break;
		
		case '7':
		P1OUT |= seven;
		break;
		
		case '8':
		P1OUT |= eight;
		break;
		
		case '9':
		P1OUT |= nine;
		break;
		
		case 'A':
		P1OUT |= A10;
		break;
		
		case 'B':
		P1OUT |= B11;
		break;
		
		case 'C':
		P1OUT |= C12;
		break;
		
		case 'D':
		P1OUT |= D13;
		break;
		
		case 'E':
		P1OUT |= E14;
		break;
		
		case 'F':
		P1OUT |= F15;
		break;
	}
}

void main(void)
{
	char sequencia[16] = {'0', '1', '2', '3', '4', '5', '6', '7',
				'8', '9', 'A', 'B', 'C', 'D', 'E', 'F'};
	int i = 0;
	/* Usar como catodos P2.0 e P2.1 */
	/* Selecionar os P1.0 a P1.6 como saídas */
	P1DIR |= 0x7F;
	
	/* Selecionar como saídas P2.0 e P2.1 */
	P2DIR |= (BIT0 + BIT1);
	
	while(1){
		EscreveDigito(sequencia[i]);
		P2OUT |= BIT0;
		P2OUT &= ~BIT1;
		
		P2OUT |= BIT1;
		P2OUT &= ~BIT0;
		
		i = (i + 1)%16;
	}
} 

```





