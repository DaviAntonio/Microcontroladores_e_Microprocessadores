# Respostas às Perguntas Aula 04 Extra
## Data: 25/08/2017
Para todas as questões, considere que as variáveis `f`, `g`, `h`, `i` e `j` são do tipo inteiro (16 bits na arquitetura do MSP430), e que o vetor `A[]` é do tipo inteiro. Estas variáveis estão armazenadas nos seguintes registradores:

- f: R4
- g: R5
- h: R6
- i: R7
- j: R8
- A: R9

Utilize os registradores R11, R12, R13, R14 e R15 para armazenar valores temporários.

1. Traduza as seguintes linhas em C para a linguagem assembly do MSP430. Utilize somente as seguintes instruções: mov.w, add.w, sub.w, clr.w, dec.w, decd.w, inc.w e incd.w.

(a) `f *= 5;`

```
mov.w R4, R11
add.w R11, R4	; R4 += R4 = R4*2
add.w R11, R4	; R4 = (R4 + R4) + R4 = R4*3
add.w R11, R4
add.w R11, R4
```

(b) `g *= 6;`

```
mov.w R5, R11
add.w R11, R5
add.w R11, R5
add.w R11, R5
add.w R11, R5
add.w R11, R5
```

(d) `A[2] = 6*A[1] + 5*A[0];`

```
; Ler A[1] da memória, andar 2 bytes do endereço guardado em R9
mov.w 2(R9), R11

; Ler A[0] da memória, endereço guardado em R9
mov.w 0(R9), R12

; 6*A[1] = 6*R11
mov.w R11, R13
add.w R11, R13	; R13 = 2*R11
add.w R11, R13	; R13 = 2*R11 + R11 = 3*R11
add.w R11, R13
add.w R11, R13
add.w R11, R13	; R13 = 6*R11 = 6*A[1]

; 5*A[0] = 5*R12
mov.w R12, R14
add.w R12, R14	; R14 = 2*R12
add.w R12, R14
add.w R12, R14
add.w R12, R14	; R14 = 5*R12 = 5*A[0]

; 6*A[1] + 5*A[0] = R13 + R14
add.w R13, R14	; R14 = R14 + R13

; Guardar na memória, endereço em R9 + 4 bytes a frente
mov.w R14, 4(R9)
```

(e) `A[3] = 3*f - 5*h;`

```
; Multiplica 3*R4
mov.w R4, R11
add.w R4, R11	; R11 = 2*R4
add.w R4, R11	; R11 = 2*R4 + R4 = 3*R4

; Multiplica 5*R6
mov.w R6, R12
add.w R6, R12	; R12 = 2*R6
add.w R6, R12	; R12 = 3*R6
add.w R6, R12
add.w R6, R12

; Subtrai 3*R4 - 5*R6
sub.w R4, R6	; R6 = R6 - R4

; Guardar em 6 bytes a frente de endereço em R9
mov.w R6, 6(R9)
```

(f) `A[5] = 6*(f - 2*h);`

```
; Multiplica 2*R6
add.w R6, R6

; Subtrai R4 - R6 = R4 - (2*R6)
sub.w R6, R4

; Colocar 10 bytes a frente do endereço em R9
mov.w R4, 10(R9)
```
