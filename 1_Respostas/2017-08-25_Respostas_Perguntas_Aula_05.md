#
#
Para as questões 2 a 5, considere que as variáveis `f`, `g`, `h`, `i` e `j` são do tipo inteiro (16 bits na arquitetura do MSP430), e que o vetor `A[]` é do tipo inteiro. Estas variáveis estão armazenadas nos seguintes registradores:
	f: R4
	g: R5
	h: R6
	i: R7
	j: R8
	A: R9
Utilize os registradores R11, R12, R13, R14 e R15 para armazenar valores temporários.

1. Escreva os trechos de código assembly do MSP430 para:
	(a) Somente setar o bit menos significativo de R5.
	
```
bis.w #00001, R5
```

	(b) Somente setar dois bits de R6: o menos significativo e o segundo menos significativo.
	
```
bis.w #00003, R6
```

	(c) Somente zerar o terceiro bit menos significativo de R7.

```
bic.w #00004, R7
```

	(d) Somente zerar o terceiro e o quarto bits menos significativo de R8.

```
bic.w #0000C, R8
```

	(e) Somente inverter o bit mais significativo de R9.

```
xor.w #08000, R9
```

	(f) Inverter o nibble mais significativo de R10, e setar o nibble menos significativo de R10.

```
xor.w #0F000, R10
bis.w #0000F, R10
```

2. "Traduza" o seguinte trecho de código em C para o assembly do MSP430:

```C
if(i>j) f = g+h+10;
else f = g-h-10;
```

```
if:
cmp R7, R8
jl else	; Pular se R8 < R7, j < i
; f = g + h, R4 = R5 + R6
add.w R5, R6
mov.w R6, R4
; f = f +10, R4 = R4 + #10
add.w #10, R4
jmp if_end

else:
; f = g - h, R4 = R5 - R6
sub.w R6, R5
mov.w R6, R4
; f = f -10, R4 = R4 - #10
sub.w #10, R4

if_end:
```

3. "Traduza" o seguinte trecho de código em C para o assembly do MSP430:

```C
while(save[i]!=k) i++;
```

```
; i = R7, k = R11, save = R13
whileloop:
mov.w R7, R12	; R12 = 2 para somar e andar endereço
rla R12		; R12 = 2*R7 = 2*i
add.w R13, R12	; R12 = R13 + R12 = R13 + 2*R7 = &save[i]
cmp 0(R12), R11
jne whileend
inc.w R7	; i++
jmp whileloop

whileend:

```

4. "Traduza" o seguinte trecho de código em C para o assembly do MSP430:

```C
for(i=0; i<100; i++) A[i] = i*2;
```

```
; Começar laço for, i = R7, A = R9
mov.w #100, R11	; Colocar constante 100 no R11
mov.w #0, R7	; Zerar R7

forloop:
mov.w R7, R12	; R12 = R7 (temp)
rla R12		; R12 = 2*i
mov.w R12, R13	; R13 = R12 = 2*i
add.w R9, R12	; R12 = R12 + R9 = 2*i + &A[0] = &A[i]
cmp R7, R11
jge endforloop
mov.w R13, 0(R12)
inc.w R7
jmp forloop


endforloop:
```

5. "Traduza" o seguinte trecho de código em C para o assembly do MSP430:

```C
for(i=99; i>=0; i--) A[i] = i*2;
```

```
; Começar laço for, i = R7, A = R9
mov.w #99, R7	; Colocar constante 100 no R11

forloop:
mov.w R7, R12	; R12 = R7 (temp)
rla R12		; R12 = 2*i
mov.w R12, R13	; R13 = R12 = 2*i
add.w R9, R12	; R12 = R12 + R9 = 2*i + &A[0] = &A[i]
cmp R7, #0
jl endforloop
mov.w R13, 0(R12)
dec.w R7
jmp forloop


endforloop:
```
