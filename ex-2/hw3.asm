title recursive_factorial


data segment
    result dw,?
data ends


stack segment stack
    dw 1024 dup(0)
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


    ;;;[]

    mov  bx, 5
    push bx
    call fact
    pop  bx


    ;;;]

    ret

main endp


; proc fact is jiecheng
fact   proc  near
       push  ax
       push  bp
       mov   bp, sp
       mov   ax, [bp+6]
       cmp   ax, 0
       jne   fact1
       inc   ax
       jmp   exit
fact1: dec   ax
       push  ax
       call  fact
       pop   ax
       mul   word ptr[bp+6]
exit:  mov   [bp+6], ax
       pop   bp
       pop   ax
       ret   
fact   endp

code ends
    end start