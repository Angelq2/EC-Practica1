/*  

 4. Diseñar un programa ensamblador que encienda en la placa DE2 los leds rojos
    correspondientes a los interruptores que no estén activados. 

*/

		.global _start

_start:
			movia r1, 0x10000000 	//inicializar los leds rojos (guarda en r1 la direccion de los leds rojos)
			movia r2, 0x10000040 	//guarda en r2 la dir de los interruptores
	
loop:
			ldwio r3, 0(r2) 	//Carga en r3 lo q hay en r2+0=r2
			nor r3, r3, r0  	//pongo un uno en el registro si hay un cero r3 NOR r0
			stwio r3, 0(r1)		//Guarda el contenido de r3 en el led rojo
			br loop				//salta a loop