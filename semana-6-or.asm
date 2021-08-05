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

; Trabalho - Semana 6 - OR
Start:
    
    MOVLW 0xEF		; W = 1110 1111 = out RD4
    MOVWF TRISD		; TRISD = W

Loop:
    ; Os comentários consideram RD0 = 1 e RD1 = 1 como exemplo
    
    ; D0
    MOVFF PORTD, 0x00	; Guarda o valor de D0 em 0x00 = 0000 0011
    
    ; D01
    RLNCF 0x00, W	; W = 0000 0110
    IORWF 0x00		; 0000 0110 OR 0000 0011 = 0000 0111 = 0x00
    
    ; D02
    RLNCF 0x00		; 0x00 = 0000 1110
    
    ; D03
    RLNCF 0x00		; 0x00 = 0001 1100
    
    ; D04
    RLNCF 0x00		; 0x00 = 0011 1000
    MOVFF 0x00, PORTD	; Move o valor de 0x00 para a PORTD
    
    GOTO Loop
    
end
