model small
.486
.stack 100h
.data
	var1 dd 320.0
	var2 dd 4.0
	var3 dd 256.0
	var4 dd 2.0
	var5 dd 14.0
	var6 dd 56.0
	var7 dd 3.0
	x dd 2.5
	a dd 1.0
	y dd 0.0	
.code
start: 
	mov ax, @data
    mov ds, ax
	finit ;Инициализация сопроцессора
	fld x
	fsub a ;st(0) = x - a = 1.5
	fsin ;st(0) = sin(x-a) = 0.9974
	fld x ; st(0) = x; st(1) = sin(x-a)
	fadd a ; st(0) = x + a=3.5; st(1) = sin(x-a)
	fcos ; st(0) = cos(x + a) = -0.936456; st(1) = sin(x-a)
	fdiv ;st(0) = sin(x-a)/cos(x + a) = -1.065
	fmul var5 ;st(0) = cos(x + a)/sin(x-a) * 14 = −14,912
	fld var1
	fdiv var2 ; st(0) = 320/4 = 80; st(1) = cos(x + a)/sin(x-a) * 14
	fld var3
	fdiv var4 ;st(0) = 256/2 = 128; st(1) = 320/4; st(2) = cos(x + a)/sin(x-a) * 14
	fadd ;=208
	fsubr ; st(0) = (256/2 + 320/4) - (cos(x + a)/sin(x-a) * 14) = -221.143317
	fld var6
	fmul var4 ; st(0) = 56*2 = 112
	fldlg2 ;st(0) = lg2 st(1) = 56*2; st(2) = (256/2 + 320/4) - (cos(x + a)/sin(x-a) * 14)
	fld x
	fsub a ; st(0) = x-a = 1.5 st(1) = lg2 st(2) = 56*2; st(3) = (256/2 + 320/4) - (cos(x + a)/sin(x-a) * 14)
	fyl2x ; st(0) = lg2*log2(1.5)
	fmul
	fdiv
	fld var7
	fadd var4
	fmul
	fst y
exit:   
    mov ax,4c00h
    int 21h
end start