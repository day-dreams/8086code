title water light for 8255


;;;
;;; A,B口均作为输出,控制两组流水灯
;;;


PAADDR equ 0fff0H
PBADDR equ 0fff2H
PCADDR equ 0fff4H
CONADDR equ 0fff6H


code segment
main proc far
    assume cs:code
start:
    push ds
    mov ax,0
    push ax

    ;;;[
        INIT:       ;initialize 8255
        mov al,10000000b
        mov dx,CONADDR
        out dx,al


    mov bx,0180H

    WATER:      
   
        call delay

        mov dx,PAADDR   ;output pa
        mov al,bh
        out dx,al
        rol bh,1

        mov dx,PBADDR   ;putput pb
        mov al,bl
        out dx,al
        ror bl,1

        jmp WATER

    ;;;]

    ret
main endp


;;; delay will cause delay for a short time 
delay proc

    push cx

    mov cx,0ffffH
    _delay:
        nop
        loop _delay

    pop cx
    ret
delay endp

code ends
    end start