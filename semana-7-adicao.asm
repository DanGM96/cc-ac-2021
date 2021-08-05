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

; Trabalho - Semana 7 - Adicao
Start:
    
    ; 196 + 65 em 0x00
    MOVLW 0xC4	; 196
    ADDLW 0x41	; 65
    MOVWF 0x00
    
    ; 56 + 77 em 0x01
    MOVLW 0x38	; 56
    ADDLW 0x4D	; 77
    MOVWF 0x01
    
    ; 255 + 1 em 0x02
    MOVLW 0xFF	; 255
    ADDLW 0x01	; 1
    MOVWF 0x02
    
    ; 15 + (-15) em 0x03
    MOVLW 0x0F	; 15
    ADDLW 0xF1	; -15
    MOVWF 0x03
    
    ; -100 + (-30) em 0x04
    MOVLW 0x9C	; -100
    ADDLW 0xE2	; -30
    MOVWF 0x04
    
    GOTO Start
    
end
