 .8086
 .MODEL TINY

 .STACK 0200

 .DATA

message db 'Hello world!', 0Dh, 0Ah, '$'

 .CODE

Start:
 mov ax,DGROUP ; fix DS so it points to DGROUP
 mov ds,ax     ; :
 mov dx,ss     ; adjust SS:SP so SS is within DGROUP

 sub dx,ax     ;
 shl dx,1
 shl dx,1
 shl dx,1
 shl dx,1
 cli
 mov ss,ax
 add sp,dx
 sti
 lea dx, message ; Get the message
 mov ah, 9  ; DOS write string
 int 21h   ; Display the message

 mov ax, 4C00h  ; Exit with return code '00'
 int 21h

END Start