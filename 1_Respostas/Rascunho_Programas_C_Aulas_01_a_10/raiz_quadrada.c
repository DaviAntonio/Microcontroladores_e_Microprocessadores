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

//gcc -Wall -pedantic -g3 raiz_quadrada.c -o qraiz

unsigned int Raiz_Quadrada(unsigned int S)
{
	/* unsigned int x0, x1, eps, i = 0; */
	unsigned int x0, x1, i = 0;
	
	/* Raiz quadrada de 1 é 1 */
	if(S == 1) return 1;
	/* Raiz quadrada de zero é zero */
	if(S == 0) return 0;
	
	/* Chute inicial */
	x0 = S >> 1;
	/* do{
		x1 = (x0 + (S/x0)) >> 1;
		eps = x0 - x1;
		printf("Iteração: %u\tx0 = %u\tx1 = %u\teps = %u\n",
		i, x0, x1, eps);
		x0 = x1;
		i++;
	}while((eps > 0) && (i <= 20));
	}while(i <= 20);*/
	
	/* Testes revelam que o algoritmo consegue o resultado correto em até
	* 20 iterações para um unsigned int.
	*/
	while(i <= 20){
		x1 = (x0 + (S/x0)) >> 1;
		x0 = x1;
		i++;
	}
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
