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

## REGISTER FILE
```
iverilog -o register_file ../src/modules/processor/register_file.v ../src/modules/utility/n_bits_register.v  ../src/modules/utility/one_bit_register.v 
```
```
vvp register_file
```

## ALU
```
iverilog -o alu ../src/modules/processor/alu.v ../src/modules/utility/full_adder.v ../src/modules/utility/half_adder.v ../src/testbenchs/tests/processor/alu_test.v
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