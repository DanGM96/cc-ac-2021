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
 
Start:
	BCF TRISD, RD1

MainLoop:
	BSF PORTD, RD1	; 1 INICIO
	
	; J = 01001010
	BCF PORTD, RD1	; 0
	BSF PORTD, RD1	; 1
	BCF PORTD, RD1	; 0
	BCF PORTD, RD1	; 0
	BSF PORTD, RD1	; 1
	BCF PORTD, RD1	; 0
	BSF PORTD, RD1	; 1
	BCF PORTD, RD1	; 0
	
	BCF PORTD, RD1	; 0 FIM
	
	GOTO MainLoop
	
	end
