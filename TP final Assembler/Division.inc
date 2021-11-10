; Divisi�n por 8 bits
; DIVIDENDO -> R24
; DIVISOR   -> R22
; RESTO		-> R25
; COCIENTE	-> A lo largo del algoritmo se modifica el DIVIDENDO y el COCIENTE queda en R24
; R23 tambi�n es modificado en el desarrollo de la operaci�n		
DIVISION8:
		SUB		R25,R25		 
		LDI		R23,0x09	 
		RJMP	SEGUIR8		 
VOLVER8:ROL		R25			 
		CP		R25,R22      
		BRCS	SEGUIR8		
		SUB		R25,R22		 
SEGUIR8:ROL		R24			 
		DEC		R23			 
		BRNE	VOLVER8		 
		COM		R24			 
		RET 			