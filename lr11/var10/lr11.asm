masm
model small
.stack 256
.data
arr	db	119, 38, 0, 17, -17, 28, 11, 0, 32, -101
len = $ - arr
tabl	db	"0123456789ABCDEF"
quantity	db	0
rez db "** $"
newstr db 10, 13 , '$'

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


.code
begin:	mov ax, @data
		mov ds, ax

		;Вывод массива на экран
		xor si, si
		mov cx, len
m0:		mov al, arr[si]
		lea bx, rez
		inc si
		sixSS
		loop m0

		nStr

		xor si, si
		mov cx, len
m1:		cmp arr[si], 0 
		jle m2 ;если число 0 или меньше, то на m2
		test arr[si], 1 ;иначе
		jz m2 ;если число четное, на метку m2
		inc quantity ;иначе +1
		mov al, arr[si]
		sixSS ;вывод в 16СС
		
m2:		inc si
		loop m1
		
		nStr
		
		mov al, quantity
		lea bx, tabl
		xlat
		mov ah, 2
		mov dl, al
		int 21h
		
		mov ah, 7
		int 21h
		mov ax, 4c00h
		int 21h
		end begin