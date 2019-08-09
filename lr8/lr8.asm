masm
model small
.stack	256
.data
Ny	db	?
tabl db '0123456789ABCDEF'
rez	db	'**h$'
newstr	db	10, 13, '$'	
.code
start:	mov	ax, @data
		mov	ds, ax
		mov ax, 40h
		mov es, ax
		mov dx, es:[8]
		inc dx
		in al, dx
		mov Ny, al
		
		push ax
		shr al, 4
		lea bx, tabl
		xlat
		mov rez, al
		pop ax
		and al, 0fh
		xlat
		mov rez + 1, al
		mov ah, 9
		lea dx, rez
		int 21h
		
		lea dx, newstr
		mov ah, 9
		int 21h
		
		xor ax, ax
		xor bx, bx
		mov al, Ny
		
		mov cx, 8
		mov ah, 2
		mov bl, al
m1: 	rol bl, 1
		mov dl, 0
		adc dl, '0'
		int 21h
loop m1
		mov ah, 7
		int 21h
		
		mov ax, 4c00h
		int 21h
		end start