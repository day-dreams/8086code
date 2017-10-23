title work1

;;;
;;; diferenct ways to store a word into memory
;;;

data segment
    buffer dw 5 dup(0)
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


    ;1st
    lea di,buffer
    mov ds:[di],1234H



    ;;;]


    ret
main endp
code ends
    end start