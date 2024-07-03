.MODEL SMALL
.STACK 100H
.DATA
MSG1 DB 'Enter a string of decimal digits: $'
MSG2 DB 0DH,0AH,'The sum of the string of decimal digits in Hex is: $'
MSG3 DB 0DH,0AH,'Illegal character.Please try again: $'
VALUE DW ?
.CODE
MAIN PROC
MOV AX,@DATA ;initialize Data Segment
MOV DS,AX
MOV AH,9 ;String Output
LEA DX,MSG1
INT 21H
JMP START_2 ;jump to label START_2
START_1:
MOV AH,9 ;String Output
LEA DX,MSG3
INT 21H
XOR BX,BX ;clear BX
XOR CX,CX ;clear CX
START_2:
MOV AH,1 ;Single Key Input
INT 21H
INC CX ;increment CX
CMP AL,0DH ;compare AL with CR
JNE SKIP ;jump to label SKIP if AL!=CR
CMP CX,1 ;compare CX with 1
JB START_1 ;jump to label START_1 if CX<1
JMP END_INPUT ;jump to label END_INPUT
SKIP:
CMP AL,30H ;compare AL with 0
JB START_1 ;jump to label START_1 of AL<0
CMP AL,39H ;compare AL with 9
JA START_1 ;jump to label START_1 if AL>9
AND AL,0FH ;convert the ascii to decimal code
XOR AH,AH ;clear AH
ADD BX,AX ;add BX and AX
JMP START_2 ;jump to label START_2
END_INPUT:
MOV AH,9 ;String Output
LEA DX,MSG2
INT 21H
MOV CX,4 ;initialize loop counter
MOV AH,2 ;set output function
LOOP_1:
XOR DX,DX ;clear DX
LOOP_2:
SHL BX,1 ;shift BX towards left by 1 position
RCL DL,1 ;rotate DL towards left by 1 position
INC DH ;increment DH
CMP DH,4 ;compare DH with 4
JNE LOOP_2 ;jump to label LOOP_2 if DH!=4
CMP DL,9 ;compare DL with 9
JBE NUMERIC_DIGIT ;jump to label NUMERIC_DIGIT if DL<=9
SUB DL,9 ;convert it to number i.e. 1,2,3,4,5,6
OR DL,40H ;convert number to letter i.e. A,B...F
JMP DISPLAY ;jump to label DISPLAY
NUMERIC_DIGIT:
OR DL,30H ;convert decimal to ascii code 
DISPLAY:
INT 21H ;print the character
LOOP LOOP_1 ;jump to label LOOP_1 if CX!=0
MOV AH,4CH ;Return 0
INT 21H
MAIN ENDP
END MAIN



