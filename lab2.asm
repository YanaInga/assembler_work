;Даны два множества заданные в виде массивов А(I) и В(I); 
;I=1,2,..,10. Найти сумму (об’единение) множеств. 
;C(J) - сумма двух множеств есть множество всех элементов принадлежащих А или В. 
;Например, {1,2,3} U {2,3,4} = {1,2,3,4}. 
;Задачу добавления нового элемента массива оформить в виде подпрограммы.
model small
.stack  100h
.data
i dw 0
count1 dw 10
masA db 1, 3, 4, 6, 7, 8, 12, 13, 14, 15
masB db 1, 2, 4, 5, 6, 8, 9, 10, 12, 13
masC db 20 dup(?)
.code
func proc near
    cmp al, bx[di] ;сравнение двух элементов массивов А и В
    jb writeA ;элемент в массиве А меньше
    ja writeB ;элемент в массиве А больше
    inc di ;элементы
    inc si ;равны
	ret
writeA:
    inc si ;переход на новый элемент в массиве А
	ret
writeB:
    mov al, bx[di] ;поместили элемент из массива В
    inc di ;переход на новый элемент в массиве А
	ret
func endp
start:
    mov ax,@data
    mov ds,ax
    xor si,si ;очищение регистров
    xor di,di
    xor ax, ax
    xor bx, bx
cycle:
    mov al, masA[si] ;записали элемент массива А
	lea bx, masB ;записали массив В
    call func ;вызов функции
	push si ;положили в стек
	mov si, i 
    mov masC[si], al ;добавили новый элемент в массив С
	pop si ;достали из стека
	inc i 
	cmp count1, si ;проверка на проход по массиву А
	je add2
	cmp count1, di ;;проверка на проход по массиву В
	je add1
    jmp cycle
add1:
	cmp si, count1 ;проверка на проход по массиву А
	je end_add
	mov al, masA[si] ;считали из массива очеред. элемент
	push si
	mov si, i
	mov masC[si], al ;добавили новый элемент в массив С
	pop si
	inc si
	inc i
	jmp add1
add2:
	cmp di, count1 ;проверка на проход по массиву В
	je end_add
	mov al, bx[di]  ;считали из массива очеред. элемент
	push si
	mov si, i
	mov masC[si], al ;добавили новый элемент в массив С
	pop si
	inc di
	inc i
	jmp add2
end_add:
    mov ax,4c00h
    int 21h
end start