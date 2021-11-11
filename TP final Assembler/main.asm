
.dseg
R: .db 'R'			//agregado de bariables en segmeto de datos
A: .db 'A'			//se agrega el'a' para definir que es un bit	
r: .db 'R'
a: .db 'A'				

.cseg
.org 0x0000
jmp inicio
.org 0x0004
jmp isr_I1

.include "Division.inc"



inicio:
	ldi r16,high(RamEnd)  
	out Sph,r16
	ldi r16,low(RamEnd)
	out Spl,r16

	
// Config de la Usart

	LDI			R16,0
	STS			UCSR0A,R16
	LDI			R16,(1<<TXEN0)
	STS			UCSR0B,R16
	LDI			R16,(1<<UCSZ01)|(1<<UCSZ00)
	STS			UCSR0C,R16
	LDI			r16,103
	STS			UBRR0L,r16
	LDI			R16,0
	STS			UBRR0H,R16

//Config de la Int1

	Ldi r16,(1<<Isc11)|(1<<Isc10) //Activado por flanco decendente
	Sts Eicra,r16
	Ldi r16,(1<<Int1)
	out Eimsk,r16
 
 //guardamos los valores de las variables definidas

	ldi	r16,65
	sts A,r16

	ldi	r16,97
	sts a,r16

	ldi r16,82
	sts R,r16

	ldi r16,114
	sts r,r16

	sei


	volver1:




	Rjmp volver1
							

Isr_I1:										
	inc r17
	cpi r17,100
	breq Cuenta1Seg
	rjmp volver

	Cuenta1Seg:								//hacer la cuenta fuera del tratamiento de interrupciones 
	inc r16
	MOV	R24,R16

//OBTENER DECENA
		LDI		R16,LOW(10)
		MOV		R22,R16
		CALL	DIVISION8
		MOV		R20,R24
		LDI		R18,48
		ADD		R20,R18
		CALL	ENVIO_UART

//OBTENER UNIDAD
		MOV		R20,R26
		ADD		R20,R18
		CALL	ENVIO_UART
				
	ENVIO_UART:
		PUSH	R19
		STS		UDR0,R20
	ESPERAR_TX:		
		LDS		R19, UCSR0A
		SBRS	R19,UDRE0
		RJMP	ESPERAR_TX
		POP		R19
		
	Volver:
		Reti


	