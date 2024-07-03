.MODEL SMALL
.STACK 100H

 .DATA
   PROMPT_1   DB 'Enter the first capital letter : $'
   PROMPT_2   DB  'Enter the second capital letter : $'
   PROMPT_3   DB  'The given capital letters in alphabetical order are : $'
   NEXT_LINE  DB 0DH,0AH, " $ "

 .CODE
   MAIN PROC
     MOV AX, @DATA                
     MOV DS, AX

     MOV AH, 2                    
     INT 21H

     MOV AH, 9                    

     LEA DX, NEXT_LINE            
     INT 21H

     LEA DX, PROMPT_1             
     INT 21H

     MOV AH, 1                    
     INT 21H                      

     MOV BL, AL                   

     MOV AH, 9                    

     LEA DX, NEXT_LINE            
     INT 21H

     LEA DX, PROMPT_2             
     INT 21H

     MOV AH, 1                    
     INT 21H                      

     MOV BH, AL                   

     MOV AH, 9                    

     LEA DX, NEXT_LINE            
     INT 21H

     LEA DX, PROMPT_3             
     INT 21H

     MOV AH, 2                    

     CMP BL, BH

     JAE @GREATER
       MOV DL, BL
       INT 21H

       MOV DL, BH
       INT 21H

       JMP @END

     @GREATER:
       MOV DL, BH
       INT 21H

       MOV DL, BL
       INT 21H

     @END:

     MOV AH, 4CH                 
     INT 21H
   MAIN ENDP
 END MAIN



