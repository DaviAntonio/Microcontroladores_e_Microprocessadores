#include <msp430.h>

/* Verifica primalidade em assembly */
int main(void)
{
	WDTCTL = WDTPW + WDTHOLD;
	asm(
	"call #Primalidade \n"
	"keep: \n"
	"jmp keep \n"
	
	
	"Primalidade: \n"
	"; R15 = numero, R14 = máximo, R13 = 1 e i, R12 = numteste \n"
	"; Se for 2, é primo \n"
	"mov.w #2, R14 \n"
	"cmp.w R14, R15 \n"
	"jz Primalidade_primo \n"
	"; Configurar o valor máximo no R14 \n"
	"mov.w R15, R14 \n"
	"dec.w R14 \n"
	"rra.w R14 \n"
	"; Gravar 1 no R13 \n"
	"mov.w #1, R13 \n"
	"; Testar se R15 é 1 (1 ñ é primo) \n"
	"cmp.w R13, R15 \n"
	"jz Primalidade_nao_primo \n"
	"; Testar se R15 é múltiplo de 2 \n"
	"bit.w R13, R15 \n"
	"jz Primalidade_nao_primo \n"
	
	"; Testar se R15 não é múltiplo de 3 \n"
	"push.w R15 \n"
	"push.w R14 \n"
	"push.w R13 \n"
	"mov.w #3, R14 \n"
	"call #resto_divisao \n"
	"tst.w R15 \n"
	"; pop não altera as flags de N, C, Z \n"
	"pop.w R13 \n"
	"pop.w R14 \n"
	"pop.w R15 \n"
	"jz Primalidade_nao_primo \n"
	
	
	"; R13 = 2, agora R13 = i \n"
	"mov.w #2, R13 \n"

	"Primalidade_loop: \n"
	"cmp.w R14, R13 \n"
	"jge Primalidade_primo \n"

	";Antes de chamar a função, salvar os registradores utilizados aqui \n"
	"push.w R15 \n"
	"push.w R14 \n"
	"push.w R13 \n"

	"; Realizar o teste (x % ((i << 1) + 1) \n"
	"mov.w R13, R12 \n"
	"rla.w R12 \n"
	"inc.w R12 \n"
	"mov.w R12, R14 \n"
	"; Agora resto da divisão R15/R12 \n"
	"call #resto_divisao \n"
	"; Verificar se o resto é zero \n"
	"tst.w R15 \n"
	"jz Primalidade_nao_primo \n"
	"; recuperar o i original \n"
	"pop.w R13 \n"
	"inc.w R13 \n"
	"; Antes de pular, recuperar os originais antes do teste \n"
	"pop.w R14 \n"
	"pop.w R15 \n"
	"jmp Primalidade_loop \n"


	"Primalidade_primo: \n"
	"mov.w #1, R15 \n"
	"ret \n"

	"Primalidade_nao_primo: \n"
	"mov.w #0, R15 \n"
	"ret \n"

	"; A função, subrotina, de resto da divisão \n"
	"resto_divisao: \n"
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
	"ret"
	);
	while(1);
	return 0;
}

/**/
Primalidade:
; R15 = numero, R14 = máximo, R13 = 1 e i, R12 = numteste
; Se for 2, é primo
mov.w #2, R14
cmp.w R14, R15
jz Primalidade_primo
; Configurar o valor máximo no R14
mov.w R15, R14
dec.w R14
rra.w R14
; Gravar 1 no R13
mov.w #1, R13
; Testar se R15 é 1 (1 ñ é primo)
cmp.w R13, R15
jz Primalidade_nao_primo
; Testar se R15 é múltiplo de 2
bit.w R13, R15
jz Primalidade_nao_primo

; Testar se R15 não é múltiplo de 3
push.w R15
push.w R14
push.w R13
mov.w #3, R14
call #resto_divisao
tst.w R15
; pop não altera as flags de N, C, Z
pop.w R13
pop.w R14
pop.w R15
jz Primalidade_nao_primo


; R13 = 2, agora R13 = i
mov.w #2, R13
Primalidade_loop:
cmp.w R14, R13
jge Primalidade_primo

;Antes de chamar a função, salvar os registradores utilizados aqui
push.w R15
push.w R14
push.w R13

; Realizar o teste (x % ((i << 1) + 1)
mov.w R13, R12
rla.w R12
inc.w R12
mov.w R12, R14
; Agora resto da divisão R15/R12
call #resto_divisao
; Verificar se o resto é zero
tst.w R15
jz Primalidade_nao_primo
; recuperar o i original
pop.w R13
inc.w R13
; Antes de pular, recuperar os originais antes do teste
pop.w R14
pop.w R15
jmp Primalidade_loop


Primalidade_primo:
mov.w #1, R15
ret

Primalidade_nao_primo:
mov.w #0, R15
ret

; A função, subrotina, de resto da divisão
resto_divisao:
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
ret
*/
