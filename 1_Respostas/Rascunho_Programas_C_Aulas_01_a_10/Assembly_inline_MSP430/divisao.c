/*
* Divisão
*/

#include <msp430.h>

int main(void)
{
	WDTCTL = WDTPW | WDTHOLD;
	asm(
	"; Recebe dividendo no R15 e divisor no R14 \n"
	"; Entrega quociente em R15 \n"
	"call #divisao \n"
	"keep: \n"
	"jmp keep \n"
	
	"divisao: \n"
	"clr.w R13 \n"
	"tst.w R14 \n"
	"jnz divisao_loop \n"
	"mov.w #0xFFFF, R15 \n"
	"ret \n"
	
	"divisao_loop: \n"
	"; Guardar o quociente no R13 \n"
	"; Subtrair: R15 = R15 - R14 se R15 > R14 \n"
	"cmp R14, R15 \n"
	"jl result \n"
	"sub.w R14, R15 \n"
	"inc.w R13 \n"
	"jmp divisao_loop \n"
	
	"result: \n"
	"; Queremos o quociente, então colocar o R13 no R15 \n"
	"; Se quiser só o resto, R15 já estará pronto \n"
	"mov.w R13, R15 \n"
	"ret"
	);
	while(1)

// Nunca chegará
	return 0;
}

/*
	; Recebe dividendo no R15 e divisor no R14
	; Entrega quociente em R15
	call #divisao
	keep:
	jmp keep
	
	divisao:
	clr.w R13
	tst.w R14
	jnz divisao_loop
	mov.w #0xFFFF, R15
	ret
	
	divisao_loop:
	; Guardar o quociente no R13
	; Subtrair: R15 = R15 - R14 se R15 > R14
	cmp R14, R15
	jl result
	sub.w R14, R15
	inc.w R13
	jmp divisao_loop
	
	result:
	; Queremos o quociente, então colocar o R13 no R15
	; Se quiser só o resto, R15 já estará pronto
	mov.w R13, R15
	ret
*/
