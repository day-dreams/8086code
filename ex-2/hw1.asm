title homework1

;;;
;;; input 4 char(hex number),output it(binary number)
;;;

data segment
    num dw 0
data ends


stack segment stack ; a stackwith 1KB size
    dw 1024 dup('?')
stack ends


code segment

; proc main
main proc far
    assume cs:code,ss:stack,ds:data
start:
    push ds
    mov ax,0
    push ax

    mov ax,data
    mov ds,ax

    ;;;[

    mov ax,0    ;init

    mov cx,4

loop_input:
    mov ah,1    ;input a char[0,F] into al
    int 21H

    mov bl,al
    push cx
    call asii2hex
    pop cx
    mov ax,16
    mul num
    mov ds:num,ax
    add word ptr ds:num,bl
loop loop_input

    ; mov ds:num,8888H
    push ds:num
    call print_binary_stack
    pop ds:num
    ;;;]

    ret
main endp


; proc asii2hex
; parameter is at bl, return value is at bl too.
asii2hex proc near

    mov al,bl
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
    
ERROR_INPUT:
    mov al,0
PRINT_AX:
    mov bl,al

    ret

asii2hex endp

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

    ; mov bx,cx
    rcl ax,1    ;预设好循环移位

    mov cx,16

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