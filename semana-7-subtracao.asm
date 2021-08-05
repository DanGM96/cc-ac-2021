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

; Trabalho - Semana 7 - Subtracao
Start:
    
    ; 15 - 15 em 0x01
    MOVLW 0x0F	; 15
    SUBLW 0x0F	; 15
    MOVWF 0x01
    
    ; -100 - 30 em 0x02
    MOVLW 0x9C	; -100
    SUBLW 0x1E	; 30
    MOVWF 0x02
    
    GOTO Start
    
end
