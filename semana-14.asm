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

; Trabalho - Semana 14 - CALL e RETURN
Start:

MainLoop:

    ; 1)
    ; 4 guardado no endereco 0x00
    MOVLW 0x04
    MOVWF 0x00
    CALL PULSOS
    
    ; 2)
    ; 1337 guardado nos enderecos 0x00 e 0x01
    MOVLW 0x05
    MOVWF 0x00
    MOVLW 0x39
    MOVWF 0x01
    ; 2021 guardado nos enderecos 0x02 e 0x03
    MOVLW 0x07
    MOVWF 0x02
    MOVLW 0xE5
    MOVWF 0x03
    CALL SOMA
   
    ; 3)
    ; 0x79 guardado no endereco 0x00	; 0111 1001
    MOVLW 0x79
    MOVWF 0x00
    CALL BYTE2
    
    GOTO MainLoop


    ; 1) Lê o valor da posição 0x00 e gera o número de pulsos na porta D0
    PULSOS:
	BCF TRISD, 0		    ; Declara RD0 como saida
	MOVF 0x00, W		    ; Apenas para pegar o status de 0x00
	CALL PULSOSLOOP
	RETURN			    ; Inalcançável mas deixa aí, vai que...

    PULSOSLOOP:
	BTFSC STATUS, 2	    ; Verifica se F é zero
	    RETURN		    ; Encerra quando F == 0
	BSF PORTD, 0	    ; PORTD[0] = 1;
	BCF PORTD, 0	    ; PORTD[0] = 0;
	DECF 0x00		    ; F--
	CALL PULSOSLOOP

    ; 2) Soma dois valores de 16bits das pos 0x00 a 0x03 e coloca em 0x04 e 0x05
    SOMA:
	; 0x00 e 0x01 + 0x02 e 0x03 guardado em 0x04 e 0x05
	MOVF 0x01, W
	ADDWF 0x03, W
	MOVWF 0x05
	MOVF 0x00, W
	ADDWFC 0x02, W
	MOVWF 0x04
	RETURN


    ; 3) Lê o valor da posição 0x00 e transmite um byte na porta D0
    BYTE:   ;; Não funciona por causa do BTFS que lê o segundo arg como literal
	BCF TRISD, 0		    ; Declara RD0 como saida
	MOVLW 0x07		    ; Move 7 para W
	MOVWF 0x01		    ; Move o W para 0x01
	CALL BYTELOOP
	BCF PORTD, 0		    ; Bit de encerramento
	RETURN
	
    BYTELOOP:
	DECF 0x01		    ; Decrementa para percorrer os bits até 0
	BTFSC 0x00, 0x01	    ; Pula instrução se o bit for 0
	    BSF PORTD, 0	    ; PORTD[0] = 1;
	BTFSS 0x00, 0x01	    ; Pula instrução se o bit for 1
	    BCF PORTD, 0	    ; PORTD[0] = 0;
	TSTFSZ 0x01		    ; Se 0x01 for zero, encerra o loop
	    CALL BYTELOOP
    RETURN
    
    BYTE2:  ;; Funciona, mas é desnecessariamente grande
	BTFSC 0x00, 7		    ; Pula instrução se o bit for 0
	    BSF PORTD, 0	    ; PORTD[0] = 1;
	BTFSS 0x00, 7		    ; Pula instrução se o bit for 1
	    BCF PORTD, 0	    ; PORTD[0] = 0;
	
	BTFSC 0x00, 6
	    BSF PORTD, 0
	BTFSS 0x00, 6
	    BCF PORTD, 0
    	
	BTFSC 0x00, 5
	    BSF PORTD, 0
	BTFSS 0x00, 5
	    BCF PORTD, 0
    	
	BTFSC 0x00, 4
	    BSF PORTD, 0
	BTFSS 0x00, 4
	    BCF PORTD, 0
    	
	BTFSC 0x00, 3
	    BSF PORTD, 0
	BTFSS 0x00, 3
	    BCF PORTD, 0
    	
	BTFSC 0x00, 2
	    BSF PORTD, 0
	BTFSS 0x00, 2
	    BCF PORTD, 0
    	
	BTFSC 0x00, 1
	    BSF PORTD, 0
	BTFSS 0x00, 1
	    BCF PORTD, 0
    	
	BTFSC 0x00, 0
	    BSF PORTD, 0
	BTFSS 0x00, 0
	    BCF PORTD, 0
    	
	BCF PORTD, 0		    ; Bit de encerramento
	RETURN
end
