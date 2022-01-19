;Найти max(A(D)), если А(I) состоит из целых чисел, а I=1,2,...,10
model small
.stack 100h
.data
len equ 10
mas db 10, 15, 9, 8, 0, 7, 8, 12, 13, 0 ;значения массива. db - резервирование памяти в 1 байт
.code
start:
	mov ax, @data ;загрузка действительного физ. адреса
	mov ds, ax ;сегмента данных
	mov cx, len ;запись в регистр-счетчик переменной len
	xor	ax,ax ;очистить регистр ax
	xor si,si ;очистить регистр si
	jcxz exit ;если cx = 0, то переход на exit
	mov al, 0
cycl:
	cmp mas[si], al ;сравниваем элмент массива с al
	ja m1 ;если больше то на m1;
	jmp nxt ;иначе переход на nxt
m1:
	mov al, mas[si] ;поменять значение al
nxt:
	inc si ;перейти к следующему элементу
	loop cycl
exit:
	mov	ax,4c00h ;стандартный выход
	int	21h	
end start