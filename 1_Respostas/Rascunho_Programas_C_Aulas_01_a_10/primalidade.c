/*
 * Função que testa a primalidade de um número
 * Retorna 1 se for primo, 0 se não for
 * int Primalidade(unsigned int x);
 */

//gcc -Wall -pedantic -g3 primalidade.c -o tprim

#include <stdio.h>

int Primalidade(unsigned int x)
{
	int i;
/* Não precisamos testar os números múltiplos de 2 nas divisões
 *  n mod m = n % m = n & (m - 1), para m = 2^k, k pertencente a N
*/
	if(x == 2)
		return 1;
	int max = (x - 1) >> 1;
	if((x == 1) || !(x & 1) || !(x % 3))
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
	unsigned int num;
	puts("\nDigite número para testar se é primo\n");
	scanf("%u", &num);
	printf("\n%u\n", num);
	if(Primalidade(num))
		puts("É primo\n\n");
	else
		puts("Não é primo\n\n");
	return 0;
}
