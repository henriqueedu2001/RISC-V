# Instruções tipo R

## Formato
- **funct7** (7 bits): 
- **rs2** (5 bits): register source 1 (no register file)
- **rs1** (5 bits): register source 2 (no register file)
- **funct3** (3 bits): 
- **rd** (5 bits): register destination (no register file)
- **opcode** (7 bits): 0110011;

## Instruções
- **add**: adiciona dois números (+)
- **sub**: subtrai dois números
- **sll**: shift left logical (<<)
- **slt**: set less than (<)
- **sltu**: less than unsigned (<)
- **xor**: faz o xor bit a bit dos números
- **srl**: shift right logical (>>)
- **sra**: shift right arithmetic (>>)
- **or**: faz o or bit a bit dos números
- **and**: faz o and bit a bit dos números

## Instrução add
Toma dois endereços do rf, **rs1** e **rs2**, adiciona os números e escreve em **rd** do rf. Seu formato geral é:<br>
r_type_instruction_add = {7'b0000000, rs2, rs1, 3'b000, rd, 7'b0110011}
<br>
Por exemplo, a instrução
```
add x2, x5, x12
```

se traduz como x2 <-- x5 + x12, com os campos:
- **funct7** = 7'b0000000
- **rs2** = 5'b01100
- **rs1** = 5'b00101
- **funct3** = 3'b000
- **rd** = 5'b00010
- **opcode** = 7'b0110011
Logo, temos:
```
32'b0000000_01100_00101_000_00010_0110011
```

## Instrução sub
Toma dois endereços do rf, **rs1** e **rs2**, adiciona os números e escreve em **rd** do rf. Seu formato geral é:<br>
r_type_instruction_add = {7'b0100000, rs2, rs1, 3'b000, rd, 7'b0110011}
<br>
Por exemplo, a instrução
```
sub x7, x1, x13
```

se traduz como x7 <-- x1 - x13, com os campos:
- **funct7** = 7'b0100000
- **rs2** = 5'b01101
- **rs1** = 5'b00001
- **funct3** = 3'b000
- **rd** = 5'b00010
- **opcode** = 7'b0110011
Logo, temos:
```
32'b0100000_01101_00001_000_00010_0110011
```