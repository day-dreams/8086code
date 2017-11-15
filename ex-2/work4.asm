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
    add di,1
    mov ax,ds:[si]
    mov ds:[di],ax
    mov ax,ds:[si+2]
    mov ds:[di+2],ax
    

    shl dword ptr ds:[di],1
    jnc  nca
    add byte ptr ds:sec,1
nca:
    shl dword ptr ds:[di],1
    jnc  ncb
    shl byte ptr ds:sec,1
    add byte ptr ds:sec,1
ncb:
    ;;]

    ret
main endp
code ends
    end start