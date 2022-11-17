El presente documento explica el funcionamiento del proyecto III del curso de Diseño Lógico. En este proyecto, se busca construir un circuito multiplicador implementado en una FPGA, utilizando el algoritmo de Booth.
El algoritmo de Booth es un algoritmo de tipo iterativo que permite calcular la multiplicación de dos números binarios de ancho N representados en complemento a dos. Se caracteriza por
basar un funcionamiento en el desplazamiento entre bits adyacentes del multiplicador y el multiplicando.

### Descripción general del funcionamiento del circuito completo:
El circuito multiplicador de Booth se divide en cuatro subsistemas que se encargan de realizar el proceso de multiplicación. Las entradas del circuito general son las siguientes:

1. reloj: señal de reloj proveniente de la FPGA. Opera a una frecuencia de 50MHz.
2. reinicio: señal de reinicio de la lógica secuencial. Asociado al botón KEY[0] de la FPGA.
3. operandoA: operando de cuatro bits que actúa como multiplicando. Sus cuatro bits están asociados a los switches SW[9], SW[8], SW[7] y SW[6].
4. operandoB: operando de cuatro bits que actúa como multiplicador. Sus cuatro bits están asociados a los switches SW[5], SW[4], SW[3] y SW[2].
5. iniciarMultiplicacion: señal que da inicio al cálculo de la multiplicación. Asociado al botón KEY[3] de la FPGA.

Por su parte, las salidas del circuito general son las siguientes:

1. ledOperandoA: señal que indica que se ha leído correctamente el operandoA proveniente de los switches. Asociado al led LEDR[9] de la FPGA.
2. ledOperandoB: señal que indica que se ha leído correctamente el operandoB proveniente de los switches. Asociado al led LEDR[5] de la FPGA.
3. sieteSegmentosA: señal de siete bits que representa el dígito de las centenas del resultado de la multiplicación. Asociado al display de siete segmentos HEX[2] de la FPGA.
4. sieteSegmentosB: señal de siete bits que representa el dígito de las decenas del resultado de la multiplicación. Asociado al display de siete segmentos HEX[1] de la FPGA.
5. sieteSegmentosC: señal de siete bits que representa el dígito de las unidades del resultado de la multiplicación. Asociado al display de siete segmentos HEX[0] de la FPGA.

Este circuito lee los dos operandos de entrada de los ocho switches (SW[9], SW[8], SW[7], SW[6], SW[5], SW[4], SW[3] y SW[2]) y espera a que se presione el botón asociado a la señal
de iniciarMultiplicacion. Una vez que este botón es presionado, da comienzo al cálculo de la multiplicación utilizando el algoritmo de Booth. Cuando el resultado ha sido 
obtenido, se convierte de formato binario "tradicional" (ocho bits), a formato binario en representación BCD (doce bits, cuatro bits por cada dígito del resultado), con la finalidad
de ser representado en los tres display de siete segmentos (HEX[2], HEX[1] y HEX[0]).

### Descripción del funcionamiento de cada subsistema:
Con el objetivo de facilitar el diseño, el testeo y la implementación del circuito multiplicador, se dividió el trabajo en cuatro subsistemas principales, cada uno encargado de una tarea
específica y diferenciada. Estos cuatro subsistemas son los siguientes:

1. Subsistema de lectura: responsable de leer la entrada de los dos operandos de los ocho switches (SW[9], SW[8], SW[7], SW[6], SW[5], SW[4], SW[3] y SW[2]), y de esperar a que el usuario
presione el botón asociado a la señal de iniciarMultiplicacion. Cuando este botón es presionado, "deja pasar" los operandos de entrada al siguiente subsistema.
2. Subsistema de cálculo: responsable de calcular el resultado de la multiplicación como tal. Recibe los dos operandos (operandoA y operandoB) y los multiplica utilizando el algoritmo iterativo
de Booth. Una vez que ha terminado, levanta una bandera que le hace saber al siguiente subsistema que el cálculo está listo.
3. Subsistema de conversión: responsable de tomar el resultado binario del subsistema de cálculo y transformarlo a formato BCD, para su posterior representación en los display de siete segmentos.
Levanta una bandera que le hace saber al siguiente subsistema que la conversión está lista. Utiliza el algoritmo de doble incursión.
4. Subsistema de display: responsable de tomar el resultado en BCD del sistema de conversión, codificarlo, y mostrarlo en los tres display de siete segmentos. Está a la espera
de la bandera del subsistema de conversión, para comenzar con el codificado y posterior impresión en pantalla del resultado.

### Diagrama de bloques de cada subsistema y su funcionamiento fundamental:
En el siguiente diagrama de bloques se puede apreciar la totalidad del circuito, y la forma en la que interconectan todas las señales asociadas a la entrada, el cálculo, la conversión y la salida de los datos. Tal como se mencionaba en el apartado anterior, el sistema se compone de cuatro módulos independientes que comparten
una misma señal de reloj y de reinicio, pero que están conectados de forma tal que integran la resolución completa del enunciado.
![Diagrama de bloques](https://github.com/anaelenaBC/EL3307ProyectoIII/blob/main/diagrama.png)

### Ejemplo y análisis de una simulación funcional del sistema completo:
Considere el siguiente ejemplo. Se tienen los siguientes operandos de entrada:
1. operandoA: número decimal 4 (representación binaria 0100).
2. operandoB: número decimal 6 (representación binaria 0110).

El subsistema de lectura obtiene estos operandos a partir de los switches de la FPGA, que deben estar en las posiciones abajo, arriba, abajo, abajo, abajo, arriba, arriba y abajo; esto si se toman a partir del SW[9] hasta el SW[2]. El cálculo de la multiplicación no da inicio hasta que se presione el botón de iniciarMultiplicacion (KEY[3] en la FPGA).

![Código del subsistema de lectura](https://github.com/anaelenaBC/EL3307ProyectoIII/blob/main/codigo1.png)

Cuando se presiona este botón, se envía una señal en forma de bandera al subsistema de cálculo que, empleando el algoritmo de Booth, empieza a determinar el resultado
de manera iterativa, almacenandolo en una señal de salida de ocho bits llamada resultadoBinario. El resultado binario esperado es el número decimal 24 (representación binaria 0001 1000).

Este resultado binario es posteriormente convertido a formato BCD en el subsistema de conversión. El resultado convertido se almacena en una señal de salida de doce bits llamada resultadoBCD. El resultado en formato BCD esperado es 0000 (dígito de las centenas en cero) 0010 (dígito de las decenas en dos decimal) 0100 (dígito de las unidades en cuatro decimal).

