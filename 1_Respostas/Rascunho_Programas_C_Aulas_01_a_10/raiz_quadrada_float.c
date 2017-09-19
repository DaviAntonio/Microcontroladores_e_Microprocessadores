#include <stdio.h>

/*
* Calcula a raiz quadrada `x` de uma variável `S` do tipo float,
* utilizando o seguinte algoritmo: após `n+1` iterações, a raiz
* quadrada de `S` é dada por
* x(n+1) = (x(n) + S/x(n))/2
* 
* O protótipo da função é:
*/

//unsigned int Raiz_Quadrada(unsigned int S);

//gcc -Wall -pedantic -g3 raiz_quadrada_float.c -o qraizf

unsigned int Raiz_Quadrada(unsigned int S)
{
	float x0, x1, eps;
	int i = 0;
	x0 = S/2.0;
	do{
		x1 = (x0 + (S/x0))/2.0;
		eps = x0 - x1;
		printf("Iteração: %u\tx0 = %u\tx1 = %u\teps = %u\n",
		i, x0, x1, eps);
		x0 = x1;
		i++;
	}while((eps > 0) && (i > 0));
	return x1;
}

int main(void)
{
	unsigned int num, raiznum;
	puts("\nDigite número que deseja a raiz\n");
	scanf("%u", &num);
	raiznum = Raiz_Quadrada(num);
	printf("\nO resultado: %u\n\n", raiznum);
	return 0;
}
