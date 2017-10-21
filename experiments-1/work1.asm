title work1_of_5

;;; cx*10=cx<<3+cx<<1

code segment
main proc far
    assume cs:code
start:
    push ds
    sub ax,ax
    push ax

    ;;;
    mov cx,8

    mov ax,cx
    mov bx,cx

    mov cl,3
    shl ax,cl
    mov cl,1
    shl bx,cl
    add ax,bx
    mov cx,ax

    ;;;

    ret

main endp

code ends
    end start