masm
model small
.stack 256
.data
mes1	db	"Input your name: $"
mes2	db	10, 13, "Hello, $"
buf		db	20
		db	?
		db	20	dup(?)
.code
main:	mov ax, @data
		mov ds, ax
		lea dx, mes1
		mov ah, 9
		int 21h
		mov ah, 10
		lea dx, buf
		int 21h
		mov bl, buf + 1
		mov bh, 0
		mov buf[bx + 2], '$'
		mov ah, 9
		lea dx, mes2
		int 21h
		lea dx, buf + 2
		int 21h
		mov	ah, 7
		int 21h
		mov ax, 4c00h
		int 21h
		end main