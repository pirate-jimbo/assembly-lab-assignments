.MODEL SMALL
.STACK 100H
.DATA
MSG1 DB 0DH,0AH,'Enter the first Hex number(0000 - FFFF): $'
MSG2 DB 0DH,0AH,'Enter the second Hex number(0000 - FFFF): $'
MSG3 DB 0DH,0AH,'The sum of given Hex numbers in Hex form is: $'
MSG4 DB 0DH,0AH,'Illegal character.Please try again. $'
COUNT DB ?
VALUE DW ?
.CODE
MAIN PROC
MOV AX,@DATA ;initialize Data Segment
MOV DS,AX
JMP START_2 ;jump to label START_2
START_1:
MOV AH,9 ;String Output
LEA DX,MSG4
INT 21H
START_2:
MOV AH,9 ;String Output
LEA DX,MSG1
INT 21H
XOR BX,BX ;clear BX
MOV COUNT,30H ;initialize loop counter
START_3:
MOV AH,1 ;Single Key Input
INT 21H
CMP AL,0DH ;compare AL with CR
JNE SKIP_1 ;jump to label SKIP_1 if AL!=CR
CMP COUNT,30H ;compare COUNT with 0
JBE START_1 ;jump to label START_1 if COUNT<=0
JMP END_1 ;jump to label END
SKIP_1:
CMP AL,"A" ;compare AL with "A"
JB DECIMAL_1 ;jump to label DECIMAL_1 if AL<A
CMP AL,"F" ;compare AL with "F"
JA START_1 ;jump to label START_1 if AL>F
ADD AL,09H ;add 9 to AL
JMP OK_1 ;jump to label OK_1
DECIMAL_1:
CMP AL,30H ;compare AL with 0
JB START_1 ;jump to label START_1 if AL<0
CMP AL,39H ;compare AL with 9
JA START_1 ;jump to label START_1 if AL>9
OK_1:
INC COUNT ;increment the COUNT variable
AND AL,0FH ;convert the ascii into binary code
MOV CL,4 ;set CL=4
SHL AL,CL ;shift AL towards left by 4 positions
MOV CX,4 ;set CX=4
LOOP_1:
SHL AL,1 ;shift AL towards left by 1 position
RCL BX,1 ;rotate BX towards left by 1 position through carry
LOOP LOOP_1 ;jump to label LOOP_1 if CX!=0
CMP COUNT,34H ;compare COUNT with 4
JE END_1 ;jump to label END_1 if COUNT=4
JMP START_3 ;jump to label START_3
END_1:
MOV VALUE,BX ;set VALUE=BX
MOV AH,9 ;String Output
LEA DX,MSG2
INT 21H
XOR BX,BX ;clear BX
MOV COUNT,30H ;initialize loop counter
START_4:
MOV AH,1 ;Single Key Input
INT 21H
CMP AL,0DH ;compare AL with CR
JNE SKIP_2 ;jump to label SKIP_2 if AL!=CR
CMP COUNT,30H ;compare COUNT with 0
JBE START_1 ;jump to label START_1 if COUNT<=0
JMP END_2 ;jump to label END_2
SKIP_2:
CMP AL,"A" ;compare AL with "A"
JB DECIMAL_2 ;jump to label DECIMAL_2 if AL<A
CMP AL,"F" ;compare AL with "F"
JA JUMP ;jump to label JUMP if AL>F
ADD AL,09H ;add 9 to AL
JMP OK_2 ;jump to label OK_2
DECIMAL_2:
CMP AL,30H ;compare AL with 0
JB JUMP ;jump to label JUMP if AL<0
CMP AL,39H ;compare AL with 9
JA JUMP ;jump to label JUMP if AL>9
JMP OK_2 ;jump to label OK_2
JUMP:
JMP START_1 ;jump to label START_1
OK_2:
INC COUNT ;increment the COUNT variable
AND AL,0FH ;convert the ascii into binary code
MOV CL,4 ;set CL=4
SHL AL,CL ;shift AL towards left by 4 positions
MOV CX,4 ;set CX=4
LOOP_2:
SHL AL,1 ;shift AL towards left by 1 position
RCL BX,1 ;rotate BX towards left by 1 position through carry
LOOP LOOP_2 ;jump to label LOOP_2 if CX!=0
CMP COUNT,34H ;compare COUNT with 4
JE END_2 ;jump to label END_2 if COUNT=4
JMP START_4 ;jump to label START_4
END_2: ;String Output
MOV AH,9
LEA DX,MSG3
INT 21H
ADD BX,VALUE ;add BX and VALUE
JNC SKIP ;jump to label SKIP if CF=1
MOV AH,2 ;Single Key Output
MOV DL,31H ;set DL=1
INT 21H
SKIP:
MOV COUNT,30H ;set COUNT=0
LOOP_3:
XOR DL,DL ;clear DL
MOV CX,4 ;set CX=4
LOOP_4:
SHL BX,1 ;shift BX towards left by 1 position
RCL DL,1 ;rotate DL towards left by 1 position through carry
LOOP LOOP_4 ;jump to label LOOP_4 if CX!=0
MOV AH,2 ;Single Key Output
CMP DL,9 ;compare DL with 9
JBE NUMERIC_DIGIT ;jump to label NUMERIC_DIGIT if DL<=9
SUB DL,9 ;convert it to number i.e. 1,2,3,4,5,6
OR DL,40H ;convert number to letter i.e. A,B...F
JMP DISPLAY ;jump to label DISPLAY
NUMERIC_DIGIT:
OR DL,30H ;convert decimal to ascii code
DISPLAY:
INT 21H ;print the character
INC COUNT ;increment COUNT variable
CMP COUNT,34H ;compare COUNT with 4
JNE LOOP_3 ;jump to label LOOP_3 if COUNT!=4
END:
MOV AH,4CH ;Return 0
INT 21H
MAIN ENDP
END MAIN


