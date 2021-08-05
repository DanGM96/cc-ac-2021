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

; Trabalho - Semana 8 - Soma 32 bits e Multiplicacao
Start:
    
    ;	DEC		BIN					    HEX
    ;	15.000.000	0000 0000 1110 0100 1110 0001 1100 0000	    0x00E4E1C0
    ;	10.000.000	0000 0000 1001 1000 1001 0110 1000 0000	    0x00989680
    ;	25.000.000	0000 0001 0111 1101 0111 1000 0100 0000	    0x017D7840
    ;	12.000.000	0000 0000 1011 0111 0001 1011 0000 0000	    0x00B71B00
    ;	18.000.000	0000 0001 0001 0010 1010 1000 1000 0000	    0x0112A880
    ;	 6.000.000	0000 0000 0101 1011 1000 1101 1000 0000	    0x005B8D80
    
    ; 15.000.000 guardado nos enderecos 0x10 a 0x13
    MOVLW 0x00
    MOVWF 0x10
    MOVLW 0xE4
    MOVWF 0x11
    MOVLW 0xE1
    MOVWF 0x12
    MOVLW 0xC0
    MOVWF 0x13    
    
    ; 10.000.000 guardado nos enderecos 0x20 a 0x23
    MOVLW 0x00
    MOVWF 0x20
    MOVLW 0x98
    MOVWF 0x21
    MOVLW 0x96
    MOVWF 0x22
    MOVLW 0x80
    MOVWF 0x23
    
    ; 15.000.000 + 10.000.000 guardado nos enderecos 0x00 a 0x03
    MOVF 0x13, W
    ADDWF 0x23, W
    MOVWF 0x03
    MOVF 0x12, W
    ADDWFC 0x22, W
    MOVWF 0x02
    MOVF 0x11, W
    ADDWFC 0x21, W
    MOVWF 0x01
    MOVF 0x10, W
    ADDWFC 0x20, W
    MOVWF 0x00
    
    ; 12.000.000 guardado nos enderecos 0x14 a 0x17
    MOVLW 0x00
    MOVWF 0x14
    MOVLW 0xB7
    MOVWF 0x15
    MOVLW 0x1B
    MOVWF 0x16
    MOVLW 0x00
    MOVWF 0x17
    
    ; 18.000.000 guardado nos enderecos 0x24 a 0x27
    MOVLW 0x01
    MOVWF 0x24
    MOVLW 0x12
    MOVWF 0x25
    MOVLW 0xA8
    MOVWF 0x26
    MOVLW 0x80
    MOVWF 0x27
    
    ; 18.000.000 - 12.000.000 guardado nos enderecos 0x04 a 0x07
    MOVF 0x17, W
    SUBWF 0x27, W
    MOVWF 0x07
    MOVF 0x16, W
    SUBWFB 0x26, W
    MOVWF 0x06
    MOVF 0x15, W
    SUBWFB 0x25, W
    MOVWF 0x05
    MOVF 0x14, W
    SUBWFB 0x24, W
    MOVWF 0x04
    
    ; 100 guardado no endereco 0x19    
    MOVLW 0x64
    MOVWF 0x19
    
    ; 20 guardado no endereco 0x29
    MOVLW 0x14
    MOVWF 0x29
    
    ; 100 * 20 guardado nos enderecos 0x08 e 0x09
    MOVF 0x19, W
    MULWF 0x29
    MOVFF PRODH, 0x08
    MOVFF PRODL, 0x09
    
    GOTO Start
    
end
