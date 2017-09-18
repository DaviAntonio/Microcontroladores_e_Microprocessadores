# Respostas às Perguntas Aula 06 e 07
## Data: 07/09/2017
Para cada questão, escreva funções em C e/ou sub-rotinas na linguagem Assembly do MSP430. Reaproveite funções e sub-rotinas de uma questão em outra, se assim desejar. Leve em consideração que as sub-rotinas são utilizadas em um código maior, portanto utilize adequadamente os registradores R4 a R11. As instruções da linguagem Assembly do MSP430 se encontram ao final deste texto.

1. (a) Escreva uma função em C que calcule a raiz quadrada `x` de uma variável `S` do tipo float, utilizando o seguinte algoritmo: após `n+1` iterações, a raiz quadrada de `S` é dada por

```
x(n+1) = (x(n) + S/x(n))/2
```

O protótipo da função é:

```C
unsigned int Raiz_Quadrada(unsigned int S);
```

```C
unsigned int Raiz_Quadrada(unsigned int S)
{
	unsigned int x0, x1, i = 0;

	/* Raiz quadrada de 1 é 1 */
	if(S == 1) return 1;
	/* Raiz quadrada de zero é zero */
	if(S == 0) return 0;
	
	/* Chute inicial */
	x0 = S >> 1;
	
	/*
	* Testes revelam que o algoritmo consegue o resultado correto em até
	* 20 iterações para um unsigned int.
	*/
	while(i <= 20){
		x1 = (x0 + (S/x0)) >> 1;
		x0 = x1;
		i++;
	}
	return x1;
}
```

(b) Escreva a sub-rotina equivalente na linguagem Assembly do MSP430. A variável `S` é fornecida pelo registrador R15, e a raiz quadrada de `S` (ou seja, a variável `x`) é fornecida pelo registrador R15 também.

2. (a) Escreva uma função em C que calcule `x` elevado à `N`-ésima potência, seguindo o seguinte protótipo: 

```C
int Potencia(int x, int N);
```

```C
int Potencia(int x, int N)
{
	int a = 1;
	while(N > 0){
		a *= x;
		N--;
	}
	return a;
}
```

(b) Escreva a sub-rotina equivalente na linguagem Assembly do MSP430. `x` e `n` são fornecidos através dos registradores R15 e R14, respectivamente, e a saída deverá ser fornecida no registrador R15.

```
	; Calcular x^N
	; Colocar valor x = R15 e N = R14
	; Para usar: call #Potencia

	; R15 = x, R14 = N
	Potencia:
	; Colocar 1 em R13, a
	mov.w #1, R13

	Potencia_loop:
	tst.w R14
	jz Potencia_retorno

	; Salvar valores de R15 e R14 da função de potência antes de chamar
	; a função de multiplicação
	push.w R15
	push.w R14

	;A função de potência salvaria o resultado no a = R13 para passar
	;para o R15 no final
	;A multiplicação a ser feita é a (R13) = a (R13) * x (R15)
	;A função de multiplicação receberá x (R15) e a, transferido para R14
	
	mov.w R13, R14

	call #mult_unsigned
	
	mov.w R15, R13

	pop.w R14
	pop.w R15

	dec.w R14
	jmp Potencia_loop

	Potencia_retorno:
	mov.w R13, R15
	ret

	; Recebe R15 e R14
	mult_unsigned:
	; Se R14 = 0, retornar 0 em R15 e sair da função
	tst.w R14
	jnz mult_op
	clr.w R15
	ret
	
	mult_op: \n"
	; Guardar R15 na pilha, precisaremos dele, já que quando R14 = 0,
	; limparemos o R15
	push.w R15
	; a*b = a + a + a + ... + a (b vezes)
	dec.w R14
	call #mult_unsigned

	; Quando R14 = 0, um ret fará SP vir para cá \n"
	; Precisamos recuperar R15 da pilha e colocar em R14
	pop.w R14
	; R14 = R15, então agora é só ir somando até as R14 vezes
	add.w R14, R15
	ret
```


3. Escreva uma sub-rotina na linguagem Assembly do MSP430 que calcula a divisão de `a` por `b`, onde `a`, `b` e o valor de saída são inteiros de 16 bits. `a` e `b` são fornecidos através dos registradores R15 e R14, respectivamente, e a saída deverá ser fornecida através do registrador R15.

```
	; Recebe dividendo no R15 e divisor no R14
	; Entrega quociente em R15
	
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
```

4. Escreva uma sub-rotina na linguagem Assembly do MSP430 que calcula o resto da divisão de `a` por `b`, onde `a`, `b` e o valor de saída são inteiros de 16 bits. `a` e `b` são fornecidos através dos registradores R15 e R14, respectivamente, e a saída deverá ser fornecida através do registrador R15.

```
	; Recebe dividendo no R15 e divisor no R14
	; Entrega resto da divisão em R15
	
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
```

5. (a) Escreva uma função em C que indica a primalidade de uma variável inteira sem sinal, retornando o valor 1 se o número for primo, e 0, caso contrário. Siga o seguinte protótipo:

```C
int Primalidade(unsigned int x);
```

```C
int Primalidade(unsigned int x)
{
	int i;
/* Não precisamos testar os números múltiplos de 2 nas divisões
 *  n mod m = n % m = n & (m - 1), para m = 2^k, k pertencente a N
*/
	if(x == 2)
		return 1;
	int max = (x - 1) >> 1;
	if((x == 1) || !(x & 1))
		return 0;
/* 
 * Se o número for divisível por qualquer um menor que ele, não será
 * primo. Do contrário, será primo.
 * 2 é primo e 1 não é.
 */
	for(i = 2; i < max; i++)
		if((x % ((i << 1) + 1)) == 0)
			return 0;
	return 1;
}
```

(b) Escreva a sub-rotina equivalente na linguagem Assembly do MSP430. A variável de entrada é fornecida pelo registrador R15, e o valor de saída também.

```
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
```

6. Escreva uma função em C que calcula o duplo fatorial de n, representado por n!!. Se n for ímpar, n!! = 1*3*5*...*n, e se n for par, n!! = 2*4*6*...*n. Por exemplo, 9!! = 1*3*5*7*9 = 945 e 10!! = 2*4*6*8*10 = 3840. Além disso, 0!! = 1!! = 1.
O protótipo da função é:

```C
unsigned long long DuploFatorial(unsigned long long n);
```

```C
unsigned long long DuploFatorial(unsigned long long n)
{
	int k;
	unsigned long long int dfat = 1;
	if((n == 0) || (n == 1))
		return 1;

        // testar o LSB
	if((n & 0x0000000000000001) == 0){
	// é par, n!! = 2*4*6*...*n
		for(k = 1; k <= (n >> 1); k++)
			dfat *= (2*k);
		return dfat;
	} else {
	// é ímpar, n!! = 3*5*7*...*n
		for(k = 1; k <= (n >> 1); k++)
			dfat *= (2*k + 1);
		return dfat;
	}
}
```

7. (a) Escreva uma função em C que calcula a função exponencial utilizando a série de Taylor da mesma. Considere o cálculo até o termo n = 20. O protótipo da função é `double ExpTaylor(double x);`

```C
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
```

(b) Escreva a sub-rotina equivalente na linguagem Assembly do MSP430, mas considere que os valores de entrada e de saída são inteiros de 16 bits. A variável de entrada é fornecida pelo registrador R15, e o valor de saída também.

8. Escreva uma sub-rotina na linguagem Assembly do MSP430 que indica se um vetor esta ordenado de forma decrescente. Por exemplo:
[5 4 3 2 1] e [90 23 20 10] estão ordenados de forma decrescente.
[1 2 3 4 5] e [1 2 3 2] não estão.
O primeiro endereço do vetor é fornecido pelo registrador R15, e o tamanho do vetor é fornecido pelo registrador R14. A saída deverá ser fornecida no registrador R15, valendo 1 quando o vetor estiver ordenado de forma decrescente, e valendo 0 em caso contrário.

9. Escreva uma sub-rotina na linguagem Assembly do MSP430 que calcula o produto escalar de dois vetores, `a` e `b`. O primeiro endereço do vetor `a` deverá ser passado através do registrador R15, o primeiro endereço do vetor `b` deverá ser passado através do registrador R14, e o tamanho do vetor deverá ser passado pelo registrador R13. A saída deverá ser fornecida no registrador R15.

10. (a) Escreva uma função em C que indica se um vetor é palíndromo. Por exemplo:
	[1 2 3 2 1] e [0 10 20 20 10 0] são palíndromos.
	[5 4 3 2 1] e [1 2 3 2] não são.
Se o vetor for palíndromo, retorne o valor 1. Caso contrário, retorne o valor 0. O protótipo da função é:

```C
int Palindromo(int vetor[ ], int tamanho);
```

```C
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
		if(vetor[i] != vetor[tamanho - i])
			return 0;
		i++;
	}
	return 1;
}
```

(b) Escreva a sub-rotina equivalente na linguagem Assembly do MSP430. O endereço do vetor de entrada é dado pelo registrador R15, o tamanho do vetor é dado pelo registrador R14, e o resultado é dado pelo registrador R15.

```
; O endereço do primeiro vetor é colocado em R15, e o tamanho em R14
; R13 = i, R12 = 2*i, R11 = &R15 + 2*i = &R15[i]
; R10 = &vector[tam - i] = &R15 + 2*tam -2*i = &R15 + 2*R14 -R12
Palindromo:
; Usaremos registradores que podem estar sendo usados por outras funções
push.w R11
push.w R10
; Limpar o R13, i = 0, decrementar R14, tam.
clr.w R13
dec.w R14

Palindromo_loop:
cmp.w R14, R13
jge Eh_Palindromo
; Multiplicar i por 2, pois o MSP só acessa os endereços pares, e guardar em R12
mov.w R13, R12
rla.w R12
; Inicializar R11
mov.w R15, R11
add.w R12, R11
; Inicializar R10
mov.w R15, R10
add.w R14, R10
add.w R14, R10
sub.w R12, R10
; Comparar as duas posições do vetor
cmp.w 0(R11), 0(R10)
jne Nao_Eh_Palindromo
inc.w R13
jmp Palindromo_loop

Eh_Palindromo:
mov.w #1, R15
pop.w R10
pop.w R11
ret

Nao_Eh_Palindromo:
mov.w #0, R15
pop.w R10
pop.w R11
ret
```