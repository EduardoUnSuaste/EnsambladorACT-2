;ITSVA
;ISC 6B 
;Elaborado por: Eduardo emanuel un suaste
;Fecha: 13/05/19

NUEVAPANTALLA MACRO NUEVA
    MOV AH, 05H
    MOV AL, NUEVA
    INT 10H    
    
NUEVAPANTALLA ENDM 


ASIGNUM MACRO 
    
    MOV AH, 01H
    INT 21H
    SUB AL, 48
    
ASIGNUM ENDM

PANTALLAS MACRO SCRPAGE, SCRCOLOR, SCRPOINTA, SCRPOINTB
    MOV AH, 06H
    MOV AL, SCRPAGE
    MOV BH, SCRCOLOR
    MOV CX, SCRPOINTA
    MOV DX, SCRPOINTB
    INT 10H 
    
PANTALLAS ENDM 

;SET TEXTS & DIGITS
IMPRIMIR MACRO PRPAGE, PRROW, PRCOL, PRSTRING
    MOV AH, 02H
    MOV BH, PRPAGE
    MOV DH, PRROW
    MOV DL, PRCOL
    INT 10H
    
    MOV AH, 09H
    LEA DX, PRSTRING
    INT 21H   
    
IMPRIMIR ENDM   

BASE MACRO
    MOV AL, DIG1
    MUL TEN
    MOV TEMP1, AL
    MOV AL,TEMP1
    ADD AL,DIG2
BASE ENDM     

OUTPUT MACRO NUMBERBASE
   MOV AL, NUMBERBASE
   AAM
   MOV DIG4, AL
      
   MOV AL, AH
   AAM
   MOV DIG3, AL
   
   MOV AL, AH
   AAM
   MOV DIG2, AL
      
   MOV AL, AH
   AAM
   MOV DIG1, AL
      
   MOV DL, DIG1
   ADD DL, 48
   MOV AH, 02H
   INT 21H
      
   MOV DL, DIG2
   ADD DL, 48
   MOV AH, 02H
   INT 21H
      
   MOV DL, DIG3
   ADD DL, 48
   MOV AH, 02H
   INT 21H
   
   MOV DL, DIG4
   ADD DL, 48
   MOV AH, 02H
   INT 21H
ENDM       
   

      
.MODEL SMALL  



.DATA     
     CADENA1 DB '[1] SUMA,RESTA,DIVICION,MULTIPLICACION Y DIVICION (1-9)$' 
     CADENA2 DB '[2] DETERMINAR EL MAYOR$'
     STR1 DB "2. EL MAYOR DE 3 NUMEROS (1-99)$" 
     CADENA6 DB "SELECCIONA UN VALOR ","$" 
     MAY DB "EL MAYOR ES: $"
     
     ;VARIABLES DE LA SUMA, RESTA, MUL, DIV
     
     ;declarando variables globales
    numero1 db 0
    numero2 db 0

    suma db 0
    resta db 0
    multiplicacion db 0
    division db 0
    modulo db 0

    msjn1 db 10,13, "Ingrese el primer numero= ",'$';ingrese n1
    msjn2 db 10,13, "Ingrese el segundo numero= ",'$';ingrese n2

    ;mensaje para mostrar los resultados
 
    msjnS db 10,13, "La suma es= ",'$'
    msjnR db 10,13, "La resta= ",'$'
    msjnM db 10,13, "La Multiplicacion es= ",'$'
    msjnD db 10,13, "La division es = ",'$' 
    msjnMod db 10,13, "El modulo es = ",'$' 
    
    ;variables de comparacion 1
    NUM1 DB "NUMERO 1: $"
    NUM2 DB "NUMERO 2: $"
    NUM3 DB "NUMERO 3: $"   
    
    ;AUX
    TEN DB 10
    
    ;TEMPS
    TEMP1 DB 0
    TEMP2 DB 0
    TEMP3 DB 0
    TEMP4 DB 0     
     
      ;DIGITS
    DIG1 DB ?
    DIG2 DB ?
    DIG3 DB ?
    DIG4 DB ?
    DIG5 DB ?
     

.CODE    

      
    
      
     MOV AX,@DATA
     MOV DS,AX   
           
     ;fondo uno          
    PANTALLAS 0, 4FH, 0000H, 184FH   
                                 
     ;fondo 2  
    PANTALLAS 0, 2FH, 0507H, 1448H 
     
     ;fondo 3   
    PANTALLAS 0, 9FH, 0707H, 0248H 
    
     ;cadena 1 ---SUMA,RESTA,MUL,DIV--- 
     
    IMPRIMIR 0, 08H, 0CH, CADENA1  
  
    ;cadena 2  ---MAYOR---  
    
    
    IMPRIMIR 0, 0BH, 0CH, CADENA2
                       
                                 
                                 
      ;Cadena 6 PARA SELEECIONAR 
      
                                  
    IMPRIMIR 0, 17H, 1EH, CADENA6
 
    PAG:          ;PARA LEER UN CARACTER
    MOV AH, 0H 
    INT 16H
    
    
    CMP AL,"1"
    JE SRMD 
    CMP AL,"2"
    JE MAYOR
 
    JMP FIN
    
    SRMD: 
    
       NUEVAPANTALLA 1
          
        MOV AH,06H
        MOV AL,0
        MOV BH,1AH
        MOV CX, 0000
        MOV DX,184FH  
    
    
    ;solicitar del teclado numero 1
    
    mov ah, 09
    lea dx, msjn1
    int 21h
    mov ah, 01
    int 21h
    sub al, 30h
    mov numero1,al
    
    ;solicitar del teclado numero 2
    
    mov ah, 09
    lea dx, msjn2
    int 21h
    mov ah, 01
    int 21h
    sub al, 30h
    mov numero2,al
    
    ;operaciones aritmeticas
                  
    ;SUMA             
    mov al,numero1
    add al,numero2
    mov suma,al  
    
    ;RESTA
    mov al,numero1
    sub al,numero2
    mov resta,al
    
    ;MULTIPLICACION
    mov al,numero1
    mul numero2
    mov multiplicacion,al
    
    ;DIVISION
    mov al,numero1
    div numero2
    mov division,al
    
    ;MODULO
    mov al, numero1
    div numero2
    mov modulo,ah 
       
    ;Mostrar los mensajes de los resultados 
    
    ;mostrando la suma
    mov ah,09
    lea dx,msjnS
    int 21h
    mov dl,suma
    add dl,30h 
    mov ah,02
    int 21h  
    
    ;mostrando la resta
    mov ah,09
    lea dx,msjnR
    int 21h
    mov dl,resta
    add dl,30h 
    mov ah,02
    int 21h
    
    ;mostrando la multiplicacion
    mov ah,09
    lea dx,msjnM
    int 21h
    mov dl,multiplicacion
    add dl,30h 
    mov ah,02
    int 21h
    
    ;mostrando la division
    mov ah,09
    lea dx,msjnD
    int 21h
    mov dl,division
    add dl,30h 
    mov ah,02
    int 21h
                
    ;mostrando el modulo     
    mov ah,09
    lea dx,msjnMod
    int 21h
    mov dl,modulo
    add dl,30h 
    mov ah,02
    int 21h
        
        
        
        INT 10H
        MOV AH,0H
        INT 16H  
        CMP AL, 008 
        JE ATRAS
        
        JMP FIN    
         
        
      MAYOR:;ETIQUETAS
    
        ;*********************
         NUMBERS:
         
      NUEVAPANTALLA 2 
      
      PANTALLAS 0, 9FH, 0000H, 184FH     
      
      IMPRIMIR 2, 4, 32, STR1
      
      IMPRIMIR 2, 8, 32, NUM1
      ASIGNUM
      MOV DIG1,AL
      ASIGNUM
      MOV DIG2,AL   
      BASE
      MOV TEMP2, AL; NUMBER 1
      
      IMPRIMIR 2, 9, 32, NUM2
      ASIGNUM
      MOV DIG1,AL
      ASIGNUM
      MOV DIG2,AL
      BASE
      MOV TEMP3, AL; NUMBER 2
      
      IMPRIMIR 2, 10, 32, NUM3
      ASIGNUM
      MOV DIG1,AL
      ASIGNUM
      MOV DIG2,AL
      BASE
      MOV TEMP4, AL; NUMBER 3
            
       
      MOV AH, TEMP2
      MOV AL, TEMP3
      CMP AH, AL
      JA CASE1
      JMP CASE2
      CASE1:
        MOV AL, TEMP4
        CMP AH,AL
        JA MAYOR1
      CASE2:
        MOV AH, TEMP3
        MOV AL, TEMP4
        CMP AH, AL
        JA MAYOR2
        JMP MAYOR3
        
      MAYOR1:
        IMPRIMIR 2, 14, 32, MAY
        OUTPUT TEMP2
        JMP FIN
        
      MAYOR2:
        IMPRIMIR 2, 14, 32, MAY
        OUTPUT TEMP3
        JMP FIN
        
      MAYOR3:
        IMPRIMIR 2, 14, 32, MAY
        OUTPUT TEMP4  
     
        JE ATRAS
        JMP FIN  
        
        ATRAS: ;<--- TECLA ATRAS
        MOV AH,05H
        MOV AL,0
        INT 10H
        JMP PAG 
        

        FIN:           ;FUNCION PARA TERMINAR PROGRAMA
        MOV AH,4CH 
        INT 21H
        
END