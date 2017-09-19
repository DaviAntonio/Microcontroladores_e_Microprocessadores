#include <stdio.h>
/*
10. (a) Escreva uma função em C que indica se um vetor é palíndromo. Por exemplo:
	[1 2 3 2 1] e [0 10 20 20 10 0] são palíndromos.
	[5 4 3 2 1] e [1 2 3 2] não são.
Se o vetor for palíndromo, retorne o valor 1. Caso contrário, retorne o valor 0. O protótipo da função é:

```C
int Palindromo(int vetor[ ], int tamanho);
```
*/

/* Retornar 1 se palíndromo e 0 se não for.*/
int Palindromo(int vetor[], int tamanho)
{
	/* Vetores não precisam do \0 ser gravado*/
	int i = 0;
	/* Não precisa comparar todos os elementos do vetor
	 * e.g. tamanho = 5
	 * 0 = 4, 1 = 2, 2 = 2, 3 = 1*/
	tamanho--;
	while(i < tamanho){
		if(vetor[i] != vetor[tamanho - i]){
			printf("Posição - %d FALHOU\n", i);
			return 0;
		}
		printf("Posição - %d OK\n", i);
		i++;
	}
	return 1;
}

int main(void)
{
	int eval;
	puts("\nTeste do vetor 1 2 3 2 1\nDeve ser palídromo.\n\n");
	int vetor_teste_01[5] = {1, 2, 3, 2, 1};
	int tam_vetor_teste_01 = 5;
	eval = Palindromo(vetor_teste_01, tam_vetor_teste_01);
	if(eval == 1) puts("É palíndromo\n");
	else if(eval == 0) puts("Não é palíndromo\n");
	else puts("Erro\n");
	
	puts("\nTeste do vetor 0 10 20 20 10 0\nDeve ser palídromo.\n\n");
	int vetor_teste_02[6] = {0, 10, 20, 20, 10, 0};
	int tam_vetor_teste_02 = 6;
	eval = Palindromo(vetor_teste_02, tam_vetor_teste_02);
	if(eval == 1) puts("É palíndromo\n");
	else if(eval == 0) puts("Não é palíndromo\n");
	else puts("Erro\n");
	
	puts("\nTeste do vetor 5 4 3 2 1\nNão deve ser palíndromo\n");
	int vetor_teste_03[5] = {5, 4, 3, 2, 1};
	int tam_vetor_teste_03 = 5;
	eval = Palindromo(vetor_teste_03, tam_vetor_teste_03);
	if(eval == 1) puts("É palíndromo\n");
	else if(eval == 0) puts("Não é palíndromo\n");
	else puts("Erro\n");
	
	puts("\nTeste do vetor 1 2 3 2\nNão deve ser palíndromo\n");
	int vetor_teste_04[4] = {1, 2, 3, 2};
	int tam_vetor_teste_04 = 4;
	eval = Palindromo(vetor_teste_04, tam_vetor_teste_04);
	if(eval == 1) puts("É palíndromo\n");
	else if(eval == 0) puts("Não é palíndromo\n");
	else puts("Erro\n");
	
	puts("\nTeste do vetor 1, 2, 3, 4, 5, 3, 2, 1\nNão deve ser palíndromo\n");
	int vetor_teste_05[8] = {1, 2, 3, 4, 5, 3, 2, 1};
	int tam_vetor_teste_05 = 8;
	eval = Palindromo(vetor_teste_05, tam_vetor_teste_05);
	if(eval == 1) puts("É palíndromo\n");
	else if(eval == 0) puts("Não é palíndromo\n");
	else puts("Erro\n");
	return 0;
}
