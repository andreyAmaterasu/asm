masm
model small
.stack 256
.data
kol	db	?
num	db	4fh, 0fbh, 1fh, -5h, 0a2h
	db	99h, 0fch, 01h, 0eeh, -6h
	db	03eh, -4h, 75h, 59h, 9bh
	db	-2h, 21h, 08h, 5dh, 0efh
len = $ - num
buf	db	5
	db 	?
	db	5 dup(?)
tabl	db	"0123456789ABCDEF"
newstr db 10, 13, '$'
rez db "**$"

output macro
	mov si, 19
	mov cl, kol
m0:	mov ah, 9
	mov al, num[si]
	sixSS
	dec si
	loop m0
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

.code

binSS proc 
	mov cx, 8
	mov ah, 2 
	m1: rol num[si], 1 
	mov dl, '0' 
	adc dl, 0 
	int 21h 
	loop m1 
	ret 
binSS endp

main:	mov ax, @data
		mov ds, ax
		
		mov ah, 10
		lea dx, buf
		int 21h
		mov bl, buf + 1
		mov bh, 0
		mov buf[bx + 2], '$'
		
		mov al, buf[1]
		cmp al, 2
		jne oneNum
		mov ah, buf[2]
		mov al, buf[3]
		and ax, 0f0fh
		aad
		jmp twoNum
oneNum:	mov al, buf[2]
		and ax, 0fh
		aad
		
twoNum:	mov kol, al
		nStr
		output
		mov ah, 2
		mov dl, 'h'
		int 21h
		nStr
		
		mov si, len-1
		mov cl, kol
m5:		push cx
		call binSS
		pop cx
		dec si
		loop m5
		
		mov ah, 7
		int 21h
		mov ax, 4c00h
		int 21h
		end main