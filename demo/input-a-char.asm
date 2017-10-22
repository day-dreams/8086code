
DATA SEGMENT
     BUFFER  DB 80 DUP(?)
DATA ENDS
;-----------------------
CODE SEGMENT
    ASSUME CS:CODE, DS:DATA
START:
    MOV  AX,  DATA
    MOV  DS,  AX
;-----------------------
    MOV  BX, OFFSET BUFFER
    MOV  AH, 1
    INT  21H
    CMP  AL, ' '  ;和空格相比较.
    JNZ  EXIT     ;不相等就退出.
NEXT:
    MOV  AH, 1
    INT  21H
    CMP  AL, ' '  ;和空格相比较.
    JZ   OUT_ALL  ;相等就输出全部.
    MOV  [BX], AL ;否则就保存.
    INC  BX
    JMP NEXT
;-----------------------
OUT_ALL:
    MOV  DL, 13   ;回车.
    MOV  AH, 2
    INT  21H
    MOV  DL, 10   ;换行.
    MOV  AH, 2
    INT  21H
;-----------------------
    MOV  BYTE PTR [BX], '$' ;在末尾添上$
    MOV  AH, 9              ;输出字符串.
    MOV  DX, OFFSET BUFFER
    INT  21H
;-----------------------
EXIT:
    MOV  AX, 4C00H
    INT  21H
CODE ENDS
    END START 