title homework1


data segment

data ends


stack segment stack ; a stackwith 1KB size
    dw 1024 dup('?')
stack ends


code segment

; proc main
main proc far
    assume cs:code,ss:stack
start:
    push ds
    mov ax,0
    push ax

    ;;;[

    mov ax,0    ;init

    mov ah,1    ;input a char[0,F]
    int 21H

    ; mov al,'3'

    cmp al,'0'  ;jump if <'0'
    jl ERROR_INPUT        
COND_1:
    cmp al,'9'  ;jump if >='9'
    jg COND_2   
    sub al,'0'
    jmp PRINT_AX
COND_2:
    cmp al,'F'  ;jump if >='F'
    jg COND_3  
    sub al,'A'
    add al,10d
    jmp PRINT_AX
COND_3:
    cmp al,'f'  
    jg ERROR_INPUT
    sub al,'a'
    add al,10d
    jmp PRINT_AX
    
PRINT_AX:
    mov ah,0
    push ax     ;print it in binary mode
    call print_binary_stack
    pop ax

ERROR_INPUT:

    ;;;]

    ret
main endp



; proc PRINT* print '\n' , then first data(16bits) in stack in binary mode,
; this will pop stack, and may modify registers.
print_binary_stack proc near

    mov dl,0Dh  ;print cr
    mov ah,02H
    int 21H

    mov dl,0Ah  ;print cf
    mov ah,02H
    int 21H


    mov bp,sp
    mov ax,ss:[bp+2]    ;NOTE:near调用，call只push了一个ip，占用2字节

    mov cx,17

PRINT_LOOP:;用于输出ax的循环
    rcl ax,1
    pushf  ;NOTE: store flag, because leftest bit of ax is in flag!
    push ax;store ax
    mov bx,1
    and bx,ax

    cmp bx,1;compare
    je CMP_CHAR_ONE
    mov dl,'0'
    jmp CMP_END
    CMP_CHAR_ONE:
    mov dl,'1'
    CMP_END:

    mov ah,02H
    int 21H

    pop ax;restore ax
    popf 

loop PRINT_LOOP

    ret

print_binary_stack endp

code ends
    end start