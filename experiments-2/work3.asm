title work3

;;;
;;;  shift left 4 bits of dx:bx(dw)
;;;

data segment
    num dd 00000001H
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

    mov ds,dx
    mov di,bx

    shl dword ptr ds:[di],1
    shl dword ptr ds:[di],1
    shl dword ptr ds:[di],1
    shl dword ptr ds:[di],1

    ;;;]

    ret
main endp
code ends
    end start