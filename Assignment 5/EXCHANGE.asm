.MODEL SMALL
.STACK 100H
.CODE
MAIN PROC
    MOV AX,1ABCH
    MOV BX,712AH
    XCHG AX,BX
    MOV AH,4CH
    INT 21H
    END MAIN



