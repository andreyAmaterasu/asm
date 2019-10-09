masm
model small
stack 256
.data
widthCL	db	0
widthDL	db	4
.code
main:	mov	ax, @data
		mov ds, ax
		
		xor bl, bl
		mov cx, 16
m0:		mov ah, 6
		mov al, 0
		mov bh, bl
		shl	bh, 4
		push cx
		mov ch, 0
		mov cl, widthCL	
		mov dh, 24
		mov dl, widthDL	
		int 10h
		pop cx
		add widthCL, 5
		add widthDL, 5
		inc bl
		mov ah, 7
		int 21h
		loop m0
		
		mov ax, 4c00h
		int	21h
		end main