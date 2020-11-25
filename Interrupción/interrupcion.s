
		.global _start

_start:
		movia sp,0x007FFFFC
		movia r2,0x10000050

		movi r3,0b1110
		stwio r3,8(r2)
		movi r2,0b010

		wrctl ienable,r2
		movi r2,1

		wrctl status,r2
		movia r2,0x10000020

		addi r6,r0,0x3F

		stwio r6,0(r2)


IDLE:
		br IDLE

		.section .reset,"ax"
		movia r2, _start
		jmp r2

.section .exceptions, "ax"
.global EXCEPTION_HANDLER
EXCEPTION_HANDLER:
					subi sp, sp, 4
					stw et, 0(sp)
					rdctl et, ctl4

					beq et, r0, NO_EXT
					subi ea, ea, 4
					subi sp, sp, 12
					stw ea, 0(sp)
					stw ra, 4(sp)
					stw r2, 8(sp)

					andi r2, et, 0b10
					beq r2, r0, FIN
					call BOTON
FIN:	
					ldw ea, 0(sp)
					ldw ra, 4(sp)
					ldw r2, 8(sp)
					addi sp, sp, 12

NO_EXT:				ldw et, 0(sp)
					addi sp, sp, 4
					eret

.global BOTON 
BOTON: 				subi sp, sp, 24	
					stw ra, 0(sp)
					stw r3, 4(sp)
					stw r4, 8(sp)
					stw r5, 12(sp)
					stw r6, 16(sp)
					stw r2, 20(sp)
					movia r2, 0x10000020
					movia r3, 0x10000050

					ldwio r4, 0xC(r3)
					
					stwio r0, 0xC(r3)

					addi r5, r0, 2
					beq r4, r5, BOTON_1

					slli r5, r5, 1
					beq r4, r5, BOTON_2

					slli r5, r5, 1
					beq r4, r5, BOTON_3

					br MOSTRAR

BOTON_1:			addi r6, r0, 0x6
					br MOSTRAR

BOTON_2:			addi r6, r0, 0x5B
					br MOSTRAR

BOTON_3:			addi r6, r0, 0x4F

MOSTRAR:			stwio r6, 0(r2)
					
					stw ra, 0(sp)
					stw r3, 4(sp)
					stw r4, 8(sp)
					stw r5, 12(sp)
					stw r6, 16(sp)
					stw r2, 20(sp)
					addi sp, sp, 24
					ret
	.end

