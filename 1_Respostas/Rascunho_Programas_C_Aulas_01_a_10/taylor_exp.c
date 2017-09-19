/*
 * Escreva uma função em C que calcula a função exponencial utilizando
 * a série de Taylor da mesma. Considere o cálculo até o termo n = 20.
 * O protótipo da função é `double ExpTaylor(double x);`
 */

#include <stdio.h>

unsigned int fatorial(int n)
{
	unsigned int res = n;
	if(n < 0)
		return 0;
	if((n == 0) || (n == 1))
		return 1;
	while(--n){
		res *= n;
		/* Debugar a função de fatorial
		printf("n = %u, res_temp = %u\n", n, res);
		*/
	}
	/*puts("\n");*/
	return res;
}

/*
 * Função em C que calcula `x` elevado à `N`-ésima potência
 */
 double Potencia(double x, int N)
{
	double a = 1;
	while(N > 0){
		a *= x;
		/* Debugar a função de potência
		printf("N = %d, x = %lf\n", N, a);
		*/
		N--;
	}
	return a;
}


double ExpTaylor(double x)
{
	int max_ordem = 20;
	double res = 0;
	int i;
	for(i = 0; i <= max_ordem; i++)
		res += (Potencia(x, i)) / ((double)fatorial(i));
	return res;
}


int main(void)
{
	/* Testar a função fatorial
	unsigned int n;
	puts("\nNfat?\n");
	scanf("%u", &n);
	printf("res = %u\n", fatorial(n));
	*/
	
	/* Testar a função Potência
	int N;
	double x;
	puts("\nDigite 'x N', onde x é o número (double) e N a potência (int)\n");
	scanf("%lf %d", &x, &N);
	printf("Resultado de %lf^%d é %lf\n\n", x, N, Potencia(x, N));
	return 0;
	*/
	
	double x;
	puts("\nDigite o valor que quer de x para e^x\n");
	scanf("%lf", &x);
	printf("O resultado do Taylor de ordem 20 para e^%lf é: %lf\n",
	 x, ExpTaylor(x));
	return 0;
	
}
