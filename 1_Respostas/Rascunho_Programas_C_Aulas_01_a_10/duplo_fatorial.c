# include <stdio.h>
/*
 * 6. Escreva uma função em C que calcula o duplo fatorial de n,
 * representado por n!!. Se n for ímpar, n!! = 1*3*5*...*n, e se n for
 * par, n!! = 2*4*6*...*n. Por exemplo, 9!! = 1*3*5*7*9 = 945 e 
 * 10!! = 2*4*6*8*10 = 3840. Além disso, 0!! = 1!! = 1.
 * O protótipo da função é:
 * 
```C
unsigned long long DuploFatorial(unsigned long long n);
*/

//gcc -Wall -pedantic -g3 duplo_fatorial.c -o dfat

unsigned long long DuploFatorial(unsigned long long n);

int main(void)
{
	unsigned long long int n;
	puts("\nDigite número para o qual quer o fatorial duplo\n");
	scanf("%llu", &n);
	printf("\n%llu\n", n);
	printf("O resultado é %llu\n\n", DuploFatorial(n));
	return 0;
}

unsigned long long DuploFatorial(unsigned long long n)
{
	int k;
	unsigned long long int dfat = 1;
	if((n == 0) || (n == 1))
		return 1;
	
	if((n & 0x0000000000000001) == 0){ // é par
		puts("\nÉ par\n");
		for(k = 1; k <= (n >> 1); k++)
			dfat *= (2*k);
		return dfat;
	} else {
		puts("\nÉ ímpar\n");
		for(k = 1; k <= (n >> 1); k++)
			dfat *= (2*k + 1);
		return dfat;
	}
}
