masm
model small
.stack 256
.data
otvet	db	20 dup(?)
p1	db	-5
buf	db	5
	db 	?
	db	5 dup(?)
newstr db 10, 13, '$'

nStr macro
	mov ah, 9
	lea dx, newstr
	int 21h
	endm

.code

binss proc 
	mov cx, 8 
	mov ah, 2 
	m1: rol p1, 1 
	mov dl, '0' 
	adc dl, 0 
	int 21h 
	loop m1 
	mov ah, 7 
	int 21h 
	ret 
binss endp

main:	mov ax, @data
		mov ds, ax
		
		call binss
		
		mov ah, 7
		int 21h
		mov ax, 4c00h
		int 21h
		end main