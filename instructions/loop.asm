title Test for Loop


data segment
    message db "hello world",0DH,0AH,"$"
data ends

code segment
main proc far:
    assume cs:code
start:
    push ds
    mov ax,0
    push ax
    mov ax,data
    mov ds,ax
    ;;;[

    mov cx,1
print:
    lea dx,message
    mov ah,9
    int 21H

    loop print


    ;;;]

    ret
code ends
    end start