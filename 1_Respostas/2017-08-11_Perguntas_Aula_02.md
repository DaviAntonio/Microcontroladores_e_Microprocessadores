# Perguntas Aula 02
## Data: 11/08/2017
1. Quais as diferenças entre os barramentos de dados e de endereços?
O barramento de dados é o barramento pelo qual são transferidas as sequências de bits referentes aos dados lidos ou que serão gravados, enquanto pelo barramneto de endereços são transferidos os bits referidos ao endereço no qual serão lidos ou escritos tais dados.

2. Quais são as diferenças entre as memórias RAM e ROM?
A memória RAM possui volatilidade, os conteúdos armazenados são perdidos quando não há alimentação. Já a memória ROM armazena os dados de maneira não volátil, estes não são perdidos na falta de energia.

3. Considere o código abaixo:

```C
#include <stdio.h>
int main(void)
{
	int i;
	printf("Insira um número inteiro: ");
	scanf("%d", &i);
	if(i%2)
		printf("%d eh impar.\n");
	else
		printf("%d eh par.\n");
	return 0;
}
```

Para este código, responda: (a) A variável `i` é armazenada na memória RAM ou ROM? Por quê? (b) O programa compilado a partir deste código é armazenado na memória RAM ou ROM? Por quê?
(a) A variável i será armazenada na memória RAM, pois faz parte da execução do programa e terá seu valor alterado, não sendo necessário armazena-la após o término programa.
(b) O programa compilado será armazenado na ROM, pois há a necessidade de mantê-lo após o desligameno do computador.

4. Quais são as diferenças, vantagens e desvantagens das arquiteturas Harvard e Von Neumann?
Na arquitetura de Harvard a memória de programa, ROM, é separada da memória de dados, RAM, sendo que as duas possuem barramentos diferentes para endereço e dados, sendo ambos conjuntos de barramentos otimizados separadamente. Já a arquitetura von Neumann possui a RAM e a ROM em um único espaço de memória acessado por um único conjunto de barramentos de dados e endereço.

5. Considere a variável inteira `i`, armazenando o valor `0x8051ABCD`. Se `i` é armazenada na memória a partir do endereço `0x0200`, como ficam este byte e os seguintes, considerando que a memória é: (a) Little-endian; (b) Big-endian.
Considerando o MSP430, no qual a memória é separada em bytes e guarda palavra de 2 bytes (16 bits):
(a) Seria gravado `0xCD` no endereço `0x0200`, `0xAB` no `0x0201`, `0x51` no `0x0202`, `0x80` no `0x0203`, em little-endian.
(b) caso o microprocessador trabalhasse em big-endian, Seria gravado `0x80` no endereço `0x0200`, `0x51` no `0x0201`, `0xAB` no `0x0202`, `0xCD` no `0x0203`.

6. Sabendo que o processador do MSP430 tem registradores de 16 bits, como ele soma duas variáveis de 32 bits?
A soma de duas variáveis de 32 bits teria de ser feita com o auxílio de registradores auxiliares.
As variáveis de 32 bits ocupariam dois registradores de propósito geral, por exemplo, *R4* (LSB) e *R5* (MSB) para a primeira, e *R6* (LSB) e *R7* (MSB) para a segunda.
A soma seria feita primeiramente somando-se os registradores reponsáveis pelos dígitos menos significativos das duas variáveis, no exemplo, *R4* e *R6*. Em seguida, seria analisada a flag responsável pelo carry da operação, a qual está localizada no registrador *R2*.
Caso houver carry na soma dos registradores responsáveis pelos LSBs, será adicionado 1 a soma dos bits mais significativos das variáveis, nesse caso, o registradores *R5* e *R7*. O resultado da adição estará em dois registradores, responsáveis por guardar os bits mais e menos significativos do resultado.
Caso ainda ocorra o aparecimento de um carry, terá ocorrido um _overflow_ aritmético, e o resultado da adição estará incorreto.
