title devide scores to two group

;;;
;;; 将成绩分为不及格和及格两组,使用快速排序中的pivot机制,pivot取为60
;;; 


data segment
    scores db 12,45,96,56,65
    scores_len equ $-scores
    border db 0
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


    lea ax,scores
    push ax
    mov ax,scores_len
    push ax

    call devide

    pop ax
    pop ax

    ;;;]

    ret
main endp

devide proc near
    mov bp,sp
    mov ax,ss:[bp+2]    ;;len of scores
    mov bx,ss:[bp+4]    ;;address of scores

    mov di,bx
    mov si,bx
    add si,ax
    sub si,1

    ;;while loop
    loop_begin:
        cmp di,si
        je loop_exit    ;begin == end

        ;;inner while loop
        a_loop_begin:
            cmp byte ptr ds:[di],60
            jg a_loop_exit
            add di,1
            jmp a_loop_begin
        a_loop_exit:

        cmp di,si
        jnl loop_exit    ;begin == end


        ;swap being,end
        mov al,ds:[di]
        mov bl,ds:[si]
        mov ds:[di],bl
        mov ds:[si],al

        cmp di,si
        jnl loop_exit    ;begin == end


        ;;inner while loop
        b_loop_begin:
            cmp byte ptr ds:[si],60
            jl b_loop_exit
            sub si,1
            jmp b_loop_begin
        b_loop_exit:

        jmp loop_begin
    loop_exit:

    ; mov ax,offset border
    ; mov di,ax
    ; mov bx,di
    ; sub bx,1
    ; mov ds:[di],bx

    ret
devide endp
code ends
    end start
