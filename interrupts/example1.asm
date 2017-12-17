;reference http://blog.csdn.net/whoamiyang/article/details/53493051
;
;
;listen to input,if '=',call interrupt;else if '-',exit;else do nothing.
;

data segment
    message db 'lets go to moon!', 0Dh, 0Ah, '$'
data ends


InterruptProgram segment
    assume ds:data
    push ds
    mov ax,data
    mov ds,ax

    lea dx,message
    mov ah,9
    int 21H

    pop ds
    iret
InterruptProgram ends


code segment
main proc far
    assume cs:code,ds:data
start: 
    push ds
    sub ax,ax
    push ax
    mov ax,data
    mov ds,ax
    mov ax,0
    mov es,ax

    ;;;[

    mov ax,InterruptProgram     ;set interrupt table
    mov word ptr es:[30*4],0    ;modify offset addr
    mov word ptr es:[30*4+2],ax ;modify segment addr

    
    BEGIN:
        mov ah,1                ;input a char
        int 21H

        cmp al,'='              ;compare
        je CALL_INT
        cmp al,'-'
        je END
        jmp BEGIN

        CALL_INT:
            int 30                      ;call my interrupt
            jmp BEGIN

    END:
    
    ;;;]

    ret
main endp
code ends
    end start