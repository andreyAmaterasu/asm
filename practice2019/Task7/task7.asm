masm
model small
.stack 256
.data
num1	db	0fh, 4h, 6h, 0ah, 1h, 2h, 0ch, 7h, 0bh, 5h
len = $ - num1
num2	db	5h, 0ch, 1h, 3h, 9h, 0bh, 0fh, 8h, 1h, 0ah
N = 10
M = 10
buf	db	5
	db 	?
	db	5 dup(?)
tabl	db	"0123456789ABCDEF"
newstr db 10, 13, '$'
rez db "*$"
otvet	db	100 dup(0)
ad	dw	0
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
		
		space M+1
		output num1, N
		nStr
		space N+1
		output num2, M
		nStr
		
		mov di, len-1
		mov cl, M
mll:	push cx
		mov si, len-1
		mov cl, N
		mov bx, N+M
ml:		push bx
		mov al, num1[si]
		mov bl, num2[di]
		mul bl
		pop bx
		sub bx, ad
		push ax
		and al, 0fh
		add al, otvet[bx]
		push ax
		and al, 0fh
		mov otvet[bx], al	
		pop ax
		shr ax, 4
		add otvet[bx-1], al
		pop ax
		shr ax, 4
		add otvet[bx-1], al
		
		jnc m4
		adc otvet[bx-1], 0
m4:		add bx, ad
	
		dec si
		dec bx
		loop ml
		dec di
		pop cx
		inc ad
		
;		push si
;		push cx
;		push ax
;		xor si, si
;		mov cx, 6
;m5:		mov al, otvet[si]
;		sixSS
;		inc si
;		loop m5
;		pop ax
;		pop cx
;		pop si
;		nStr
		loop mll
		
		
		xor si, si
		mov cx, N+M+1
m5:		mov al, otvet[si]
		sixSS
		inc si
		loop m5
		
		mov ah, 7
		int 21h
		mov ax, 4c00h
		int 21h
		end main