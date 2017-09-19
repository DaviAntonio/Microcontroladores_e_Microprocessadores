#include <msp430.h>

int main(void)
{
	WDTCTL = WDTPW + WDTHOLD;
	asm(
	"; Calcular x^N \n" 
	"; Colocar valor x = R15 e N = R14 \n"
	"call #Potencia \n"
	"keep: \n"
	"jmp keep \n"

	"; Incompleto \n"
	"; R15 = x, R14 = N \n"

	"Potencia: \n"
	"; Colocar 1 em R13, a \n"
	"mov.w #1, R13 \n"

	"Potencia_loop: \n"
	"tst.w R14 \n"
	"jz Potencia_retorno \n"

	"; Salvar valores de R15 e R14 da função de potência antes de chamar \n"
	"; a função de multiplicação \n"
	"push.w R15 \n"
	"push.w R14 \n"

	";A função de potência salvaria o resultado no a = R13 para passar \n"
	";para o R15 no final \n"
	";A multiplicação a ser feita é a (R13) = a (R13) * x (R15) \n"
	";A função de multiplicação receberá x (R15) e a, transferido para R14 \n"
	
	"mov.w R13, R14 \n"

	"call #mult_unsigned \n"
	
	"mov.w R15, R13 \n"

	"pop.w R14 \n"
	"pop.w R15 \n"

	"dec.w R14 \n"
	"jmp Potencia_loop \n"

	"Potencia_retorno: \n"
	"mov.w R13, R15 \n"
	"ret \n"

	"; Recebe R15 e R14 \n"
	"mult_unsigned: \n"
	"; Se R14 = 0, retornar 0 em R15 e sair da função \n"
	"tst.w R14 \n"
	"jnz mult_op \n"
	"clr.w R15 \n"
	"ret \n"
	
	"mult_op: \n"
	"; Guardar R15 na pilha, precisaremos dele, já que quando R14 = 0, \n"
	"; limparemos o R15 \n"
	"push.w R15 \n"
	"; a*b = a + a + a + ... + a (b vezes) \n"
	"dec.w R14 \n"
	"call #mult_unsigned \n"
	
	"; Quando R14 = 0, um ret fará SP vir para cá \n"
	"; Precisamos recuperar R15 da pilha e colocar em R14 \n"
	"pop.w R14 \n"
	"; R14 = R15, então agora é só ir somando até as R14 vezes \n"
	"add.w R14, R15 \n"
	"ret"
	);
	return 0;
}
