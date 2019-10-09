masm
model small
stack 256
.data
kajdiy	db	"Kajdiy"
lenK = $ - kajdiy
ohotnik	db	"ohotnik"
lenO = $ - ohotnik
jelaet	db	"jelaet"
lenJ = $ - jelaet
znat	db	"znat'"
lenZ = $ - znat
gde		db	"gde"
lenG = $ - gde
sidit	db	"sidit"
lenS = $ - sidit
fazan	db	"fazan"
lenF = $ - fazan
press	db	"Press any key to continue"
lenPress = $ - press

window macro x1, y1, x2, y2, atr, x3, y3, string, len
	mov ah, 6
	mov al, 0
	mov bh, atr
	shl	bh, 4
	mov ch, y1
	mov	cl, x1
	mov dh, y2
	mov dl,	x2
	int 10h
	
	mov ah, 13h
	mov al, 0
	mov bl, bh
	mov bh, 0
	add bl, 15
	sub bl, atr
	mov cx, len
	mov dh, y3
	mov dl, x3
	push ds
	pop es
	lea bp, string
	int 10h
	
	mov ah, 7
	int 21h
	endm

clean macro
	mov ah, 6
	mov al, 0
	mov bh, 0
	mov cx, 0
	mov dh, 24
	mov dl, 79
	int 10h
	endm
	
.code
main:	mov	ax, @data
		mov ds, ax
		
		clean
		
		window 35, 1, 44, 3, 4, 37, 2, kajdiy, lenK
		window 33, 4, 46, 6, 6, 36, 5, ohotnik, lenO
		window 31, 7, 48, 9, 14, 37, 8, jelaet, lenJ
		window 29, 10, 50, 12, 2, 38, 11, znat, lenZ
		window 31, 13, 48, 15, 9, 39, 14, gde, lenG
		window 33, 16, 46, 18, 1, 38, 17, sidit, lenS
		window 35, 19, 44, 21, 5, 38, 20, fazan, lenF
		
		mov ax, 0b800h
		mov es, ax
		mov bx, (80*24)*2
		lea si, press
		mov cx, lenPress
m0:		mov al, [si]
		mov es:[bx], al
		inc bx
		mov byte ptr es:[bx], 0fh
		inc bx
		inc si
		loop m0
		
		mov ah, 7
		int 21h
		mov ax, 4c00h
		int	21h
		end main
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		