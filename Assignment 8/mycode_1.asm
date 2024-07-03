.MODEL SMALL
.STACK 100H
.DATA
 MSG1 DB 'Enter the string : $'
 MSG2 DB 0DH,0AH,'The string with words in reverse order : $'
 COUNT DW 0
.CODE
 MAIN PROC
 MOV AX,@DATA ;initialize DS
 MOV DS,AX

 MOV AH,9 ;String Output
 LEA DX,MSG1
 INT 21H
 XOR CX,CX ;clear CX
 MOV AH,1 ;single key input
 INPUT:
 INT 21H ;read a character
 CMP AL,0DH ;compare AL with CR
 JE END_INPUT ;if AL=CR jump to label END_INPUT
 PUSH AX ;push AX onto the STACK
 INC CX ;set CX=CX+1
 JMP INPUT ;jump to label INPUT
 END_INPUT:
 MOV BX,50H ;set BX=50H
 XCHG BX,SP ;swap BX and SP
 PUSH 0020H ;push 0020H onto the STACK
 XCHG BX,SP ;swap BX and SP
 INC COUNT ;set COUNT=COUNT+1
 LOOP_1:
 POP DX ;pop a value from STACK into DX
 XCHG BX,SP ;swap BX and SP
 PUSH DX ;push DX onto the STACK
 XCHG BX,SP ;swap BX and SP
 INC COUNT ;set COUNT=COUNT+1
 LOOP LOOP_1 ;jump to label LOOP_1 if CX!=0

 MOV AH,9 ;String Output
 LEA DX,MSG2
 INT 21H
 MOV CX,COUNT ;set CX=COUNT
 MOV COUNT,0 ;set COUNT=0
 PUSH 0020H ;push 0020H onto the STACK
 INC COUNT ;set COUNT=COUNT+1
 OUTPUT:
 XCHG BX,SP ;swap BX and SP
  POP DX ;pop a value from STACK into DX
 XCHG BX,SP ;swap BX and SP
 CMP DL,20H ;compare DL with 20H
 JNE SKIP_PRINTING ;jump to label SKIP_PRINTING if DL!=20H
 MOV AH,2 ;Single key Output
 LOOP_2:
 POP DX ;pop a value from STACK into DX
 INT 21H ;print a character
 DEC COUNT ;set COUNT=COUNT-1
 JNZ LOOP_2 ;jump to label LOOP_2 if COUNT!=0
 MOV DX,0020H ;set DX=0020H
 SKIP_PRINTING:
 PUSH DX ;push DX onto the STACK
 INC COUNT ;set COUNT=COUNT+1
 LOOP OUTPUT ;jump to label OUTPUT if CX!=0
 MOV AH,4CH ;return 0
 INT 21H
 MAIN ENDP
END MAIN


