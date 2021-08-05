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

; Prova 1 - Semana 9 - Questao 1
Start:
    
    MOVLW 0xEF		; W = 1110 1111 = out RD4
    MOVWF TRISD		; TRISD = W

Loop:
    ; ATENCAO: Os comentarios consideram RD0 = 1, RD1 = 1 e RD2 = 1 como exemplo
    
    ; D0
    MOVFF PORTD, 0x00	; Guarda o valor da entrada em 0x00 = 0000 0111
    MOVFF 0x00, 0x01	; Cria uma copia do valor inicial
    
    ; D01
    RLNCF 0x00, W	; W = 0000 1110
    XORWF 0x00	    	; 0x00 = 0000 1001 ;; 0000 1110 XOR 0000 0111
    
    ; D02
    RLNCF 0x00, W	; W = 0001 0010
    XORWF 0x01		; 0001 0101 = 0x01 ;; 0001 0010 XOR 0000 0111
    
    ; D03
    RLNCF 0x01		; 0x01 = 0010 1010
    
    ; D04
    RLNCF 0x01		; 0x01 = 0101 0100
    MOVFF 0x01, PORTD	; Move o valor de 0x01 para a saida
    
    GOTO Loop
    
end
