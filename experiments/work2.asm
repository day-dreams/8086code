title homework2

;data
data segment
    str1 db "++helloworld",'$'
    len_str1 equ $-str1
    str2 db "++helloworld",'$'
    len_str2 equ $-str2
    equal_message db 'MATCH', 0Dh, 0Ah, '$'
    nequal_message db 'NO MATCH', 0Dh, 0Ah, '$'

data ends


;stack
stack segment

stack ends


;code
code segment

main proc far
    assume cs:code,ds:data,es:data
start:

    push ds
    sub ax,ax
    push ax

    mov ax,data
    mov ds,ax
    mov ax,data
    mov es,ax    
   
    ;;;my code begins here.
    
    cld     ;set direction of address increase
    ;设置源地址和目标地址(偏移地址)
    lea si,str1    
    lea di,str2

    ;循环比较
    mov cx,len_str1     
    repe cmpsb 


    ;分析比较结果
    je EQUAL
NEQUAL:     ;zf=0
    lea dx,nequal_message
    mov ah,09H
    int 21H
    jmp EXIT
EQUAL:      ;zf=1
    lea dx,equal_message
    mov ah,09H
    int 21H
EXIT:

    ;;;my code ends here.


    ret

main endp
code ends
    end start