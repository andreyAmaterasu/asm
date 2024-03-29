masm
model small
.stack 256
.data
arr1	db	-10, 22, 26, -120, 3
		db	77, -29, 126, 1, 11
		db	32, 73, 54, -10, 10
		db	-12, 38, 66, -126, 99
len = $ - arr1
arr2	db	-83, 27, 12, -90, 75
		db	91, 30, 44, -47, 75
		db	-19, 29, 101, -100, 9
		db	-120, 32, 126, -20, 5
otvet	db	20 dup(?)
buf	db	5
	db 	?
	db	5 dup(?)
kol	db	?
tabl	db	"0123456789ABCDEF"
newstr db 10, 13, '$'
rez db "**$"

output macro arr 
	local m0
	xor ax, ax
	mov al, len
	sub al, kol
	mov si, ax
	mov cl, kol
m0:	mov ah, 9
	mov al, arr[si]
	sixSS
	inc si
	loop m0
	endm

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
	
space macro
	local cSpace 
	mov cx, 2
cSpace:	mov ah, 2
	mov dl, ' '
	int 21h
	loop cSpace
	endm
	
.code
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
		space
		output arr1
		nStr
		space
		output arr2
		nStr
		
		mov di, 1
		mov si, len-1
		mov cl, kol
sum:	mov al, arr2[si]
		adc arr1[si], al
		mov al, arr1[si]
		mov otvet[di], al
		dec si
		inc di
		loop sum

		jnc noPer
		adc otvet[0], 0
		mov al, otvet[0]
		sixSS
		jmp noSpace
noPer:	space
noSpace:mov si, word ptr kol
		and si, 00ffh
		mov cl, kol
outOtv:	mov al, otvet[si]
		sixSS
		dec si
		loop outOtv
		
		mov ah, 7
		int 21h
		mov ax, 4c00h
		int 21h
		end main