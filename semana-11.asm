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
    
    x equ 0x00		; Declaracao da variavel X
    i equ 0x01		; Declaracao da variavel i
 
CODE

; Trabalho - Semana 11 - Loop
Start:
    
    MOVLW 0xFE		; W = 1111 1110 = in D4 e D5, out D0
    MOVWF TRISD		; TRISD = W

Loop:
    
    ; a)
    ;	int x = 7; for( i = 0; i < x; i++ ) { PORTD[0] = 1; PORTD[0] = 0; }
    MOVLW 0x07	    ; W = 7
    MOVWF x	    ; x = W
    MOVLW 0x00	    ; W = 0
    MOVWF i	    ; i = W
    
    LoopA:
	MOVF x, W	    ; W = x
	CPFSLT i	    ; Verifica se i < x (pula se sim)
	    GOTO FimLoopA
	INCF i		    ; i++
	
	BSF PORTD, 0	    ; PORTD[0] = 1;
	BCF PORTD, 0	    ; PORTD[0] = 0;
	GOTO LoopA
    FimLoopA:
    
    
    ; b)
    ;	int x = 7; for( i = x; i != 0; i-- ) { PORTD[0] = 1; PORTD[0] = 0; }
    MOVLW 0x07	    ; W = 7
    MOVWF x	    ; x = W
    MOVF x, W	    ; W = x	; Essa linha pode ser removida, nesse caso
    MOVWF i	    ; i = W
    
    LoopB:
	MOVF i, W		; W = i
	BTFSC STATUS, 2		; Verifica se i != 0 (pula se sim)
	    GOTO FimLoopB
	DECF i			; i--
	
	BSF PORTD, 0		; PORTD[0] = 1;
	BCF PORTD, 0		; PORTD[0] = 0;
	GOTO LoopB
    FimLoopB:
    
    
    ; c)
    ;	while( PORD[4] == 1 ) { PORTD[0] = 1; PORTD[0] = 0; }
    LoopC:
	BTFSS PORTD, 4		; Verifica se PORD[4] == 1 (pula se sim)
	    GOTO FimLoopC
	
	BSF PORTD, 0		; PORTD[0] = 1;
	BCF PORTD, 0		; PORTD[0] = 0;
	GOTO LoopC
    FimLoopC:
    

    ; d)
    ;	while( PORD[4] == 1 || PORTD[5] == 1 ) { PORTD[0] = 1; PORTD[0] = 0; }
    LoopD:
	BTFSC PORTD, 4		; Verifica se PORD[4] == 1 (pula se nao)
	    GOTO TrueD
	BTFSS PORTD, 5		; Verifica se PORD[5] == 1 (pula se sim)
	    GOTO FimLoopD

	TrueD:
	    BSF PORTD, 0	; PORTD[0] = 1;
	    BCF PORTD, 0	; PORTD[0] = 0;
	    GOTO LoopD
    FimLoopD:
    
    GOTO Loop
    
end
