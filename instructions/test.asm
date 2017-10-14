title TEST_FOR_INSTRUCTIONS

; datas
data segment

data ends


; stack
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
main  proc far

;setting cs,ds,ss,es
    assume cs:code,ds:data,ss:stack,es:extra

;start of proc
start:
    ; setting retrun address
    push ds
    mov ax,0
    push ax

    ; test 1, mov 5678H to ds:0
    mov ds:0,5678H

    ; test 2, push 1234 from ax and pop it to bx
    mov ax,1234H
    push ax
    pop bx

    ; test 3, store 5678H to ds:0, then add it by one
    mov ds:0,5678H
    mov si,0
    lodsw 
    add ax,1
    mov ds:0,ax

    ; test 4, exchange ax and bx
    mov ax,1234H
    mov bx,5678H
    xchg ax,bx

    ; test 5, add,adc(带进位加),inc
    stc             ;set carry-flag=1
    mov ax,0007H
    mov bx,0008H
    adc ax,bx
    inc ax

    ; return
    ret

; declare ending of proc
main endp

; declare ending of code segment
code ends

    end start