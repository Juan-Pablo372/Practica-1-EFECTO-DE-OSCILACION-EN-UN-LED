PROCESSOR 16F887
#include <xc.inc>
;CONFIG word1
CONFIG FOSC = INTRC_NOCLKOUT
CONFIG WDTE = OFF
CONFIG PWRTE = ON
CONFIG MCLRE = OFF
CONFIG CP = OFF
CONFIG CPD = OFF
CONFIG BOREN = OFF
CONFIG IESO = OFF
CONFIG FCMEN = ON
CONFIG DEBUG = ON
;CONFIG word2
CONFIG BOR4V=BOR40V
CONFIG WRT = OFF
PSECT udata
 mask:
    DS 1
cont:
    DS 1
PSECT resetVec,class=CODE,delta=2
resetVec:
PAGESEL main
goto main
PSECT code
 main:
    bcf STATUS,6        ;ACCEDEMOS AL BANCO DONDE ESTA PORTA
    bcf STATUS,5
    clrf PORTA          ;PONEMOS A "0" PORTA 
 
   
    bsf STATUS,6        ;ACCEDEMOS AL BANCO DONDE ESTA ANSEL
    bsf STATUS,5
    clrf ANSEL          ;DESACTIVAMOS EL CONV. A/D 

    
    bcf STATUS,6        ;ACCEDEMOS AL BANCO DONDE ESTA EL REGISTRO TRISA
    bsf STATUS,5
    clrf TRISA          ;PONEMOS A 0 EL REGISTRO TRISA    0=SALIDAS,1=ENTRADAS
    
    
    PSECT code
    bucle:
    bcf STATUS,6        ;ACCEDEMOS AL BANCO DONDE ESTA PORTA
    bcf STATUS,5
    bcf STATUS,0        
    movlw 0b10000000
    movwf PORTA
    goto secuencia1
    secuencia1:
    rrf PORTA
    btfss PORTA,0
    goto secuencia1
    goto secuencia2
    secuencia2:
    rlf PORTA
    btfss PORTA,7
    goto secuencia2
    goto bucle
 END


