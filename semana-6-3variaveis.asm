;   
;   Baseado em:
;   https://github.com/ailtonljr/PicLedBlinkAsm/blob/master/blinkled.asm
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#include <p18f4550.inc>
    
    CONFIG WDT=OFF; disable watchdog timer
    CONFIG MCLRE = ON; MCLEAR Pin on
    CONFIG DEBUG = ON; Enable Debug Mode
    CONFIG LVP = OFF; Low-Voltage programming disabled (necessary for debugging)
    CONFIG FOSC = INTOSCIO_EC;Internal oscillator, port function on RA6 
    
    org 0; start code at 0

CODE

; Trabalho - Semana 6 - 3 Variaveis (AND e OR)
Start:
    
    MOVLW 0xEF		; W = 1110 1111 = out RD4
    MOVWF TRISD		; TRISD = W

Loop:
    ; Os comentários consideram RD0 = 1, RD1 = 1 e RD2 = 1 como exemplo
    
    ; D0
    MOVFF PORTD, 0x00	; Guarda o valor da entrada em 0x00 = 0000 0111
    MOVFF 0x00, 0x01	; Cria uma copia do valor inicial
    
    ; D01
    RLNCF 0x00, W	; W = 0000 1110    
    ANDWF 0x00	    	; 0x00 = 0000 0110 ;; 0000 1110 AND 0000 0111
    
    ; D02
    RLNCF 0x00, W	; W = 0000 1100
    IORWF 0x01		; 0000 1111 = 0x01 ;; 0000 1100 OR 0000 0111
    
    ; D03
    RLNCF 0x01		; 0x01 = 0001 1110
    
    ; D04
    RLNCF 0x01		; 0x01 = 0011 1100
    MOVFF 0x01, PORTD	; Move o valor de 0x01 para a saida
    
    GOTO Loop
    
end
