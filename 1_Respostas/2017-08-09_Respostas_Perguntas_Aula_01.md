# Respostas às Perguntas Aula 01
## Data: 09/08/2017
1. O que são sistemas embarcados?

Sistemas embarcados são sistemas computacionais compostos de hardware e software que atuam em conjunto para cumprir um propósito específico, sejam por si mesmos, seja dentro de outros sistemas. Comparados a um sistema de propósito geral consomem menos energia, possuem tamanho reduzido e acesso direto a pinos de entrada e saída.

2. O que são sistemas microprocessados?

Sistemas microprocessados são sistemas embarcados implementados através de microprocessadores.

3. Apresente aplicações de sistemas embarcados:

- a) Para a indústria automotiva
controle da entrada de combustível no motor dependendo da posição do acelerador.
- b) Para eletrodomésticos
controlar a velocidade da agitação de um tambor de uma máquina de lavar dependendo da quantidade de roupas e água.
- c) Para automação industrial
registrar o consumo de energia ao longo do dia.

4. Cite arquiteturas possíveis e as diferenças entre elas.

Sistemas embarcados podem ser implementados em:
- computadores de propósito geral são fáceis de obter, facilidade para escrita do código, mas possuem alto gasto de energiae têm problemas com a temporização;
- circuitos integrados para aplicações específicas, ASICs, são rápidos mas a produção e desenvolvimento são caros, e só compensam se a demanda é muito alta;
- FPGAs, caracterizadas pela possibilidade de implementar algoritmos de forma paralela, usualmente programadas através de linguagens de descrição de hardware;
- microcontroladores, programéveis usualmente em C, sendo possível o uso da linguagem assembly apropriada, consomem pouca energia e acessam facilmente pinos de entrada e saída;

5. Por que usamos o MSP430 na disciplina, ao invés de outro microcontrolador?

O MSP430 possui modos de baixo consumo, é mais barato e é mais utilizado na indústria, sendo possível programá-lo em assembly e em C através de ferramentas livres.
