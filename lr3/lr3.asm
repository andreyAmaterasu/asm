data	segment
num		dw			21500
t25		dd			2525252155
data	ends
stk	segment	stack
	db	256 dup('?')	
stk	ends
code	segment	
assume cs:code, ds:data, ss:stk
start: 	mov ax, data
		mov	ds, ax 
		mov	bx, -32768
		mov bp, bx
		xchg ax, word ptr t25 + 2
		mov dx, num
		push bx
		push word ptr t25
		pop bx
		pop word ptr t25
		xchg cl, ah
		mov	ax, 4c00h 
		int	21h 
code	ends 
end	start 