# Testebenchs

## Instruções
Executar todos os comandos dentro da pasta /src/bin, para que os aquivos binários fiquem contidos lá, sem poluirem o espaço de outros diretórios.
```
cd bin
```

Dentro da pasta bin, compile os arquivos .v
```
iverilog -o <nome> <lista de módulos> <testbench>
```
Em seguida, basta usar o comando
```
vvp <nome>
```
E você verá o resultado do testbench.<br>

Como os comandos ficam muito longos para o terminal, escrevi todos aqui neste arquivo. Basta copiar e colar no terminal e teclar enter.

## CPU
```
iverilog -o cpu ../src/modules/processor/cpu.v ../src/modules/processor/register_file.v ../src/modules/utility/n_bits_register.v ../src/modules/utility/one_bit_register.v ../src/modules/processor/data_memory.v ../src/modules/processor/alu.v ../src/modules/utility/opposite.v ../src/modules/utility/full_adder.v ../src/modules/utility/half_adder.v ../src/modules/utility/mux_2x1.v ../src/modules/utility/general_mux.v ../src/modules/processor/control_unit.v ../src/modules/processor/instruction_memory.v ../src/modules/processor/program_couter.v ../src/testbenchs/tests/processor/cpu_test.v 

```
```
vvp rf
```

## REGISTER FILE
```
iverilog -o rf ../src/modules/processor/register_file.v ../src/modules/utility/n_bits_register.v  ../src/modules/utility/one_bit_register.v ../src/testbenchs/tests/processor/register_file_test.v
```
```
vvp rf
```

## DATA MEMORY
```
iverilog -o dm ../src/modules/processor/data_memory.v ../src/testbenchs/tests/processor/data_memory_test.v
```
```
vvp dm
```

## PROGRAM COUNTER
```
iverilog -o pc ../src/modules/processor/program_counter.v ../src/testbenchs/tests/processor/program_counter_test.v 
```
```
vvp pc
```

## INSTRUCTION MEMORY
```
iverilog -o im ../src/modules/processor/instruction_memory.v ../src/testbenchs/tests/processor/instruction_memory_test.v
```
```
vvp im
```

## CONTROL UNIT
```
iverilog -o cu ../src/modules/processor/control_unit.v ../src/testbenchs/tests/processor/control_unit_test.v 
```
```
vvp cu
```

## ALU
```
iverilog -o alu ../src/modules/processor/alu/alu.v ../src/modules/processor/alu/INT_AR.v ../src/modules/processor/alu/FLT_AR.v ../src/modules/processor/alu/BITWISE.v ../src/modules/processor/alu/BITSHIFT.v ../src/testbenchs/tests/processor/alu_test.v 
```
```
vvp alu
```

## FULL ADDER
```
iverilog -o full_adder ../src/modules/utility/full_adder.v ../src/modules/utility/half_adder.v ../src/testbenchs/tests/utility/full_adder_test.v 
```
```
vvp full_adder
```

## HALF ADDER
```
iverilog -o half_adder ../src/modules/utility/half_adder.v ../src/testbenchs/tests/utility/half_adder_test.v 
```
```
vvp half_adder
```

## OPPOSITE
```
iverilog -o opposite ../src/modules/utility/opposite.v ../src/modules/utility/full_adder.v ../src/modules/utility/half_adder.v ../src/testbenchs/tests/utility/opposite_test.v
```
```
vvp opposite
```

## GENERAL MUX
```
iverilog -o mux ../src/modules/utility/general_mux.v ../src/testbenchs/tests/utility/general_mux.v
```
```
vvp mux
```

## MUX 2x1
```
iverilog -o mux_2x1 ../src/modules/utility/mux_2x1.v ../src/testbenchs/tests/utility/mux_2x1.v
```
```
vvp mux_2x1
```

## MUX 4x1
```
iverilog -o mux_4x1 ../src/modules/utility/mux_4x1.v ../src/testbenchs/tests/utility/mux_4x1.v 
```
```
vvp mux_4x1
```

## ONE BIT REGISTER
```
iverilog -o one_bit_register ../src/modules/utility/one_bit_register.v ../src/testbenchs/tests/utility/one_bit_register_test.v 
```
```
vvp one_bit_register
```
## N BITS REGISTER
```
iverilog -o n_bits_register ../src/modules/utility/n_bits_register.v ../src/modules/utility/one_bit_register.v ../src/testbenchs/tests/utility/n_bits_register_test.v
```
```
vvp n_bits_register
```

## FLAGGER
```
iverilog -o flagger src/modules/processor/alu/flagger.v src/testbenchs/tests/processor/flagger_test.v
```
```
vvp flagger