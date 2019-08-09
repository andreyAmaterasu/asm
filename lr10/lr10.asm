masm
model small
.stack	256
.data
p1	dd	0
tab db '0123456789ABCDEF'
rez	db	'********h$'
newstr db 10, 13 , '$'
.code
.386
sixss proc
	push ax
	shr al, 4
	xlat
	mov [si], al
	pop ax
	and al, 0fh
	xlat
	mov [si + 1], al
ret
sixss endp

binss proc
	mov cx, 32
	mov ah, 2
m1: rol p1, 1
	mov dl, '0'
	adc dl, 0
	int 21h
loop m1
	mov ah, 7
	int 21h
ret
binss endp

start:	mov	ax, @data
		mov	ds, ax
		
		
		mov ax, 46h
		mov es, ax
		mov eax, es:[0ch]
		mov p1, eax
		lea bx, tab
		lea si, rez
		mov al, byte ptr p1 + 3
		call sixss
		add si, 2
		mov al, byte ptr p1 + 2
		call sixss
		add si, 2
		mov al, byte ptr p1 + 1
		call sixss
		add si, 2
		mov al, byte ptr p1
		call sixss
		mov ah, 9
		lea dx, rez
		int 21h
		
		lea dx, newstr
		mov	ah, 9
		int 21h

		call binss
		mov ah, 7
		int 21h
		
		lea dx, newstr
		mov	ah, 9
		int 21h
		
		;mov eax, p1
		;mov cx, 2
;m2:		sar word ptr p1, 1
		;loop m2
		;call binss
		;mov ah, 9
		;int 21h
		sar word ptr p1, 2
		
		lea si, rez
		mov al, byte ptr p1 + 3
		call sixss
		add si, 2
		mov al, byte ptr p1 + 2
		call sixss
		add si, 2
		mov al, byte ptr p1 + 1
		call sixss
		add si, 2
		mov al, byte ptr p1
		call sixss
		mov ah, 9
		lea dx, rez
		int 21h
		
		lea dx, newstr
		mov	ah, 9
		int 21h

		call binss
		mov ah, 7
		int 21h
		
		mov ah, 7
		int 21h
		mov ax, 4c00h
		int 21h
		end start