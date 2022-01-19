.286
model small
.stack 100h
.data
i dw 3
N1 dw 5 dup (?)
N2 dw 5 dup (?)
res dw 10 dup (?)
KOD db 3 dup (?)
filename db 'output.txt',0
descr dw ?
readres db 4 dup ('$')
.code
enterInt proc near
	mov ah,01h
    int 21h ; в al - первый символ
    sub al,30h  ; перевод значения ASCII кода в число
    mov ah,0  ; расширение до слова
    mov bx,10
    mov cx,ax ; в cx - первая цифра
cycle:  
	mov ah,01h
    int 21h ;   в al следующий символ
    cmp al,0dh  ; сравнение с символом Enter
    je Ex         ; конец ввода
    sub al,30h   ;  перевод значения ASCII кода в число
    cbw             ; расширение до слова
    xchg ax,cx   ; меняем значение регистров
    mul bx          ; ax = ax*bx
    add cx,ax      ; cx=ax+cx
    jmp cycle     ; продолжение ввода
Ex :    
	ret
enterInt endp
convertToASCII proc near
	mov bl,10
    mov ax,res
    div bl  ; ah=c, al=ab
	add ah,30h ;перевод цифры в значение ASCII кода 
	mov KOD+2,ah  ; записали последнюю цифру
    mov ah,0   
	div bl    ; ah=b, al=a
	add ax,'00'   ; ah=b+’0’, al=a+’0’
	mov KOD+1,ah   ; записали среднюю цифру
	mov KOD,al  ; записали первую цифру
	ret
convertToASCII endp
start:
	mov ax, @data
    mov ds, ax
	call enterInt
	mov N1, cx
	call enterInt
	mov N2, cx
	mov ax, N1
	add ax, N2
	mov res, ax
	call convertToASCII
file:
	mov ah, 3Ch ;создание файла
	xor cx, cx
	lea dx, filename
	int 21h
	mov descr, ax
	mov ah, 3Dh ;открытие файла
	mov al, 2 ;чтобы открыть для чтения и записи
	lea dx, filename
	int 21h
	mov bx, descr
	mov cx, 1
	mov si, 0
	cmp KOD[si], 30h ;пропуск незначащего нуля
	jne write
	inc si
	dec i
	cmp KOD[si], 30h ;пропуск незначащего нуля
	jne write
	inc si
	dec i
write:
	mov ah, 40h
	mov bx, descr
	mov cx, 1
    lea dx, KOD[si] ;выводим тек. символ
    INT 21h
    inc si
	cmp si, 3
	jne write
	mov ah, 3Eh ;закрыть файл
	mov bx, descr
	int 21h
	mov ah, 3Dh ;открытие файла
	mov al, 2 ;чтобы открыть для чтения и записи
	lea dx, filename
	int 21h
	mov ah, 3fh ;чтение из файла
	mov bx, descr
	mov cx, i
	lea dx, readres
	int 21h
	mov ah, 09h
    mov dx, offset readres ;выводим сообщение на экран
    INT 21h
exit:	
    mov ax,4c00h
    int 21h
end start