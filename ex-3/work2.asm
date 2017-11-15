title homework2

;;;
;;; a menu: nput number, output linked info
;;;
;;; we assume info strs have same len,then we can calculate their address
;;;

data segment
 msg1  db 0Dh,0AH, "January  ",0Dh,0AH,"$"
 msg2  db 0Dh,0AH, "February ",0Dh,0AH,"$"
 msg3  db 0Dh,0AH, "March    ",0Dh,0AH,"$"
 msg4  db 0Dh,0AH, "April    ",0Dh,0AH,"$"
 msg5  db 0Dh,0AH, "May      ",0Dh,0AH,"$"
 msg6  db 0Dh,0AH, "June     ",0Dh,0AH,"$"
 msg7  db 0Dh,0AH, "July     ",0Dh,0AH,"$"
 msg8  db 0Dh,0AH, "Aguest   ",0Dh,0AH,"$"
 msg9  db 0Dh,0AH, "September" ,0Dh,0AH,"$"
msg10  db 0Dh,0AH, "October  ",0Dh,0AH,"$"
msg11  db 0Dh,0AH, "November ",0Dh,0AH,"$"
msg12  db 0Dh,0AH, "December ",0Dh,0AH,"$"
errmsg db "error!!!  Invalid parameter!!------------------------",0Dh,0Ah,'$'
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

BEGIN:
    mov  AH, 1 ;input into al
    int  21H
    ; mov al,'A'

    cmp al,'9'
    jg HEX
    sub al,'1'
    jmp HEX_END
    HEX:
        sub al,'A'
        add al,9
    HEX_END:

    lea bx,msg2
    lea cx,msg1
    sub bx,cx
    mov ah,0
    mul bx
    lea dx,msg1 ; Get the message
    add dx,ax

    mov ah, 9  ; DOS write string
    int 21h   ; Display the message

    jmp BEGIN  
    ;;;]

    ret
main endp
code ends
    end start