masm
model small
.stack
.data
sl1		dd	8125b425h, 0b25233f6h
sl2		dd	25955299h, 0f8f82531h
oldb	db	0
rez		dd	2 dup(0)
.code
main: 	mov	ax, @data
		mov	ds, ax
.386
		mov eax, sl1
		add	eax, sl2
		mov	rez, eax
		mov eax, sl1 + 4
		adc	eax, sl2 + 4
		mov rez + 4, eax
		adc oldb, 0
		
		mov	ax, word ptr sl1
		sub ax, word ptr sl2
		mov word ptr rez, ax
		mov ax, word ptr sl1 + 2
		sbb	ax, word ptr sl2 + 2
		mov word ptr rez + 2, ax
		mov ax, word ptr sl1 + 4
		sbb ax, word ptr sl2 + 4
		mov word ptr rez + 4, ax
		mov ax, word ptr sl1 + 6
		sbb ax, word ptr sl2 + 6
		mov word ptr rez + 6, ax
		
		mov ax, 4c00h
		int 21h
		end main