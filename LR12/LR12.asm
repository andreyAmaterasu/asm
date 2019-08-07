masm
model small
.stack	256
.data
p1	db	10 dup(0)
p2	db	10 dup(0)
sum	db	10 dup(0)
dif	db	10 dup(0)
razm db ?
newstr db 10, 13 , '$'
plus db ' + $'
minus db ' - $'
equal db ' = $'
bufOne	db	80
		db	?
		db	80 dup(?)
bufTwo	db	80
		db	?
		db	80 dup(?)
nStr macro
	mov ah, 9
	lea dx, newstr
	int 21h
	endm
input macro buf
	mov ah, 10
	lea dx, buf
	int 21h
	mov bl, buf + 1
	mov bh, 0
	mov buf[bx + 2], '$'
	endm
signs macro bufOne, bufTwo, equal, sign
	mov ah, 9
	lea dx, bufOne + 2
	int 21h
	lea dx, sign
	int 21h
	lea dx, bufTwo + 2
	int 21h
	lea dx, equal
	int 21h
	endm
toP macro buf, p
	local m0
	mov bl, buf + 1
	inc bx	
	mov si, 0
	mov cl, buf + 1
m0:	mov al, buf[bx]
	mov p[si], al
	dec bx
	inc si
	loop m0
	endm
output macro rez, razm
	local m5
	mov cl, al
	mov ah, 2
m5:	mov dl, rez[bx]
	or	dl, 30h
	int 21h
	dec bl
	loop m5
	endm
	
.code
begin:	mov ax, @data
		mov ds, ax
		
		input bufOne
		nStr
		input bufTwo
		nStr
		signs bufOne, bufTwo, equal, minus
		
		mov al, bufTwo + 1
		mov razm, al ;наибольая размерность bufTwo
		cmp bufOne + 1, al
		jb m7
		mov al, bufOne + 1
		mov razm, al ;иначе наибольая размерность bufTwo
		
m7:		toP bufOne, p1
		toP bufTwo, p2
		
		xor bx, bx
		mov cl, razm
m2:		mov al, p1[bx]
		sbb al, p2[bx]
		aas
		mov dif[bx], al
		inc bl
		loop m2
		mov bl, razm
		dec bl
		mov al, razm
		output dif, razm
		
		nStr
		signs bufOne, bufTwo, equal, plus
		
		xor bx, bx
		mov cl, razm
m4:		mov al, p1[bx]
		adc al, p2[bx]
		aaa
		mov sum[bx], al
		inc bl
		loop m4
		push bx ;сохраняю bx
		mov bl, razm ;начинаю с 1 индекса если небыло переноса
		dec bl
		mov al, razm ;цикл без переноса
		jae m6 ;если cf=0 на метку m6
		pop bx ;иначе воостанавливаю bx
		adc sum[bx], 0 ;перенос в старший разряд
		inc al ;цикл + 1 (с переносом)
		mov bl, razm
m6:		output sum, razm
		
		mov ah, 7
		int 21h
		mov ax, 4c00h
		int 21h
		end begin