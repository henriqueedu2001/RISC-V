# ALU
A Arithmetic-Logic Unit (ALU) é responsável por realizar um conjunto de operações lógicas e aritméticas básicas, sobre números inteiros e pontos flutuantes. As entradas e a saída são palavras de 64 bits.

Nessa implementação, dividimo-la em cinco blocos:
- **INT_AR**: executa operações aritméricas sobre inteiros
- **FLT_AR**: executa operações aritméticas sobre pontos flutuantes
- **BITWISE**: executa operações lógicas bit a bit
- **BITSHIFT**: executa operações de deslocamento de bits
- **FLAGGER**: informas flags para uso no program counter e para a control unit

## Codificação das Operações
Para as operações pretendidas, julgamos suficiente o uso de 6 bits. Dois para identificação da unidade que se pretente usar (INT_AR, FLOAT_AR, BITWISE ou BITSHIFT) e quatro para especificação da instrução. Os dois bits mais significativos indicam o bloco:
- **INT_AR**: 00xxxx
- **FLT_AR**: 01xxxx
- **BITWISE**: 10xxxx
- **BITSHIFT**: 11xxxx
Os demais, indicam instrução dentro do bloco

## INT_AR
A unidade de operações aritméticas sobre inteiros realiza, para entradas input_a e input_b, as seguintes operações:

1. **add**: soma dos dois números inteiros
    - operation = 000000
    - result = input_a + input_b
2. **sub**: subtrai dois números inteiros
    - operation = 000001
    - result = input_a - input_b 
3. **neg**: retorna o oposto do primeiro valor
    - operation = 000010
    - result = input_a - input_b 
4. **inc**: incrementa o primeiro valor em uma unidade
    - operation = 000011
    - result = input_a + 1
5. **dec**: decrementa o primeiro valor em uma unidade
    - operation = 000100
    - result = input_a - 1

Todas as operações são realizadas em complemento de dois

## FLT_AR
A unidade de operações aritméticas sobre pontos flutuantes realiza, para entradas input_a e input_b, as seguintes operações:
1. **add**: soma dos dois floats
    - operation = 010000
    - result = input_a + input_b
2. **sub**: subtrai dois floats
    - operation = 010001
    - result = input_a - input_b 
3. **neg**: retorna o oposto do float
    - operation = 010010
    - result = input_a - input_b

## BITWISE
A unidade lógica realiza as seguintes operações:
1. **and**: "e" lógico bit a bit das duas entradas
    - operation = 100000
    - result = input_a & input_b
2. **or**: "ou" lógico bit a bit das duas entradas
    - operation = 100001
    - result = input_a | input_b
3. **not**: "negação" lógica bit a bit da primeira entrada
    - operation = 100010
    - result = ~input_a
4. **xor**: "ou exclusivo" bit a bit das duas entradas
    - operation = 100011
    - result = input_a ^ input_b

## BITSHIFT
Unidade de deslocamento de bits realiza as seguintes operações:
1. **arithmetic right shift**: deslocamento aritmético à direita
    - operation = 110000
    - result = input_a - input_b
2. **arithmetic left shift**: deslocamento aritmético à esquerda
    - operation = 110001
    - result = input_a - input_b
3. **logic right shift**: deslocamento lógico à direita
    - operation = 110010
    - result = input_a - input_b
4. **logic left shift**: deslocamento lógico à esquerda
    - operation = 110011
    - result = input_a - input_b

## FLAGGER
A unidade flagger produz sinais que são utilizados tanto pela unidade de controle, a exemplo do overflow, quanto para o program counter, no sistema de branches. Os sinais de saída são:
1. **equal**: informa se input_a = input_b
    - value = (input_a == input_b)
2. **not equal**: informa se input_a = input_b
    - value = (input_a != input_b)
3. **greater**: informa se input_a = input_b
    - value = (input_a > input_b)
4. **less**: informa se input_a = input_b
    - value = (input_a < input_b)
5. **unsigned equal**: informa se input_a = input_b
    - value = abs(input_a) == abs(input_b)
6. **unsigned greater**: informa se input_a = input_b
    - value = abs(input_a) > abs(input_b)
7. **unsigned less**: informa se input_a = input_b
    - value = abs(input_a) <> abs(input_b)
