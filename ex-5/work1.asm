title  basic io for 8255

;;;
;;; 监听A口输入,把数据输出到B口
;;;
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
        mov al,10010000b
        mov dx,CONADDR
        out dx,al

    LISTEN:     ;listen input from keys,and output it to lights
        mov dx,PAADDR   ;input
        in  al,dx

        mov dx,PBADDR   ;output
        out dx,al

        jmp LISTEN      ;loop
    ;;;]
    ret
main endp
code ends
    end start