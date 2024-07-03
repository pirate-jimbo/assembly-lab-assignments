.MODEL SMALL
.STACK 100H
.DATA
MSG1 DB "Enter a character: $"
MSG2 DB 0DH,0AH,"ASCII code of the character in binary is: $"
MSG3 DB 0DH,0AH,"Number of 1 bit in ASCII code is: $"
.CODE
MAIN PROC
MOV AX,@DATA ;Initialize Data Segment
MOV DS,AX
MOV AH,9 ;String Output
LEA DX,MSG1
INT 21H
MOV AH,1 ;Single Key Input
INT 21H
MOV BL,AL
MOV AH,9 ;String Output
LEA DX,MSG2
INT 21H
XOR BH,BH ;BH is counter for 1
MOV CX,8 ;CX Loop counter
MOV AH,2 ;Single Key Output
OUTPUT:
SHL BL,1
JNC ZERO
INC BH
MOV DL,31H
JMP DISPLAY
ZERO:
MOV DL,30H
DISPLAY:
INT 21H
LOOP OUTPUT
MOV AH,9 ;String Output
LEA DX,MSG3
INT 21H
OR BH,30H
MOV AH,2 ;Single Key Output
MOV DL,BH
INT 21H
MOV AH,4CH ;Return 0
INT 21H
MAIN ENDP
END MAIN



