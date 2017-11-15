title work2

;;; ! not finish yet..
;;;
;;; load a word from memory, by seg:offset
;;;

data segment
    memory dw 1024 dup(0)
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

    mov di,100H
    mov word ptr ds:[di],f200H
    add di,2
    mov word ptr ds:[di],3000H

    mov si,ds:[100H]
    push ds
    mov ds,ds:[102H]
    pop ds

    mov ax,ds:[si]
    ;;;]

    ret
main endp
code ends
    end start