title homework1

;data
data segment
    pa dw ?
    nn db 16 dup(?)
    co dd ?
    le equ $-pa
    _test db 'a'
    _le equ $-pa
    
data ends


extra segment

extra ends


code segment
main proc far
    assume ds:data,es:extra,cs:code
start:
    push ds
    mov ax,0
    push ax

    ;;insert code[ 

    mov ax,le
    mov bx,_le


    ;;insert code]


    ret

main endp

code ends
    end start