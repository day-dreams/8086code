title 8059a 级联实验

;;; TODO:这个程序的正确性未知,需要根据实验设备来决定要不要调用8259初始化子程序


data segment
    messageb db "M7",0Dh,0AH,"$"
    messagea db "S1",0Dh,0AH,"$"
data ends


;;;InterruptProgram_A segment contains interrupt program of IR7 in primary 8259, typcode 0Fh
InterruptProgram_A segment
    assume ds:data
    push ds
    mov ax,data
    mov ds,ax

    ;;;[
        
    lea dx,messagea
    mov ah,9
    int 21H

    ;显式发送EOI
    mov al,20H
    out 20H,al

    ;;;]

    pop ds
    iret
InterruptProgram_A ends


;;;InterruptProgram_B segment contains interrupt program of IR1 in slave 8259, typcode 31h
InterruptProgram_B segment
    assume ds:data
    push ds
    mov ax,data
    mov ds,ax

    ;;;[
        
    lea dx,messageb
    mov ah,9
    int 21H

    ;显式发送EOI
    mov al,20H
    out 10100000b,al

    ;;;]

    pop ds
    iret
InterruptProgram_B ends


code segment
main proc far
    assume ds:data,cs:code
start:
    push ds
    sub ax,ax
    push ax
    mov ax,data
    mov ds,ax
    mov ax,0
    mov es,ax

    ;;;[
        
    ; call init_8259

    ;set 0F interrupt
    mov ax,InterruptProgram_A      ;set interrupt table
    mov word ptr es:[0FH*4],0    ;modify offset addr
    mov word ptr es:[0FH*4+2],ax ;modify segment addr
    
    ;set 31 interrupt
    mov ax,InterruptProgram_B      ;set interrupt table
    mov word ptr es:[31H*4],0    ;modify offset addr
    mov word ptr es:[31H*4+2],ax ;modify segment addr

    ;test
    int 15
    int 31H


    ;;;]

    ret

main endp


;;; init_8259 init icw* of primary 8259a
init_8259 segment
                ;主片设置
    mov al,11H  ;icw1,边沿触发,使用从片
    out 20H,al
    mov al,01H  ;icw2,typecode 00001***H, typecode 00001111H for IR7
    out 21H,al
    mov al,00H  ;icw3,TODO:根据设备实际情况,决定是不是要自己设置主从8259a的连接情况
    out 21H,al
    mov al,01H  ;icw4,全嵌套,非自动中断
    out 21H,al

                ;从片设置
    mov al,11H  ;icw1,边沿触发,使用从片
    out 10100000b,al
    mov al,30H  ;icw2,typecode 00110***H,typecode 001100001H for IR1
    out 10100001b,al
    mov al,00H  ;icw3,TODO:根据设备实际情况,决定是不是要自己设置主从8259a的连接情况
    out 10100001b,al
    mov al,01H  ;icw4,全嵌套,非自动中断
    out 10100001b,al

    ret
init_8259 ends

code ends
    end start


