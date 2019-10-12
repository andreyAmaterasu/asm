masm
model small
.stack 256
.data
num1	db	0fh, 3h, 9h, 9h, 0ch, 0ah, 5h, 1h
len = $ - num1
num2	db	0h, 0h, 9h, 9h, 0ch, 0dh, 7h, 0ah
N = 8
M = 6
tabl	db	"0123456789ABCDEF"
newstr db 10, 13, '$'
rez db "*$"
otvet	db	100 dup(0)
shift	db	0
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
nextMul:push cx
		mov si, len-1
		mov cl, N
		mov bx, N+M
		
multi:	push bx
		mov al, num1[si]
		mov bl, num2[di]
		mul bl
		pop bx
		sub bx,	word ptr shift
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
		add bx, word ptr shift
		dec si
		dec bx
		loop multi
		
		dec di
		pop cx
		inc shift
		loop nextMul
		
		xor si, si
		mov cx, N+M+1
print:	mov al, otvet[si]
		sixSS
		inc si
		loop print
		
		mov ah, 7
		int 21h
		mov ax, 4c00h
		int 21h
		end main