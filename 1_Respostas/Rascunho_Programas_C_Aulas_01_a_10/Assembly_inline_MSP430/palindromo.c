

#include <msp430.h>

void executa_palindromo_asm(int vetor[], int tamanho)
{
	asm(
	"; O endereço do primeiro vetor é colocado em R15, e o tamanho em R14 \n"
	"; R13 = i, R12 = 2*i, R11 = &R15 + 2*i = &R15[i] \n"
	"; R10 = &vector[tam - i] = &R15 + 2*tam -2*i = &R15 + 2*R14 -R12 \n"
	"Palindromo: \n"
	"; Usaremos registradores que podem estar sendo usados por outras funções \n"
	"push.w R11 \n"
	"push.w R10 \n"
	"; Limpar o R13, i = 0, decrementar R14, tam. \n"
	"clr.w R13 \n"
	"dec.w R14 \n"

	"Palindromo_loop: \n"
	"cmp.w R14, R13 \n"
	"jge Eh_Palindromo \n"
	"; Multiplicar i por 2, pois o MSP só acessa os endereços pares, e guardar em R12 \n"
	"mov.w R13, R12 \n"
	"rla.w R12 \n"
	"; Inicializar R11 \n"
	"mov.w R15, R11 \n"
	"add.w R12, R11 \n"
	"; Inicializar R10 \n"
	"mov.w R15, R10 \n"
	"add.w R14, R10 \n"
	"add.w R14, R10 \n"
	"sub.w R12, R10 \n"
	"; Comparar as duas posições do vetor \n"
	"cmp.w 0(R11), 0(R10) \n"
	"jne Nao_Eh_Palindromo \n"
	"inc.w R13 \n"
	"jmp Palindromo_loop \n"

	"Eh_Palindromo: \n"
	"mov.w #1, R15 \n"
	"pop.w R10 \n"
	"pop.w R11 \n"
	"ret \n"

	"Nao_Eh_Palindromo: \n"
	"mov.w #0, R15 \n"
	"pop.w R10 \n"
	"pop.w R11 \n"
	"ret"
	);
}

int main(void)
{
	WDTCTL = WDTPW + WDTHOLD;
	//int eval;
	//puts("\nTeste do vetor 1 2 3 2 1\nDeve ser palídromo.\n\n");
	//int vetor_teste_01[5] = {1, 2, 3, 2, 1};
	//int tam_vetor_teste_01 = 5;
	//executa_palindromo_asm(vetor_teste_01, tam_vetor_teste_01);
	//if(eval == 1) puts("É palíndromo\n");
	//else if(eval == 0) puts("Não é palíndromo\n");
	//else puts("Erro\n");
	
	
	//puts("\nTeste do vetor 0 10 20 20 10 0\nDeve ser palídromo.\n\n");
	//int vetor_teste_02[6] = {0, 10, 20, 20, 10, 0};
	//int tam_vetor_teste_02 = 6;
	//executa_palindromo_asm(vetor_teste_02, tam_vetor_teste_02);
	//if(eval == 1) puts("É palíndromo\n");
	//else if(eval == 0) puts("Não é palíndromo\n");
	//else puts("Erro\n");
	
	//puts("\nTeste do vetor 5 4 3 2 1\nNão deve ser palíndromo\n");
	int vetor_teste_03[5] = {5, 4, 3, 2, 1};
	int tam_vetor_teste_03 = 5;
	executa_palindromo_asm(vetor_teste_03, tam_vetor_teste_03);
	//if(eval == 1) puts("É palíndromo\n");
	//else if(eval == 0) puts("Não é palíndromo\n");
	//else puts("Erro\n");
	/*
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
	*/
	while(1);
	return 0;
}
