title work3_of_5

;;; 查找数组最大值，并存在后面一个单元里

data segment
    buffer db 1,4,3,2,7,2
    buffer_len equ $-buffer
    max    db ?
data ends


code segment
main proc far
    assume cs:code,ds:data
start:
    push ds
    mov ax,0
    push ax

    mov ax,data
    mov ds,ax

    ;;;

    mov al,ds:buffer    ;init al(max value) with buffer[0]
    mov cx,buffer_len
    mov di,0

loop_begin:
    cmp ds:(buffer+[di]),al
    ja  ABOVE
    NABOV: ;do nothing
        jmp EXIT
    ABOVE: ;update max value in ax
        mov al,ds:(buffer+[di])
    EXIT:  ;update index
        add di,1

loop loop_begin

    mov ds:max,al      ;store max value to max(in data segment)

    ;;;
    ret
main endp
code ends
    end start