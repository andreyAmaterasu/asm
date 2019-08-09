masm
model small
.stack 256
.data
Na	db	15
Nb	db	70
Nc	db	25
Nd	db	35
Ny	db	?
ost	db	?
.code
main:	mov	ax, @data
		mov	ds,	ax
		mov	al, Nb
		cbw
		mov	bl, Nd
		mul	bl
		
		.386		
		movzx	bx, Na
		add	ax, bx

		mov	bl, Nc
		add	bl, 5
		
		div	bl
		mov	Ny, al
		mov	ost, ah
		mov ax, 4c00h
		int 21h
		end main