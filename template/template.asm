title helloworld

data segment
    source_buffer db 40 dup('a')

data ends

extra segment
    dest_buffer db 40 dup(?)
extra ends


code segment
main proc far;以proc声明,所以要准备返回地址
    assume      cs:code,ds:data,es:extra
start:;声明整个程序的开始
    ; 设置返回堆栈
    push ds
    sub ax,ax
    push ax

    ;设置ds，es
    mov ax,data
    mov ds,ax
    mov ax,extra
    mov es,ax

    ; 在这里插入你的代码

    mov ax,1010H
    mov bx,0101H

    ; 在这里插入你的代码


    ; 返回
    ret
main endp

code ends
    end start