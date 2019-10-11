masm
model small
.stack 256
.data
num1	db	0fh, 4h, 0fh, 0fh, 0fh
len = $ - num1
num2	db	5h, 0ch, 1h, 0ch, 0ah
N = 3
M = 2
buf	db	5
	db 	?
	db	5 dup(?)
tabl	db	"0123456789ABCDEF"
newstr db 10, 13, '$'
rez db "*$"
otvet	db	6 dup(0)
ad	dw	1
sb	dw	0
output macro num, cyc
	local one
	mov si, len-cyc
	mov cl, cyc
one:mov al, num[si]
	sixSS
	inc si
	loop one
	endm
	
sixSS macro
	lea bx, tabl
	and al, 0fh
	xlat
	mov rez, al
	mov ah, 9
	lea dx, rez
	int 21h
	endm

nStr macro
	mov ah, 9
	lea dx, newstr
	int 21h
	endm
	
space macro cycle
	local cSpace 
	mov cx, cycle
cSpace:	mov ah, 2
	mov dl, ' '
	int 21h
	loop cSpace
	endm

.code
main:	mov ax, @data
		mov ds, ax
		
		space 1
		output num1, N
		nStr
		space 2
		output num2, M
		nStr
		
		mov di, len-1
		mov cl, 2
mll:	push cx
		mov si, len-1
		mov cl, N
ml:		mov al, num1[si]
		mov bl, num2[di]
		mul bl
		add si, ad
;		add al, otvet[si]
;		mov otvet[si], al
		add otvet[si], al
		sub si, ad
		
		cmp al, 0ah
		jb	m9
		
		cmp al, 0fh
		ja m9
		sub si, sb
		add otvet[si], 1
		add si, sb
		jmp m10
m9:
		
		shr ax, 4
		sub si, sb
		add otvet[si], al
		add si, sb
m10:		
		dec si
		loop ml
		dec di
		pop cx
		dec ad
		inc sb
		
		loop mll
		
		
		
		xor si, si
		mov cx, 6
m5:		mov al, otvet[si]
		sixSS
		inc si
		loop m5
		
		mov ah, 7
		int 21h
		mov ax, 4c00h
		int 21h
		end main