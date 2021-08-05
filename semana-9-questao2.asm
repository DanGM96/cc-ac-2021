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

; Prova 1 - Semana 9 - Questao 2
Start:
    
    ; Somando dois vetores
    ; v1 = (180,  50)
    ; v1 = (200, 300)
    ; w = v1 + v2 = (180 + 200, 50 + 300) = (380, 350)
    
    ;	DEC	BIN			HEX	    MEM
    ;	180	0000 0000 1011 0100	0x00B4	    0x00 e 0x01
    ;	50	0000 0000 0011 0010	0x0032	    0x02 e 0x03
    ;	200	0000 0000 1100 1000	0x00C8	    0x04 e 0x05
    ;	300	0000 0001 0010 1100	0x012C	    0x06 e 0x07
    ;	380	0000 0001 0111 1100	0x017C	    0x08 e 0x09
    ;	350	0000 0001 0101 1110	0x015E	    0x0A e 0x0B
    
    ; 180 guardado nos enderecos 0x00 e 0x01
    MOVLW 0x00
    MOVWF 0x00
    MOVLW 0xB4
    MOVWF 0x01
    
    ; 50 guardado nos enderecos 0x02 e 0x03
    MOVLW 0x00
    MOVWF 0x02
    MOVLW 0x32
    MOVWF 0x03
    
    ; 200 guardado nos enderecos 0x04 e 0x05
    MOVLW 0x00
    MOVWF 0x04
    MOVLW 0xC8
    MOVWF 0x05
    
    ; 300 guardado nos enderecos 0x06 e 0x07
    MOVLW 0x01
    MOVWF 0x06
    MOVLW 0x2C
    MOVWF 0x07
    
    ; 180 + 200 guardado nos enderecos 0x08 e 0x09
    MOVF 0x01, W
    ADDWF 0x05, W
    MOVWF 0x09
    MOVF 0x00, W
    ADDWFC 0x04, W
    MOVWF 0x08
    
    ; 50 + 300 guardado nos enderecos 0x0A e 0x0B
    MOVF 0x03, W
    ADDWF 0x07, W
    MOVWF 0x0B
    MOVF 0x02, W
    ADDWFC 0x06, W
    MOVWF 0x0A
    
    GOTO Start
    
end
