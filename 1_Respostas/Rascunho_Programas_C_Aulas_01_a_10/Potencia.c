#include <stdio.h>

/*
 * Função em C que calcula `x` elevado à `N`-ésima potência, seguindo o
 * seguinte protótipo: 
 * 
 * int Potencia(int x, int N);
 * 
 */

//gcc -Wall -pedantic -g3 Potencia.c -o pot

int Potencia(int x, int N);

int main(void)
{
	int x, N;
	puts("\nDigite 'x N', onde x é o número e N a potência\n");
	scanf("%d %d", &x, &N);
	printf("Resultado de %d^%d é %d\n\n", x, N, Potencia(x, N));
	return 0;
}

int Potencia(int x, int N)
{
	int a = 1;
	while(N > 0){
		a *= x;
		printf("N = %d, x = %d\n", N, a);
		N--;
	}
	return a;
}
