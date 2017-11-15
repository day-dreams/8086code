title LOOK UP MAX & MIN

;;;
;;; 查找数组最大最小值
;;;



data segment
    array db 3,1,2,4,5,9,5,34H,11111111b
    array_len equ $-array
data ends


stack segment stack
    space dw 1024 dup(0)

stack ends



code segment 

main proc far
    assume cs:code,ds:data,ss:stack
start:
    push ds
    mov ax,0
    push ax

    mov ax,data
    mov ds,ax
    
    ;;;[

    lea si,array
    mov cx,array_len    
    call find_max_min

    ;;; Dont Suggest!
    ; mov si,3000H
    ; mov cx,8H
    ; call find_max_min

    ;;;]


    ret
main endp


; FIND_MAX_MIN proc find max and min num in the array( [si,si+cx) )
find_max_min proc near
    push si
    push cx
    push bx

    mov ah,ds:[si];max
    mov bh,ds:[si];min

    _LOOP_BEGIN:
        cmp cx,0
        je _LOOP_EXIT
        sub cx,1

        mov al,ds:[si]

        mov dl,al
        sub dl,ah
        jc G_IF_END
        mov ah,al
        G_IF_END:
    
        mov dl,al
        sub dl,bh
        jnc L_IF_END
        mov bh,al
        L_IF_END:

        add si,1
        jmp _LOOP_BEGIN
    _LOOP_EXIT:

    ;push max
    mov al,ah
    mov ah,0
    push ax
    ;push min
    mov bl,bh
    mov bh,0
    push bx
    ;print min
    call print
    pop bx
    ;print max
    call print
    pop bx

    pop bx
    pop cx
    pop si
    ret
find_max_min endp


; PRINT proc get word in the stack, and print it to screen in hex
print proc near
    ;get the parameter
    mov bp,sp
    add bp,2
    mov ax,ss:[bp]    

    push ax

    ;loop to print the num in hex
    mov cx,4
    LOOP_BEGIN:
        cmp cx,0
        je LOOP_EXIT
        sub cx,1
        
        ; get highest 4 bits to bh
        mov bh,11110000b
        and bh,ah
        push cx
        mov cl,4
        shr bh,cl

        push ax

        ;format bh to dl, in ascii
        cmp bh,9
        jg BIG_THAN_9
        mov dl,'0'
        add dl,bh    
        jmp PRINT_DL
        BIG_THAN_9:
        mov dl,'A'
        sub bh,10
        add dl,bh

        ;print dl
        PRINT_DL:
        mov ah,02H
        int 21H

        ;shifr 4 bits left ax 
        pop ax
        mov cl,4
        shl ax,cl
        pop cx
        jmp LOOP_BEGIN
    LOOP_EXIT:

    ;print a 'cr','cf'
    mov dl,0Dh  ;print cr
    mov ah,02H
    int 21H
    mov dl,0Ah  ;print cf
    mov ah,02H
    int 21H
    
    pop ax

    ret
print endp

code ends
    end start