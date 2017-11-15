title homework2

;;;
;;; a menu: nput number, output linked info
;;;
;;; we assume info strs have same len,then we can calculate their address
;;;

data segment
	thirty  db 30
	msg0  db  0Dh,0Ah,"I like my PC-----------------------------------------",0Dh,0Ah,'$'
	msg1  db  0Dh,0Ah,"8088 programming is fun------------------------------",0Dh,0Ah,'$'
	msg2  db  0Dh,0Ah,"Time to buy more diskettes---------------------------",0Dh,0Ah,'$'
	msg3  db  0Dh,0Ah,"This program works-----------------------------------",0Dh,0Ah,'$'
	msg4  db  0Dh,0Ah,"Turn the printer-------------------------------------",0Dh,0Ah,'$'
	msg5  db  0Dh,0Ah,"I have more memory than you--------------------------",0Dh,0Ah,'$'
 	msg6  db  0Dh,0Ah,"The PSP can be useful--------------------------------",0Dh,0Ah,'$'
	msg7  db  0Dh,0Ah,"BASIC was easier than this---------------------------",0Dh,0Ah,'$'
	msg8  db  0Dh,0Ah,"DOS is indispensable---------------------------------",0Dh,0Ah,'$'
	msg9  db  0Dh,0Ah,"Last massage of the day------------------------------",0Dh,0Ah,'$'
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

    MOV  AH, 1 ;input into al
    INT  21H
    ; mov al,'3'

    sub al,'0'
    lea bx,msg1
    lea cx,msg0
    sub bx,cx
    mov ah,0
    mul bx
    lea dx,msg0 ; Get the message
    add dx,ax

    mov ah, 9  ; DOS write string
    int 21h   ; Display the message
        
    ;;;]

    ret
main endp
code ends
    end start