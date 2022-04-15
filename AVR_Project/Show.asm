PAGE 110,100
TITLE   'proc_exam.asm'   data transfer 
;-----------------------------------------------
; 1- Define stack segment
; -----------------------
STACKSG SEGMENT STACK 'STACK'      
        DW 32H DUP(0)	
STACKSG ENDS            
; End of segment
;-----------------------------------------------
; 2- Define data segment
; ----------------------
DATASG SEGMENT	'DATA'
MESSAGE1 DB 'MicroContoreller','$' 	
DATASG	ENDS		
;End of segment
;-----------------------------------------------
; 3- Define code segment
; ----------------------       
CODESG  SEGMENT  'CODE'
        ASSUME SS:STACKSG,DS:DATASG,CS:CODESG
MAIN	PROC FAR        
	MOV AX,DATASG  
    MOV DS,AX
          
	CALL CLEAR 
	CALL CURSOR   
	CALL DISPLA1
	
	MOV AX,4C00H
	INT 21H
MAIN    ENDP


CLEAR   PROC NEAR
    MOV AX,0600H
    MOV BH,07H
    MOV CX,0000H
    MOV DX,184FH
    INT 10H
    RET
CLEAR  ENDP


CURSOR  PROC NEAR
    MOV AH,02H
    MOV BH,00
    MOV DH,12
    MOV DL,30
    INT 10H
    RET
CURSOR  ENDP


DISPLA1 PROC NEAR
    MOV AH,09H
    LEA DX,MESSAGE1
    INT 21H
    RET
DISPLA1 ENDP

CODESG ENDS
    END MAIN
	