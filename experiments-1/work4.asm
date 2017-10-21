title work4_of_5

;;; 找数组中正数，负数，0的个数


data segment
    array1  db -1,-2,3,0,4,0,-5,0,0,0,-6,0,7,-8,9,0
    array1_len equ $-array1
    positive db 0
    negative db 0
    zero db 0
data ends


code segment
main proc far
    assume  cs:code,ds:data
start:

    push ds
    mov ax,0
    push ax

    mov ax,data
    mov ds,ax

    ;;; begin
    mov di,0
    mov cx,array1_len
loop_begin:
    mov ah,ds:[array1+di]
    cmp ah,0
    jg _POSI            ;注意这里是有符号数，不要使用ja，jb！！！
    je _ZERO
    jl _NEGE
    _POSI:
        mov ah,ds:positive
        add ah,1
        mov ds:positive,ah
        jmp EXIS
    _NEGE:
        mov ah,ds:negative
        add ah,1
        mov ds:negative,ah
        jmp EXIS
    _ZERO:
        mov ah,ds:zero
        add ah,1
        mov ds:zero,ah
        jmp EXIS
    EXIS:
        add di,1
    
loop loop_begin

    ;;; end

    ret



main endp
code ends   
    end start