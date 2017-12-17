title myprint of interrupt way


data segment
    msg db "helloworld","\r\n","$"
data ends

myprint segment
    push ax

    mov ax,data
    mov ds,ax
    mov ax,offset msg
    mov di,ax
    mov ah,9H
    int 21H

    pop ax
    iret
myprint ends

stack segment stack
    space dw 1024(0)
stack ends


code segment
main proc far
    assume cs:code,ds:data,ss:stack
start:
    push dx
    mov ax,0
    push ax
    mov ax,data
    mov ds,ax

    ;;;[
        
    mov ax,0
    mov word ptr 0000H:[55H*4],0        
    mov word ptr 0000H:[55H*4+2],myprint
        
    int 55H

    ;;;]

    ret
main endp
code ends
    end start