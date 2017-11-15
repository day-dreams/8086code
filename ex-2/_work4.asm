title work4

;;;
;;; shift left 4 bits of fir, and store it in sec(with carry bits)
;;;

data segment
    fir dd 11000000000000000000000000000001b
    sec db 5 dup(0)
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

    ;;;[

    mov si,offset fir
    mov di,offset sec

    mov ax,0
    mov al,ds:[di]
    mov cl,2
    shl ax,cl

    mov word ptr ds:[si],ax

    ;;]

    ret
main endp
code ends
    end start