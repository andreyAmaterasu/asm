masm
model small
.stack 256
.data
num1	db	12h, 0f3h, 99h, 0cah, 51h, 40h, 75h, 0f1h, 0ddh, 84h
len = $ - num1
num2	db	39h, 1ah, 99h, 0cdh, 7ah, 0dah, 0adh, 59h, 73h, 0eah
N = 5
M = 3
tabl	db	"0123456789ABCDEF"
newstr db 10, 13, '$'
rez db "**$"
otvet	db	20 dup(0)
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
		
		space M*2
		output num1, N
		nStr
		space N*2
		output num2, M
		nStr
		
		mov di, len-1
		mov cl, M
nextMul:push cx
		mov si, len-1
		mov cl, N
		mov bx, N+M-1
		
multi:	push bx
		mov al, num1[si]
		mov bl, num2[di]
		mul bl
		pop bx
		sub bx, word ptr shift
		adc otvet[bx], al
		adc otvet[bx-1], ah
		adc otvet[bx-2], 0
		add bx, word ptr shift
		dec si
		dec bx
		loop multi
		
		dec di
		pop cx
		inc shift
		loop nextMul
		
		xor si, si
		mov cx, N+M
print:	mov al, otvet[si]
		sixSS
		inc si
		loop print
		
		mov ah, 7
		int 21h
		mov ax, 4c00h
		int 21h
		end main