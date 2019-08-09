masm
model small
.stack 256
.data
mes	db	"Kostromin", 10, 13, "Andrey", 10, 13, "Aleksandrovich$"
nA	dd	8979
nB	db	120
nC	dd	101025
nD	dd	-558725
.code
main:	mov ax, @data
		mov ds, ax
		lea dx, mes
		mov ah, 9
		int 21h
		mov	ah, 7
		int 21h
		mov ax, 4c00h
		int 21h
		end main