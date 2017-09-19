/*
 * msp430-gcc -mmcu=msp430g2553 -Wall -pedantic -g3 Primalidade.c -o Primalidade.elf
 */
#include <msp430.h>

int Primalidade(unsigned int x)
{
	int i, max;
/* Não precisamos testar os números múltiplos de 2 nas divisões
 *  n mod m = n % m = n & (m - 1), para m = 2^k, k pertencente a N
*/
	if(x == 2)
		return 1;
	max = (x - 1) >> 1;
	if((x == 1) || !(x & 1))
		return 0;
/* 
 * Se o número for divisível por qualquer um menor que ele, não será
 * primo. Do contrário, será primo.
 * 2 é primo e 1 não é.
 */
	for(i = 2; i < max; i++)
		if((x % ((i << 1) + 1)) == 0)
			return 0;
	return 1;
}


int main(void)
{
	int num, eprimo;
	WDTCTL = WDTPW + WDTHOLD;
	eprimo = Primalidade(num);
	while(1);
	return 0;
}

/*
__asm__(
	"Primalidade: \n"
	"; R15 = numero, R14 = máximo, R13 = 1 e i, R12 = numteste \n"
	"; Se for 2, é primo \n"
	"mov.w #2, R14 \n"
	"cmp.w R14, R15 \n"
	"jz Primalidade_primo \n"
	"; Configurar o valor máximo no R14 \n"
	"mov.w R15, R14 \n"
	"dec.w R14 \n"
	"rra.w R14 \n"
	"; Gravar 1 no R13 \n"
	"mov.w #1, R13 \n"
	"; Testar se R15 é 1 (1 ñ é primo) \n"
	"cmp.w R13, R15 \n"
	"jz Primalidade_nao_primo \n"
	"; Testar se R15 é múltiplo de 2 \n"
	"bit.w R13, R15 \n"
	"jz Primalidade_nao_primo \n"
	"; R13 = 2, agora R13 = i \n"
	"mov.w #2, R13 \n"
	"Primalidade_loop: \n"
	"cmp.w R13, R14 \n"
	"jeq Primalidade_primo \n"
	"mov.w R13, R12 \n"
	"rla.w R12 \n"
	"bit.w R12, R15 \n"
	"jz Primalidade_nao_primo \n"
	"inc.w R13 \n"
	"jmp Primalidade_loop \n"
	"Primalidade_primo: \n"
	"mov.w #1, R15 \n"
	"jmp keep \n"
	"Primalidade_nao_primo: \n"
	"mov.w #0, R15 \n"
	"jmp keep \n"
	"keep: \n"
	"jmp keep");
*/


