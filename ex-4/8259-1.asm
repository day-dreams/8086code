title 8059a 单中断实验

;;; TODO:这个程序的正确性未知,需要根据实验设备来决定要不要调用8259初始化子程序


TYPECODE equ 0FH    ;IR7的中断类型码
CHEAPADD equ 20H    ;8259a地址

data segment
    message db "7",0Dh,0AH,"$"
data ends


InterruptProgram segment
    assume ds:data
    push ds
    mov ax,data
    mov ds,ax

    ;;;[
        
    ; call init_8259

    lea dx,message
    mov ah,9
    int 21H

    ;显式发送EOI
    mov al,20H
    out CHEAPADD,al

    ;;;]

    pop ds
    iret
InterruptProgram ends


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
        
    mov ax,InterruptProgram      ;set interrupt table
    mov word ptr es:[TYPECODE*4],0    ;modify offset addr
    mov word ptr es:[TYPECODE*4+2],ax ;modify segment addr
    
    int TYPECODE

    ;;;]

    ret

main endp


;;; init_8259 init icw* of primary 8259a
init_8259 segment 
    mov al,13H  ;icw1,边沿触发,无任何从片级联
    out 20H,al
    mov al,01H  ;icw2,typecode 00001***H, typecode 00001111H for IR7
    out 21H,al
    mov al,01H  ;icw4,全嵌套,非自动中断(需要自己发送EOI)
    out 21H,al

    ret
init_8259 ends

code ends
    end start


