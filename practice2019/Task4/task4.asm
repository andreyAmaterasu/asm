masm
model small
.stack 256
.data
ugol	db	1
cycleUgol	db	?
addDI	db 	?
addOrSub	db 	?
.code
line proc 
m0:	push cx
	mov ah, 0ch
	mov bh, 0
	mov cx,	si
	mov dx, di
	int 10h
	
	;выводить линию из левого нижнего в правый верхний угол (0)
	;или из левого верхнего в правый нижний угол (1)
	cmp addOrSub, 1
	jne toSub
	xor bx, bx
	mov bl, addDI
	add di, bx
	jmp skipSub
toSub:	xor bx, bx
	mov bl, addDI
	sub di, bx
skipSub: xor bx, bx
	mov bl, ugol
	cmp cycleUgol, bl
	jne m1
	inc si
	mov ugol, 0
	
m1:	pop cx
	inc ugol
	loop m0
	mov ugol, 1
	
ret
line endp

main:	mov ax, @data
		mov ds, ax
		
		mov ah, 0h
		mov al, 12h
		int 10h

		;нос ракеты
		mov si, 330
		mov di,	10
		mov cx, 50
		mov al, 7
		mov cycleUgol, 1
		mov addDI, 1
		mov	addOrSub, 1
		call line 
		
		mov si, 280
		mov di,	60
		mov cx, 50
		mov	addOrSub, 0
		call line

		mov si, 280
		mov di,	60
		mov cx, 100
		mov addDI, 0
		mov	addOrSub, 1
		call line

		
		;иллюминатор
		mov si, 323
		mov di,	100
		mov cx, 16
		call line 

		mov si, 313
		mov di,	110
		mov cx, 10
		mov addDI, 1
		mov	addOrSub, 0
		call line

		mov si, 339
		mov di,	101
		mov cx, 10
		mov	addOrSub, 1
		call line
		
		mov si, 313
		mov di,	110
		mov cx, 10
		mov cycleUgol, 0
		call line
		
		mov si, 348
		mov di,	111
		mov cx, 10
		call line
		
		mov si, 313
		mov di,	120
		mov cx, 10
		mov cycleUgol, 1
		call line
		
		mov si, 323
		mov di,	130
		mov cx, 15
		mov addDI, 0
		call line

		mov si, 338
		mov di,	130
		mov cx, 10
		mov addDI, 1
		mov	addOrSub, 0
		call line

		;стенки ракеты
		mov si, 280
		mov di,	60
		mov cx, 200
		mov cycleUgol, 0
		mov	addOrSub, 1
		call line

		mov si, 379
		mov di,	60
		mov cx, 200
		call line

		mov si, 280
		mov di,	260
		mov cx, 100
		mov cycleUgol, 1
		mov addDI, 0
		call line

		;низ ракеты
		mov si, 256
		mov di,	310
		mov cx, 50
		mov cycleUgol, 2
		mov addDI, 1
		mov	addOrSub, 0
		call line

		mov si, 379
		mov di,	260
		mov cx, 50
		mov	addOrSub, 1
		call line

		mov si, 256
		mov di,	310
		mov cx, 60
		mov cycleUgol, 0
		call line
		
		mov si, 256
		mov di,	370
		mov cx, 20
		mov cycleUgol, 1
		mov addDI, 0
		call line

		mov si, 275
		mov di,	370
		mov cx, 50
		mov cycleUgol, 4
		mov addDI, 1
		mov	addOrSub, 0
		call line
		
		mov si, 288
		mov di,	320
		mov cx, 20
		mov cycleUgol, 1
		mov addDI, 0
		mov	addOrSub, 1
		call line
		
		mov si, 307
		mov di,	320
		mov cx, 50
		mov cycleUgol, 4
		mov addDI, 1
		call line
		
		mov si, 320
		mov di,	370
		mov cx, 20
		mov cycleUgol, 1
		mov addDI, 0
		call line

		mov si, 339
		mov di,	370
		mov cx, 50
		mov cycleUgol, 4
		mov addDI, 1
		mov	addOrSub, 0
		call line

		mov si, 352
		mov di,	320
		mov cx, 20
		mov cycleUgol, 1
		mov addDI, 0
		mov	addOrSub, 1
		call line

		mov si, 371
		mov di,	320
		mov cx, 50
		mov cycleUgol, 4
		mov addDI, 1
		call line

		mov si, 384
		mov di,	370
		mov cx, 20
		mov cycleUgol, 1
		mov addDI, 0
		call line

		mov si, 403
		mov di,	310
		mov cx, 60
		mov cycleUgol, 0
		mov addDI, 1
		call line
		
		mov ah, 8
		int 21h
		mov ah, 0
		mov al, 3
		int 10h
		
		mov ax, 4c00h
		int 21h
		end main