newtab macro
	mov ah, 2
	mov dl, 10
	int 21h
	mov dl, 13
	int 21h
	endm
	
six macro rez, tab
	add sum, ax
	push ax
	shr al, 4
	lea bx, tab
	xlat
	mov rez, al
	pop ax
	and al, 0fh
	xlat
	mov rez + 1, al
	mov ah, 9
	lea dx, rez
	int 21h
	endm
	
sixout macro rez, tab
	push ax
	shr al, 4
	lea bx, tab
	xlat
	mov rezTwo, al
	pop ax
	and al, 0fh
	xlat
	mov rezTwo + 1, al
	mov ah, 9
	lea dx, rezTwo
	int 21h
	endm
	
masm
model small
.stack	256
.data
arr db 119, -38, 0, 17, -17, 28, 11, 0, 32, -101
len = $-arr
rez	db	'** $'
rezTwo db 	'**$'
tab db '0123456789ABCDEF'
sum dw 0
.code
start:	mov	ax, @data
		mov	ds, ax
		
		xor si, si
		mov cx, len
m1:		cmp arr[si], 0
		jle m2
		mov al, arr[si]
		mov ah, 0
		test al, 1
		jz m2
		six rez, tab
		
m2:		inc si
		loop m1
		
		newtab
		mov al, byte ptr sum + 1
		sixout rezTwo, tab
		mov al, byte ptr sum
		sixout rezTwo, tab
		
		
		mov ah, 7
		int 21h
		mov ax, 4c00h
		int 21h
		end start