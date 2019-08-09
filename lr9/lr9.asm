sdvig	macro per1
	mov cx, 12
m1:	stc
	rcr	dword ptr per1+4, 1
	rcr	dword ptr per1, 1
loop m1
	bin per1
	endm
	
bin 	macro per3
	local m2, m3
	mov cx, 32
	mov ah, 2
	m2:	rol dword ptr per3+4, 1
	mov dl, 0
	adc dl, '0'
	int 21h
	loop m2
	mov cx, 32
	m3:	rol dword ptr per3, 1
	mov dl, 0
	adc dl, '0'
	int 21h
loop m3
	endm

newtab macro
		mov ah,2
		mov dl,10
		int 21h
		mov dl,13
		int 21h
endm
	
masm
model small
.stack 256
.data
num1	dq	88775544ffee6000h
.code
main:	mov	ax, @data
		mov	ds, ax
		.386
		bin num1
		newtab
		sdvig	num1
		mov ah, 7
		int 21h
		mov ax, 4c00h
		int 21h
		end main
		
		