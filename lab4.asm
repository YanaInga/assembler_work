model small
.stack 100h
.data
stroka db 128 dup('$')
outstroka db 128 dup (?)
simvR db 1 dup (?)
simvCh db 1 dup (?)
msg1 db 'Enter sentence$'
msg2 db 'Enter the symbol you want to replace$'
msg3 db 'Enter the symbol you want to change$'
.code
start:
    mov ax, @data
    mov ds, ax
    
    mov ah, 09h
    mov dx, offset msg1 ;выводим сообщение на экран
    INT 21h
    
    mov ah, 02h ;переход на новую строку
    mov dl, 0Ah 
    INT 21h
    
    mov ah, 0Ah ;ввод предложения пользователем
    mov dx, offset stroka
    INT 21h
    
    mov ah, 09h
    mov dx, offset msg2 ;выводим сообщение на экран
    INT 21h
    
    mov ah, 02h ;переход на новую строку
    mov dl, 0Ah
    INT 21h
    
    mov ah, 07h ;ввод символа пользователем
    INT 21h
    mov simvR, al ;сохраняем символ, который нужно заменить
    
    mov ah, 09h
    mov dx, offset msg3 ;выводим сообщение на экран
    INT 21h
    
    mov ah, 02h ;переход на новую строку
    mov dl, 0Ah
    INT 21h
    
    mov ah, 07h ;ввод символа пользователем
    INT 21h
    mov simvCh, al ;сохраняем символ, на который нужно исправить
    
    xor si,si ;очищаем
    xor ax, ax ;регистры
    mov si, 2 ;начало прохода по строке
    mov cl, stroka[1] ;определяем длину строки
cycle:
    mov al, simvR
    cmp stroka[si], al ;тек. символ строки == тому, что подлежит замене?
    je change ;да
    mov al, stroka[si] ;нет ->
    mov outstroka[si], al ;оставляем в строке тек. символ
    jmp nxt
change:
    mov al, simvCh
    mov outstroka[si], al ;заменяем символ на другой
nxt:
    inc si
    loop cycle

    mov si, 2 ;начало прохода по строке
    mov cl, stroka[1] ;определяем длину строки
    mov ah, 02h ;посимвольный вывод на экран предложения
print:
    mov dl, offset outstroka[si] ;выводим тек. символ
    INT 21h
    inc si
    loop print
exit:   
    mov ax,4c00h
    int 21h
end start