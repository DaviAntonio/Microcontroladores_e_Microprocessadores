/*
 * Multiplicação Binária sem Sinal 15 = R15*R14
 * Recebe dois números int nos registradores R15 e R14 (nessa ordem) e
 * retorna o resultado no registrador R15
 */

#include <msp430.h>

int main(void)
{
	WDTCTL = WDTPW | WDTHOLD;
	asm(
	"; Instrução inútil para colocar o breakpoint antes do call \n"
	"dummy: \n"
	"clr.w R13 \n"
	"call #mult_unsigned \n"
	"; Quando a multiplicação retornar, loop infinito \n"
	"keep: \n"
	"jmp keep \n"
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
	while(1)

// Nunca chegará
	return 0;
}

/*
Assembly
; Instrução inútil para colocar o breakpoint antes do call
	dummy:
	clr.w R13
	
	call mult_unsigned
	; Quando a multiplicação retornar, loop infinito
	keep:
	jmp keep
	
	; Recebe R15 e R14
	mult_unsigned:
	; Se R14 = 0, retornar 0 em R15 e sair da função
	tst.w R14
	jnz mult_op
	clr.w R15
	ret
	
	mult_op:
	; Guardar R15 na pilha, precisaremos dele, já que quando R14 = 0,
	; limparemos o R15
	push.w R15
	; a*b = a + a + a + ... + a (b vezes)
	dec.w R14
	call mult_unsigned
	; Quando R14 = 0, um ret fará SP vir para cá
	; Precisamos recuperar R15 da pilha e colocar em R14
	pop.w R14
	; R14 = R15, então agora é só ir somando até as R14 vezes
	add.w R14, R15
	ret
*/
