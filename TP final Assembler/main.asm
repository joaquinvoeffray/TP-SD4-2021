.org 0x0000
jmp inicio
.org 0x0004
jmp isr_I1


inicio:
	ldi r16,high(RamEnd)  
	out Sph,r16
	ldi r16,low(RamEnd)
	out Spl,r16

	Ldi r16,(1<<PortB2)		//Pin conectado al colector del OPTO
	out DdrB,r16
	


//Config de la Int1

	Ldi r16,(1<<Isc11)|(1<<Isc10) //Activado por flanco decendente (Habria que ver si no tenemos delay)
	Sts Eicra,r16
	Ldi r16,(1<<Int1)
	out Eimsk,r16


//Config de la USART
	sei


	volver1:
	Rjmp volver1
							/*Pd: si es que no lo hice todavia, estaria bueno ver si en ves de usar otro pin para los 5V, usar la R de pull up del pin de la Int 0
								  aunque tengo mis dudas si funcionaria*/
	

Isr_I1:
	
	inc r17
	cpi r17,60
	breq Cuenta1Seg
	rjmp volver
	Cuenta1Seg:
	sbi pinb,pinb2 //a modo de ver si cuenta un segundo

	//Envia a la usart en conteo de 1 segundo
	
	volver:
	Reti


	