title template for stack

;;; 1.系统预设了一个stack，但是不知道其大小
;;;
;;; 2.如果要自己定义栈，可以显示赋值ss,sp;也可以按下面代码里的方式(两个'stack')
;;;
;;; 3.栈里面不可能是空的，还有其他数据。所以进入main后，发现stack的可用空间变小了(观察到64个1少了几个！)
;;;


data segment

data ends


stack segment stack ;do not forget the second 'stack' !
	db 64 dup(1)
stack ends


code segment

main proc far
	assume ds:data,cs:code,ss:stack
start:
	push ds
	mov ax,0
	push ax

	;;;[insert your code here
	
	mov ax,5678H
	push ax
	pop ax

	;;;insert your code here]

	ret

main endp
code ends
	end start