model small
.stack 100h
.data
y dw 199
x dw 0
time db 0
.code
clear_screen proc near
    mov ah, 00h ; устанавливаем видеорежим
    mov al, 13h ; 320x200 256-цветовой
    INT 10h
    
    mov ah, 0Bh  ;устанавливаем цвет фона
    mov bh, 00h   
    mov bl, 00h  ;черный
    INT 10h  
ret
clear_screen endp
draw_line proc near
    draw:
    mov ah, 0Ch   ;устанавливаем  режим рисования пикселя
    mov al, 0Ah   ;зеленый цвет
    mov bh, 00h   ;номер страницы
    INT 10h
    inc cx ;cx++
    cmp cx, 13Fh ;cx>window_width?
    jng draw ;если не больше, то продолжаем рисовать
ret
draw_line endp
main:
    mov ax,@data
    mov ds,ax
    call clear_screen
    check_time:
    mov ah, 2Ch ;получаем системное время
    INT 21h
    cmp dl, time ;текущее время==предыдущему?
    je check_time ;если равно, то проверяем еще раз
    mov time, dl ;обновляем время
    mov cx, x   ;устанавливаем номер столбца 
    mov dx, y   ;устанавливаем номер строки
    call clear_screen
    call draw_line
    dec y ;y--
	cmp y, 00h ;достигли верха страницы?
    je exit ;если да, то выход
    jmp check_time 
    exit:
    mov ax,4c00h
    int 21h 
end main

