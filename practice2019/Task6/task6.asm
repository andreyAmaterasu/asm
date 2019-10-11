masm
model small
.stack 256
.data
kol	db	?
num	db	0fh, 0bh, 1h, -5h, 0ah
	db	9h, 0ch, 1h, 7h, -6h
	db	0eh, -4h, 0ah, 0ah, 0bh
	db	-2h, 2h, 8h, 0dh, 0fh
buf	db	5
	db 	?
	db	5 dup(?)
tabl	db	"0123456789ABCDEF"
newstr db 10, 13, '$'
rez db "0*$"

output macro
	xor si, si
	mov cl, kol
m0:	mov ah, 9
	mov al, num[si]
	sixSS
	inc si
	loop m0
	endm
	
sixSS macro
	lea bx, tabl
	and al, 0fh
	xlat
	mov rez+1, al
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

		output
		mov ah, 2
		mov dl, 'h'
		int 21h
		nStr
		
		xor si, si
		mov cl, kol
m5:		push cx
		call binSS
		pop cx
		inc si
		loop m5
		
		mov ah, 7
		int 21h
		mov ax, 4c00h
		int 21h
		end main