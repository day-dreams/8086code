title work2_of_5

;;; 测试BL的bit0,bit3是否同时为1。是则bl:=00H,否则al:=01H
;;; ((bl&00001001b)==00001001b)?(bl:=00h):(al:=01h)


data segment

data ends



code segment

main proc far
    assume cs:code,ds:data
start:

    push ds
    mov ax,0
    push ax

    ;;;

    mov bl,00001000b      ;modify this to test

    mov al,00001001b
    and al,bl
    cmp al,00001001b

    je BOTH1            ;do not miss the jump order!
NBOTH:
    mov al,01H
    jmp EXIT
BOTH1:
    mov bl,00H
 EXIT:

    ;;;

    ret


main endp
code ends
    end start