# Processador RISC-V
Esta é uma implementação de um processador, baseado no conjunto de instruções do RISC-V (RV64I: ISA RISC-V), com uma arquitetura de 64 bits.

**Autor**<br>
Henrique Eduardo @henriqueedu2001

## Como rodar este projeto?
Em primeiro lugar, clone o repositório para seu repositório local:
```
git clone https://github.com/henriqueedu2001/RISC-V
```

Depois, abra o diretório
```
cd RISC-V
```

## Testebenchs
Para executar os testbenchs, utilize os comandos disponibilizados no arquivo:
```
RISC-V/src/testbenchs_commands.txt
```
Os resultados dos testbenchs estão na pasta 
```
RISC-V/testbenchs/logs
```

## Requisitos Funcionais
O processador deve ser capaz de realizar:
- operações de tranferência de dados entre os registradores e a memória
- operações aritméticas sobre inteiros
- operações lógicas sobre palavras de 64 bits
- operações aritméticas com ponto flutuante