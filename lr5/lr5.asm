masm
model small
.stack	256
.data
mes1	db	"Input first word: $"
mes2	db	10, 13, "Input second word: $"
newstr	db	10, 13, '$'
p1		dw	?
buf1	db	20
		db	?
		db	20 dup(?)
buf2	db	20
		db	?
		db	20 dup(?)
.code
main:	mov ax, @data
		mov	ds, ax
		lea dx, mes1
		mov ah, 9
		int 21h
		mov ah, 10
		lea dx, buf1
		int 21h
		mov bl, buf1 + 1
		mov bh, 0
		mov buf1[bx + 2], '$'
		mov ah, 9
		
		lea dx, mes2
		mov ah, 9
		int 21h
		mov ah, 10
		lea dx, buf2
		int 21h
		mov bl, buf2 + 1
		mov bh, 0
		mov buf2[bx + 2], '$'
		
		lea dx, newstr
		mov ah, 9
		int 21h
		
		lea dx, buf2 + 2
		mov ah, 9
		int 21h
		
		lea dx, newstr
		mov ah, 9
		int 21h
		
		mov ah, 2
		mov dl, buf1[2]
		int 21h
		
		lea dx, buf1[bx]
		mov p1, dx

		mov ah, 7
		int 21h
		mov ax, 4c00h
		int 21h
		end main