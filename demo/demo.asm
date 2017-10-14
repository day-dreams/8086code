title helloworld

data segment
    source_buffer db 40 dup('a')

data ends

extra segment
    dest_buffer db 40 dup(?)
extra ends


code segment
main proc far
    assume      cs:code,ds:data,es:extra
start:
    push ds
    sub ax,ax
    push ax
    
    mov ax,data
    mov ds,ax

    mov ax,extra
    mov es,ax

    lea si,source_buffer
    lea di,dest_buffer
    cld
    mov cx,40
    rep movsb
    ret
main endp

code ends
    end start