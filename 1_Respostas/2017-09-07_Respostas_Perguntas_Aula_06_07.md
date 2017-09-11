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
	unsigned int x0, x1, eps, i = 0;

    // Chute inicial
	x0 = S >> 1;

	do{
		x1 = (x0 + (S/x0)) >> 1;
		eps = x0 - x1;
		x0 = x1;
		i++;
	}while(eps > 0);

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
; Incompleto
; R15 = x, R14 = N

Potencia:
; Colocar 1 em R13
mov.w #1, R13

Potencia_loop:
tst.w R14
jz Potencia_retorno
???????????????????Multiplica
dec.w R14
jmp Potencia_loop

Potencia_retorno:
mov.w R13, R15
ret
```

3. Escreva uma sub-rotina na linguagem Assembly do MSP430 que calcula a divisão de `a` por `b`, onde `a`, `b` e o valor de saída são inteiros de 16 bits. `a` e `b` são fornecidos através dos registradores R15 e R14, respectivamente, e a saída deverá ser fornecida através do registrador R15.

4. Escreva uma sub-rotina na linguagem Assembly do MSP430 que calcula o resto da divisão de `a` por `b`, onde `a`, `b` e o valor de saída são inteiros de 16 bits. `a` e `b` são fornecidos através dos registradores R15 e R14, respectivamente, e a saída deverá ser fornecida através do registrador R15.

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
; Não testado

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
; R13 = 2, agora R13 = i
mov.w #2, R13

Primalidade_loop:
cmp.w R13, R14
jeq Primalidade_primo
?????????????????????????????????????????????????????????????
jz Primalidade_nao_primo
inc.w R13
jmp Primalidade_loop


Primalidade_primo:
mov.w #1, R15
ret

Primalidade_nao_primo:
mov.w #0, R15
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

(b) Escreva a sub-rotina equivalente na linguagem Assembly do MSP430. O endereço do vetor de entrada é dado pelo registrador R15, o tamanho do vetor é dado pelo registrador R14, e o resultado é dado pelo registrador R15.