/*  

 3. Diseñar un programa ensamblador que muestre en la placa DE2 un cero
 	 en el primer display "siete-segmentos" y lo rote por los cuatro 
 	 primeros displays "siete-segmentos".  

*/

		.global _start

_start:
			movia r1, 0x10000020 		// guarda en r1 la direccion de 7-segmentos
			movia r2, 0x3F	     		//cero en el siete-segmentos
			movia r3, 0x500000   		//guarda 500000 en r3 (inicializar cuenta para el retardo temporal)

loop:
				subi r3, r3, 1			// decrementa 1 a 500000
				bne r3, r0, loop		//salta a loop si r3 != r0 ; 500000 != 0 (bucle de retardo temporal)
				stwio r2, 0(r1)			//guarda en la direccion 0x3F   0+r1 = 0x10000020
				roli r2, r2, 1 			//ruedo al siguiente cuadro del siete-segmentos
				movia r3, 0x500000		//guarda 500000 en r3 (retardo temporal)
				br loop					// salta a loop