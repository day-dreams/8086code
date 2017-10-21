title work5_of_5

;;; sort the array


data segment
    array db          10, 59, 6
    array_0 db        29, 54, 28, 9, 66, 24, 56, 63
    array_1 db        68, 30, 82, 79, 58, 96, 46, 45, 35, 74
    array_2 db        3, 64, 63, 22, 68, 82, 32, 76, 37, 0, 44
    array_3 db        54, 16, 84, 41, 9, 91, 53, 82, 57, 11, 11 
    array_4 db        1, 46, 62, 58, 66, 2, 58, 21, 67, 15, 98
    array_5 db        36, 30, 84, 62, 54, 46, 67, 93, 4, 70, 63
    array_6 db        47, 16, 37, 61, 45, 92, 79, 4, 75, 4, 55
    array_7 db        62, 66, 78, 56, 63, 77, 99, 54, 35, 85, 84
    array_8 db        62, 85, 48, 48, 3, 54, 38, 58, 40, 32, 79, 59, 29
    array_len equ $-array
data ends

extra segment
extra ends


code segment
main proc far;以proc声明,所以要准备返回地址
    assume      cs:code,ds:data,es:extra
start:;声明整个程序的开始
    ; 设置返回堆栈
    push ds
    sub ax,ax
    push ax

    ;设置ds，es
    mov ax,data
    mov ds,ax

    ; 在这里插入代码
    lea si,array



    mov cx,array_len-1          ;i(array_len)次外层循环
    outter_loop_begin:          ;cx=array_len-1,array_len-2,..,0
        cmp cx,0
        jbe outter_loop_exit    ;cx<=0则结束外层循环
                                ;否则执行内曾循环

        mov dx,0                            ;j(dx)次内层循环
        inner_loop_begin:                   ;dx=0,1,2,..,cx-1
            cmp dx,cx
            jae inner_loop_exit             ;dx>=cx时结束内曾循环
                                            ;否则进入内曾循环，进行比较交换
            mov si,dx
            mov di,dx
            add di,1
            mov al,ds:(array+[si])
            mov bl,ds:(array+[di])
            cmp al,bl
            ja swap                             ;array[di]>=array[di+1],不需要改变位置
            jmp inner_loop_end
            swap:
                mov ds:(array+[si]),bl
                mov ds:(array+[di]),al
        inner_loop_end:                     ;dx++,进行下一次内曾循环
            add dx,1
            jmp inner_loop_begin
        inner_loop_exit:

    outter_loop_end:            ;cx--
        sub cx,1
        jmp outter_loop_begin   ;进行下一次外层循环
    outter_loop_exit:
 
    


    ; 在这里插入代码


    ; 返回
    ret
main endp

code ends
    end start