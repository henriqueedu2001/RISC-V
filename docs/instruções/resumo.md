# Resumo de Instruções

## Formatos de instrução
- Tipo R: sobre registradores
- Tipo I: immediates, short e loads
- Tipo S: stores
- Tipo B: desvios condicionais (branch)
- Tipo U: immediates longos
- Tipo J: saltos incondicionais

## Instruções Tipo R
Campos:
- **funct7** (7 bits)
- **rs2** (5 bits)
- **rs1** (5 bits)
- **funct3** (3 bits)
- **rd** (5 bits)
- **opcode** (7 bits)

## Instruções Tipo I
Campos:
- **imm**[11:0] (7 bits)
- **rs1** (5 bits)
- **funct3** (3 bits)
- **rd** (5 bits)
- **opcode** (7 bits)

## Instruções Tipo S
Campos:
- **imm**[11:5] (7 bits)
- **rs2** (5 bits)
- **rs1** (5 bits)
- **funct3** (3 bits)
- **imm**[4:0] (5 bits)
- **opcode** (7 bits)

## Instruções Tipo B
Campos:
- **imm**[12] (1 bit)
- **imm**[10:5] (6 bits)
- **rs2** (5 bits)
- **rs1** (5 bits)
- **funct3** (3 bits)
- **imm**[4:1] (4 bits)
- **imm**[11] (1 bit)
- **opcode** (7 bits)

## Instruções Tipo U
Campos:
- **imm**[31:12] (20 bits)
- **rd** (5 bits)
- **opcode** (7 bits)

## Instruções Tipo J
Campos:
- **imm**[20] (1 bit)
- **imm**[10:1] (10 bits)
- **imm**[11] (1 bit)
- **imm**[19:12] (8 bits)
- **rd** (5 bits)
- **opcode** (7 bits)
