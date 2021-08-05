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

; Prova 2 - Semana 17 - Questao 2
Start:
    
    ; Multiplicação de um vetor por um escalar
    ; V[] = (25; 5)
    ; k = 20
    ; W[] = 20 * (25; 5)
    ; W[] = (20 * 25; 20 * 5)
    ; W[] = (500; 100)
    
    ;	DEC	BIN			HEX	    MEM
    ;	25	0001 1001		0x19	    0x00
    ;	5	0000 0101		0x05	    0x01
    ;	20	0001 0100		0x14	    0x02
    ;	500	0000 0001 1111 0100	0x01F4	    0x03 e 0x04
    ;	100	0000 0000 0110 0100	0x0064	    0x05 e 0x06
    
    ; 25 guardado no endereco 0x00
    MOVLW 0x19
    MOVWF 0x00
    
    ;  5 guardado no endereco 0x01
    MOVLW 0x05
    MOVWF 0x01
    
    ; 20 guardado no endereco 0x02
    MOVLW 0x14
    MOVWF 0x02
    
    CALL PRODUTOESCALAR
    
    GOTO Start
    
    ; Multiplica um vetor por um escalar, W[] = k * V[] = (k * x; k * y)
    PRODUTOESCALAR:
	MOVF   0x02,  W		; W = 20    (k)
	
	MULWF  0x00		; 20 * 25   (k * x)
	MOVFF  PRODH, 0x03	; 0x01	    (H de 500)
	MOVFF  PRODL, 0x04	; 0x2C	    (L de 500)
	
	MULWF  0x01		; 20 * 5    (k * y)
	MOVFF  PRODH, 0x05	; 0x01	    (H de 100)
	MOVFF  PRODL, 0x06	; 0x2C	    (L de 100)
	
	RETURN
end
