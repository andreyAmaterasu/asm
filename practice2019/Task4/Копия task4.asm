masm
model small
.stack 256
.data
ugol	db	1
defaultDown	 db 1

lineDown macro weightSI, heightDI, cycleCX, color, cycleUgol, addDI, addOrSub
	local m0
	local m1
	local toSub
	local skipSub
	mov si, weightSI
	mov di, heightDI
	mov cx, cycleCX
m0:	push cx
	mov ah, 0ch
	mov al, color
	mov bh, 0
	mov cx,	si
	mov dx, di
	int 10h
	
	;выводить из левого нижнего в правый верхний угол (0)
	;или из левого верхнего в правый нижний угол (1)
	cmp defaultDown, addOrSub
	jne toSub
	add di, addDI
	jmp skipSub
toSub:	sub di, addDI
skipSub:cmp ugol, cycleUgol
	jne m1
	inc si
	mov ugol, 0
	
m1:	pop cx
	inc ugol
	loop m0
	mov ugol, 1
	endm
	
.code
main:	mov ax, @data
		mov ds, ax
		
		mov ah, 0h
		mov al, 12h
		int 10h

		;нос ракеты
		lineDown 330, 10, 50, 7, 1, 1, 1
		lineDown 280, 60, 50, 7, 1, 1, 0
		lineDown 280, 60, 100, 7, 1, 0, 1
		
		;иллюминатор
		lineDown 323, 100, 16, 7, 1, 0, 1
		lineDown 313, 110, 10, 7, 1, 1, 0
		lineDown 339, 101, 10, 7, 1, 1, 1
		lineDown 313, 110, 10, 7, 0, 1, 1
		lineDown 348, 111, 10, 7, 0, 1, 1
		lineDown 313, 120, 10, 7, 1, 1, 1
		lineDown 323, 130, 15, 7, 1, 0, 1
		lineDown 338, 130, 10, 7, 1, 1, 0
		
		;стенки ракеты
		lineDown 280, 60, 200, 7, 0, 1, 1
		lineDown 379, 60, 200, 7, 0, 1, 1
		lineDown 280, 260, 100, 7, 1, 0, 1
		
		;низ ракеты
		lineDown 256, 310, 50, 7, 2, 1, 0
		lineDown 379, 260, 50, 7, 2, 1, 1
		lineDown 256, 310, 60, 7, 0, 1, 1
		lineDown 256, 370, 20, 7, 1, 0, 1
		lineDown 275, 370, 50, 7, 4, 1, 0
		lineDown 288, 320, 20, 7, 1, 0, 1
		lineDown 307, 320, 50, 7, 4, 1, 1
		lineDown 320, 370, 20, 7, 1, 0, 1
		lineDown 339, 370, 50, 7, 4, 1, 0
		lineDown 352, 320, 20, 7, 1, 0, 1
		lineDown 371, 320, 50, 7, 4, 1, 1
		lineDown 384, 370, 20, 7, 1, 0, 1
		lineDown 403, 310, 60, 7, 0, 1, 1
		
		mov ah, 8
		int 21h
		mov ah, 0
		mov al, 3
		int 10h
		
		mov ax, 4c00h
		int 21h
		end main