.MODEL SMALL
.STACK 100H
.DATA
 MSG1 DB 0DH,'Enter an Algebraic Expression : ',0DH,0AH,'$'
 MSG2 DB 0DH,0AH,'Expression is Correct.$'
 MSG3 DB 0DH,0AH,'Too many Left Brackets.$'
 MSG4 DB 0DH,0AH,'Too many Right Brackets.$'
 MSG5 DB 0DH,0AH,'Bracket Mismatch. Begin Again.$'
 MSG6 DB 0DH,0AH,'Type Y if you want to Continue : $'

.CODE
 MAIN PROC
 MOV AX,@DATA ;initialize DS
 MOV DS,AX
 START:
 MOV AH,9 ;String Output
 LEA DX,MSG1
 INT 21H
 XOR CX,CX ;clear CX
 MOV AH,1 ;Single key Input
 INPUT:
 INT 21H ;read a character
 CMP AL,0DH ;compare AL with CR
 JE END_INPUT ;jump to label END_INPUT if AL=CR
 CMP AL,"[" ;compare AL with "["
 JE PUSH_BRACKET ;jump to label PUSH_BRACKET if AL="["
 CMP AL,"{" ;compare AL with "{"
 JE PUSH_BRACKET ;jump to label PUSH_BRACKET if AL="{"
 CMP AL,"(" ;compare AL with "("
 JE PUSH_BRACKET ;jump to label PUSH_BRACKET if AL="("
 CMP AL,")" ;compare AL with ")"
 JE ROUND_BRACKET ;jump to label ROUND_BRACKET if AL=")"

 CMP AL,"}" ;compare AL with "}"
 JE CURLY_BRACKET ;jump to label CURLY_BRACKET if AL="}"
 CMP AL,"]" ;compare AL with "]"
 JE SQUARE_BRACKET ;jump to label SQUARE_BRACKET if AL="]"
 JMP INPUT ;jump to label INPUT
 PUSH_BRACKET:
 PUSH AX ;push AX onto the STACK
 INC CX ;set CX=CX+1
 JMP INPUT ;jump to label INPUT
 ROUND_BRACKET:
 POP DX ;pop a value from STACK into DX
 DEC CX ;set CX=CX-1
 CMP CX,0 ;compare CX with 0
 JL RIGHT_BRACKETS ;jump to label RIGHT_BRACKETS if CX<0
 CMP DL,"(" ;compare DL with "("
 JNE MISMATCH ;jump to label MISMATCH if DL!="("
 JMP INPUT ;jump to label INPUT

 CURLY_BRACKET:
 POP DX ;pop a value from STACK into DX
 DEC CX ;set CX=CX-1
 CMP CX,0 ;compare CX with 0
 JL RIGHT_BRACKETS ;jump to label RIGHT_BRACKETS if CX<0
 CMP DL,"{" ;compare DL with "{"
 JNE MISMATCH ;jump to label MISMATCH if DL!="{"
 JMP INPUT ; jump to label INPUT
 SQUARE_BRACKET:
 POP DX ;pop a value from STACK into DX
 DEC CX ;set CX=CX-1
 CMP CX,0 ;compare CX with 0
 JL RIGHT_BRACKETS ;jump to label RIGHT_BRACKETS if CX<0
 CMP DL,"[" ;compare DL with "["
 JNE MISMATCH ;jump to label MISMATCH if DL!="["
 JMP INPUT ;jump to label INPUT
 END_INPUT:
 CMP CX,0 ;compare CX with 0
 JNE LEFT_BRACKETS ;jump to label LEFT_BRACKETS if CX!=0
 MOV AH,9 ;String Output
 LEA DX,MSG2 ;load and print the string MSG2
 INT 21H
 LEA DX,MSG6 ;load and print the string MSG6
 INT 21H
 MOV AH,1 ;Single key Input
 INT 21H
 CMP AL,"Y" ;compare AL with "Y"
 JNE EXIT ;jump to label EXIT if AL!="Y"
 JMP START ;jump to label START
 MISMATCH:
 MOV AH,9
 LEA DX,MSG5 ;load and display the string MSG5
 INT 21H
 JMP START ;jump to label START
 LEFT_BRACKETS:
 MOV AH,9
 LEA DX,MSG3 ;load and display the string MSG3
 INT 21H
 JMP START ;jump to label START
 RIGHT_BRACKETS:
 MOV AH,9
 LEA DX,MSG4 ;load and display the string MSG4
 INT 21H
 JMP START ;jump to label START
 EXIT:
 MOV AH,4CH ;return 0
 INT 21H
 MAIN ENDP
END MAIN

