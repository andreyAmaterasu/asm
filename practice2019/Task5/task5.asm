masm
model small
.stack 256
.data
arr1	db	-120, 32, 126, -120, 3
		db	-120, 32, 126, -120, 3
		db	-120, 32, 126, -120, 3
		db	-120, 32, 126, -120, 3
len = $ - arr1
arr2	db	-120, 126, 125, -120, 75
		db	-120, 32, 126, -120, 3
		db	-120, 32, 126, -120, 3
		db	-120, 32, 126, -120, 3
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
	xor si, si
	mov cx, len
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
		
		space 2
		output arr1
		nStr
		space 2
		output arr2
		nStr

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
		mov di, len
		mov si, len-1
		mov cl, kol
sum:	mov al, arr2[si]
		adc	arr1[si], al
		mov al, arr1[si]
		mov otvet[di], al
		dec si
		dec di
		loop sum
		
		pushf
		
		jnc noPer
		adc otvet[0], 0
		mov al, otvet[0]
		sixSS
		
noPer:	xor ax, ax
		mov al, len+1
		sub al, kol
		mov si, ax
		
		popf
		jnc skipDec
		dec al
		
skipDec:mov bl, 2
		mul bl
		cmp ax, 0
		je skipSp
		space ax
skipSp:	mov cl, kol
		
outAns:	mov al, otvet[si]
		sixSS
		inc si
		loop outAns
		
		mov ah, 7
		int 21h
		mov ax, 4c00h
		int 21h
		end main