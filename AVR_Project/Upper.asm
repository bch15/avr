PAGE 110,100
TITLE   'mov_data.asm'   data transfer 
;-----------------------------------------------
;             1- Define stack segment
;             -----------------------
STACKSG SEGMENT STACK 'STACK'      
        DW 32H DUP(0)	; 32H word for stack
STACKSG ENDS            ; End of segment
;-----------------------------------------------
;		2- Define data segment
DATASG SEGMENT	'DATA'
	
DATA1 DB "One DAY"
	
DATA2	DB 7 DUP(?)
DATASG	ENDS		;End of segment
;-----------------------------------------------
;              3- Define code segment
;              ----------------------
;       
CODESG  SEGMENT  'CODE'
        ASSUME SS:STACKSG,DS:DATASG,CS:CODESG
MAIN	PROC FAR        
	MOV AX,DATASG  
        MOV DS,AX      
;
	LEA SI,DATA1 
	LEA DI,DATA2   
	MOV CX,18       
L2:	MOV AL,[SI]   
    CMP AL,'a'
    JB L1  
    CMP AL,'z'
    JA L1
    AND AL,11011111b
L1: MOV [DI],AL
    INC SI
    INC DI
    loop L2   
	
	
	MOV AX,4C00H   
        INT 21H        
MAIN    ENDP          
CODESG  ENDS           
        END MAIN        