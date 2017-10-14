title TEST_FOR_INSTRUCTIONS

; datas
data segment
    buffer DB 10 dup('a')
data ends


; ; stack
stack segment

stack ends


; extra
extra segment

extra ends


; code
code segment

; declare a procedure, 
; far:defferenct segment
; near(default):smae segment
main proc far

;setting cs,ds,ss,es
    assume cs:code,ds:data,es:extra

;start of proc
start:
    ; setting retrun address
    push ds
    mov ax,0
    push ax

    ; you must set ds,es,ss before use them, or you may modify something terrible!!!
    mov ax,data
    mov ds,ax
    mov ax,stack
    mov ss,ax
    mov ax,extra
    mov es,ax

    ; test 0, flag settings and transffer
    ; clc ;clear carry,进位位置0
    ; stc ;set carry,进位位置1
    ; cmc ;complement carry,进位位求反
    ; cld ;clear direction 
    ; std ;set direction
    ; cli ;clear interrupt
    ; sti ;set interrupt
    ; lahf;load AH from 8 lower bits of flags register,(AH) <- (FLAGS.lower)
    ; sahf;store AH register into lower 8 bits of flags register,(FLAGS.lower) <- (AH)
    ; pushf;set falgs register in the stack
    ; popf;get flags register from the stack


    ; test 1, mov 5678H to ds:0
    mov ax,5678H
    mov ds:0000H,ax

    ; test 2, push 1234 from ax and pop it to bx
    ; mov ax,1234H
    ; push ax
    ; pop bx

    ; test 3, store 5678H to ds:0, then add it by one
    ; mov ds:0,5678H
    ; mov si,0
    ; lodsw 
    ; add ax,1
    ; mov ds:0,ax

    ; test 4, exchange ax and bx
    ; mov ax,1234H
    ; mov bx,5678H
    ; xchg ax,bx

    ; test 5, add,adc(带进位加),inc
    ; stc             ;set carry-flag=1
    ; mov ax,0007H
    ; mov bx,0008H
    ; adc ax,bx
    ; inc ax

    ; test 6, sub,sbb(带借位减),des
    ; mov ax,0007H
    ; mov bx,0008H
    ; sub ax,bx
    ; mov ax,0007H
    ; mov bx,0008H
    ; sbb ax,bx


    ; return
    ret

; declare ending of proc
main endp

; declare ending of code segment
code ends

    end start