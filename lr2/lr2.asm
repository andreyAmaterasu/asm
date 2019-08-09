data	segment	;сегмент данных
massage	db	'Hello$'
newstr	db	10, '$', 13
str5	db	'Variant5$'
per1	dd	8Bh
per2	db	5 dup(-55)
per3	dw	?
per4	db	110111b
per5	dw	-20, 23, -24, 31, -34
ea_per2	dw	per2
pa_per2	dd	per2
ea_per1	dw	per1
pa_per1	dd	per1
num	dd	2.55
data	ends
stk	segment	stack
	db	256 dup('?')	;сегмент стека
stk	ends
code	segment	;начало сегмента кода
main:
	assume cs:code, ds:data, ss:stk
	mov	ax, data ;поместить в ds адрес сегмента данных
	mov	ds, ax
	mov	ah, 9 ;вывод строки символов
	mov	dx, offset massage ; запись эффективного адреса строки
	int	21h ;вызов прерывания с номером 21h для функции 9
	mov	ah, 9
	mov	dx, offset newstr
	int	21h
	mov	ah, 9
	mov	dx, offset str5
	int	21h
	mov	ah, 7 ;ожидание ввода символа с клавиатуры
	int	21h ;вызов прерывания с номером 21h для функции 7
	mov	ax, 4c00h ;завершение программы
	int	21h ;вызов прерывания с номером 21h для функции 4CH
code	ends ;конец сегмент кода
end	main ;конец программы с точкой входа main