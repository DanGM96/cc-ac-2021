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
 
CODE

; Trabalho - Semana 10 - IF
Start:
    
    BCF TRISD, 0	; Declara RD0 como saida

Loop:    
    
    ; a)
    ;	if ( x == 0 ) { PORTD[0] = 1; PORTD[0] = 0; }
    MOVLW 0x00		    ; W = 0
    CPFSEQ 0x00		    ; Verifica se F == W
	GOTO FinishA	    ; Encerra se X nao for igual a 0
    BSF PORTD, 0	    ; PORTD[0] = 1;
    BCF PORTD, 0	    ; PORTD[0] = 0;
    FinishA:
    
    
    ; b)
    ;	if ( x != 0 ) { PORTD[0] = 1; PORTD[0] = 0; }
    MOVLW 0x00		    ; W = 0
    CPFSEQ 0x00		    ; Verifica se F == W
	GOTO TrueB	    ; Verdade se X nao for igual a 0
    GOTO FinishB	    ; Encerra se X for igual a 0
	TrueB:
	BSF PORTD, 0	    ; PORTD[0] = 1;
	BCF PORTD, 0	    ; PORTD[0] = 0;
    FinishB:
    
    
    ; c)
    ;	if ( x == 23 ) { PORTD[0] = 1; } else { PORTD[0] = 0; }
    MOVLW 0x17		    ; W = 23
    CPFSEQ 0x00		    ; Verifica se F == W
	GOTO FalseC	    ; Falso se X nao for igual a 23
    BSF PORTD, 0	    ; PORTD[0] = 1;
    GOTO FinishC
	FalseC:
	BCF PORTD, 0	    ; PORTD[0] = 0;
    FinishC:
    
    
    ; d)
    ;	if ( x > 15 ) { PORTD[0] = 1; } else { PORTD[0] = 0; }
    MOVLW 0x0F		    ; W = 15
    CPFSGT 0x00		    ; Verifica se F > W
	GOTO FalseD	    ; Falso se X nao for maior que 15
    BSF PORTD, 0	    ; PORTD[0] = 1;
    GOTO FinishD
	FalseD:
	BCF PORTD, 0	    ; PORTD[0] = 0;
    FinishD:
    
    
    ; e)
    ;	if ( x >= 32 ) { PORTD[0] = 1; } else { PORTD[0] = 0; }
    MOVLW 0x20		    ; W = 32
    CPFSGT 0x00		    ; Verifica se F > W
	GOTO CheckTwoE	    ; Segunda checagem se X nao for maior que 32
    GOTO TrueE		    ; Verdade se X for maior que 32
    CheckTwoE:
	CPFSEQ 0x00	    ; Verifica se F == W
	    GOTO FalseE	    ; Falso se X nao for igual a 0
	TrueE:
	BSF PORTD, 0	    ; PORTD[0] = 1;
	GOTO FinishE
	FalseE:
	BCF PORTD, 0	    ; PORTD[0] = 0;
    FinishE:
    
    
    ; f)
    ;	if ( x < 50 ) { PORTD[0] = 1; } else { PORTD[0] = 0; }
    MOVLW 0x32		; W = 50
    CPFSLT 0x00		; Verifica se F < W
	GOTO FalseF	; Falso se X nao for menor que 50
    BSF PORTD, 0	; PORTD[0] = 1;
    GOTO FinishF
	FalseF:
	BCF PORTD, 0	; PORTD[0] = 0;
    FinishF:
    
    GOTO Loop
    
end
