masm
model small
.stack 256
.data
arr	db	151, 105, 109, 190, 106
	db	24, 69, 82, 10, 131
	db	118, 128, 130, 107, 198
	db	122, 143, 144, 79, 19
	db	112, 65, 110, 153, 144
max db 	?
arrMax	db	5 dup(?)
tabl	db	"0123456789ABCDEF"
newstr 	db 10, 13, '$'
rez db "** $"

nStr macro
	mov ah, 9
	lea dx, newstr
	int 21h
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
	
search macro
	cmp max, al
	ja m3
	mov max, al
m3:	endm
	
.code
main:	mov ax, @data
		mov ds, ax
		
		xor si, si
		xor di, di
		xor bx, bx
		mov cx, 5
m1:		push cx
		mov al, arr[si][bx]
		mov max, al
		push bx
		sixSS
		pop bx
		inc bx
		mov cx, 4
m0:		mov al, arr[si][bx]
		search
		push bx
		sixSS
		pop bx
		inc bx
		loop m0
		nStr
		
		mov al, max
		mov arrMax[di], al
		inc di
		xor bx, bx
		add si, 5
		pop cx
		loop m1
		
		nStr
		
		xor si, si
		mov cx, 5
m2:		mov al, arrMax[si]
		sixSS
		nStr
		inc si
		loop m2

		mov ah, 7
		int 21h
		mov ax, 4c00h
		int 21h
		end main