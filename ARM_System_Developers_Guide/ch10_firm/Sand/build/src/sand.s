;  ____________________________________________________________________
; 
;  Copyright (c) 2002, Andrew N. Sloss, Chris Wright and Dominic Symes
;  All rights reserved.
;  ____________________________________________________________________
; 
;  NON-COMMERCIAL USE License
;  
;  Redistribution and use in source and binary forms, with or without 
;  modification, are permitted provided that the following conditions 
;  are met: 
;  
;  1. For NON-COMMERCIAL USE only.
; 
;  2. Redistributions of source code must retain the above copyright 
;     notice, this list of conditions and the following disclaimer. 
; 
;  3. Redistributions in binary form must reproduce the above 
;     copyright notice, this list of conditions and the following 
;     disclaimer in the documentation and/or other materials provided 
;     with the distribution. 
; 
;  4. All advertising materials mentioning features or use of this 
;     software must display the following acknowledgement:
; 
;     This product includes software developed by Andrew N. Sloss,
;     Chris Wright and Dominic Symes. 
; 
;   THIS SOFTWARE IS PROVIDED BY THE CONTRIBUTORS ``AS IS'' AND ANY 
;   EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
;   IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR 
;   PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE CONTRIBUTORS BE 
;   LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, 
;   OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, 
;   PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, 
;   OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY 
;   THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR 
;   TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT 
;   OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY 
;   OF SUCH DAMAGE. 
; 
;  If you have questions about this license or would like a different
;  license please email :
; 
; 	andrew@sloss.net
; 
;
; *****************************************************************************
; * Sandstone
; *****************************************************************************

; *****************************************************************************
; * Defines
; *****************************************************************************

; -- Serial Communication -----------------------------------------------------

SYSCFG          EQU     0x03FF0000
EXTDBWTH        EQU     (SYSCFG + 0x3010)
ROMCON1         EQU     (SYSCFG + 0x3018)
INTMOD          EQU     (SYSCFG + 0x4000)
INTPND          EQU     (SYSCFG + 0x4004)
INTMSK          EQU     (SYSCFG + 0x4008)
TMOD            EQU     (SYSCFG + 0x6000)
TDATA0          EQU     (SYSCFG + 0x6004)
TDATA1          EQU     (SYSCFG + 0x6008)
IOPMOD          EQU     (SYSCFG + 0x5000)
IOPCON          EQU     (SYSCFG + 0x5004)
IOPDATA         EQU     (SYSCFG + 0x5008)
UART0_BASE      EQU     (SYSCFG + 0xD000)
UART1_BASE      EQU     (SYSCFG + 0xE000)

; Serial settings.......................

ULCON	EQU 	0x00
UCON	EQU	0x04	
USTAT	EQU 	0x08	
UTXBUF	EQU 	0x0C
URXBUF	EQU 	0x10
UBRDIV	EQU 	0x14

; Line control register bits............
  
ULCR8bits	EQU	(3)
ULCRS1StopBit 	EQU 	(0)
ULCRNoParity	EQU	(0)

; UART Control Register bits............
 
UCRRxM		EQU		(1)
UCRRxSI		EQU		(1<<2)
UCRTxM		EQU 		(1<<3)
UCRLPB		EQU 		(1<<7)

; UART Status Register bits
 
USROverrun	EQU   		(1<<0)
USRParity      	EQU		(1<<1)
USRFraming     	EQU 		(1<<2)
USRBreak       	EQU		(1<<3)
USRDTR		EQU		(1<<4)
USRRxData      	EQU		(1<<5) 
USRTxHoldEmpty 	EQU		(1<<6)
USRTxEmpty	EQU    		(1<<7)

; default baud rate value ............
 
BAUD_9600	EQU		(162<<4)

; -- memory remap -------------------------------------------------------------

fMCLK_MHz EQU  50000000   ; 50MHz, KS32C50100 default
MHz       EQU  1000000
fMCLK     EQU  (fMCLK_MHz/MHz)

; -- EXTDBWTH : Memory Bus Width register ...............................

DSR0  		EQU  2:SHL:0           ; ROM0	Flash		 0 : Disable
				       ;       			 1 : Byte
				       ;       			 2 : Half-Word
				       ;       			 3 : Word
DSR1  		EQU  3:SHL:2           ; ROM1	SRAM
DSR2  		EQU  3:SHL:4           ; ROM2	SRAM
DSR3  		EQU  0:SHL:6           ; ROM3
DSR4  		EQU  0:SHL:8           ; ROM4
DSR5  		EQU  0:SHL:10          ; ROM5
DSD0  		EQU  0:SHL:12          ; DRAM0
DSD1  		EQU  0:SHL:14          ; DRAM1
DSD2  		EQU  0:SHL:16          ; DRAM2
DSD3  		EQU  0:SHL:18          ; DRAM3
DSX0  		EQU  0:SHL:20          ; EXTIO0
DSX1  		EQU  0:SHL:22          ; EXTIO1
DSX2  		EQU  0:SHL:24          ; EXTIO2
DSX3  		EQU  0:SHL:26          ; EXTIO3

rEXTDBWTH   EQU  DSR0+DSR1+DSR2+DSR3+DSR4+DSR5+DSD0+DSD1+DSD2+DSD3+DSX0+DSX1+DSX2+DSX3

; -- ROMCON0 : ROM Bank0 Control register ..............................

ROMBasePtr0     EQU  0x180:SHL:10   ;=0x1800000  
ROMEndPtr0      EQU  0x188:SHL:20   ;=0x1880000  
PMC0            EQU  0x0            ; 0x0=Normal ROM, 0x1=4Word Page 
                                    ; 0x2=8Word Page, 0x3=16Word Page
rTpa0           EQU  (0x0:SHL:2)    ; 0x0=5Cycle, 0x1=2Cycle
                                    ; 0x2=3Cycle, 0x3=4Cycle 
rTacc0          EQU  (0x3:SHL:4)    ; 0x0=Disable, 0x1=2Cycle
                                    ; 0x2=3Cycle, 0x3=4Cycle
                                    ; 0x4=5Cycle, 0x5=6Cycle
                                    ; 0x6=7Cycle, 0x7=Reserved
rROMCON0   EQU  ROMEndPtr0+ROMBasePtr0+rTacc0+rTpa0+PMC0

; -- ROMCON1 : ROM Bank1 Control register .............................

ROMBasePtr1     EQU  0x000:SHL:10   ;=0x0000000  
ROMEndPtr1      EQU  0x004:SHL:20   ;=0x0040000  
PMC1            EQU  0x0            ; 0x0=Normal ROM, 0x1=4Word Page 
                                    ; 0x2=8Word Page, 0x3=16Word Page
rTpa1           EQU  (0x0:SHL:2)    ; 0x0=5Cycle, 0x1=2Cycle
                                    ; 0x2=3Cycle, 0x3=4Cycle 
rTacc1          EQU  (0x1:SHL:4)    ; 0x0=Disable, 0x1=2Cycle
                                    ; 0x2=3Cycle, 0x3=4Cycle
                                    ; 0x4=5Cycle, 0x5=6Cycle
                                    ; 0x6=7Cycle, 0x7=Reserved
rROMCON1   EQU  ROMEndPtr1+ROMBasePtr1+rTacc1+rTpa1+PMC1

; -- ROMCON2 : ROM Bank2 Control register ...........................

ROMBasePtr2     EQU  0x004:SHL:10   ;=0x0040000  
ROMEndPtr2      EQU  0x008:SHL:20   ;=0x0080000  
PMC2            EQU  0x0            ; 0x0=Normal ROM, 0x1=4Word Page 
                                    ; 0x2=8Word Page, 0x3=16Word Page
rTpa2           EQU  (0x0:SHL:2)    ; 0x0=5Cycle, 0x1=2Cycle
                                    ; 0x2=3Cycle, 0x3=4Cycle 
rTacc2          EQU  (0x1:SHL:4)    ; 0x0=Disable, 0x1=2Cycle
                                    ; 0x2=3Cycle, 0x3=4Cycle
                                    ; 0x4=5Cycle, 0x5=6Cycle
                                    ; 0x6=7Cycle, 0x7=Reserved
rROMCON2   EQU  ROMEndPtr2+ROMBasePtr2+rTacc2+rTpa2+PMC2


; -- ROMCON3 : ROM Bank3 Control register ...........................

ROMBasePtr3     EQU  0x060:SHL:10   ;=0x0600000  
ROMEndPtr3      EQU  0x080:SHL:20   ;=0x0800000  
PMC3            EQU  0x0            ; 0x0=Normal ROM, 0x1=4Word Page 
                                    ; 0x2=8Word Page, 0x3=16Word Page
rTpa3           EQU  (0x0:SHL:2)    ; 0x0=5Cycle, 0x1=2Cycle
                                    ; 0x2=3Cycle, 0x3=4Cycle 
rTacc3          EQU  (0x2:SHL:4)    ; 0x0=Disable, 0x1=2Cycle
                                    ; 0x2=3Cycle, 0x3=4Cycle
                                    ; 0x4=5Cycle, 0x5=6Cycle
                                    ; 0x6=7Cycle, 0x7=Reserved
rROMCON3   EQU  ROMEndPtr3+ROMBasePtr3+rTacc3+rTpa3+PMC3

; -- ROMCON4 : ROM Bank4 Control register ...........................

ROMBasePtr4     EQU  0x080:SHL:10   ;=0x0800000  
ROMEndPtr4      EQU  0x0A0:SHL:20   ;=0x0A00000  
PMC4            EQU  0x0            ; 0x0=Normal ROM, 0x1=4Word Page 
                                    ; 0x2=8Word Page, 0x3=16Word Page
rTpa4           EQU  (0x0:SHL:2)    ; 0x0=5Cycle, 0x1=2Cycle
                                    ; 0x2=3Cycle, 0x3=4Cycle 
rTacc4          EQU  (0x4:SHL:4)    ; 0x0=Disable, 0x1=2Cycle
                                    ; 0x2=3Cycle, 0x3=4Cycle
                                    ; 0x4=5Cycle, 0x5=6Cycle
                                    ; 0x6=7Cycle, 0x7=Reserved
rROMCON4   EQU  ROMEndPtr4+ROMBasePtr4+rTacc4+rTpa4+PMC4

; -- ROMCON5 : ROM Bank5 Control register ...........................

ROMBasePtr5     EQU  0x0A0:SHL:10   ;=0x0A00000  
ROMEndPtr5      EQU  0x0C0:SHL:20   ;=0x0C00000  
PMC5            EQU  0x0            ; 0x0=Normal ROM, 0x1=4Word Page 
                                    ; 0x2=8Word Page, 0x3=16Word Page
rTpa5           EQU  (0x0:SHL:2)    ; 0x0=5Cycle, 0x1=2Cycle
                                    ; 0x2=3Cycle, 0x3=4Cycle 
rTacc5          EQU  (0x4:SHL:4)    ; 0x0=Disable, 0x1=2Cycle
                                    ; 0x2=3Cycle, 0x3=4Cycle
                                    ; 0x4=5Cycle, 0x5=6Cycle
                                    ; 0x6=7Cycle, 0x7=Reserved
rROMCON5   EQU  ROMEndPtr5+ROMBasePtr5+rTacc5+rTpa5+PMC5

; -- DRAMCON0 : RAM Bank0 control register ..........................

rDRAMCON0   	EQU  0
rSDRAMCON0	EQU  0

; -- DRAMCON1 : RAM Bank1 control register ..........................

rDRAMCON1   	EQU  0
rSDRAMCON1	EQU  0

; -- DRAMCON2 : RAM Bank2 control register ..........................

rDRAMCON2   	EQU  0
rSDRAMCON2	EQU  0

; -- DRAMCON3 : RAM Bank3 control register ..........................

rDRAMCON3   	EQU  0
rSDRAMCON3	EQU  0


; -- REFEXTCON : External I/O & Memory Refresh cycle Control Register..

RefCycle        EQU   16   ;Unit [us], 1k refresh 16ms
;RefCycle        EQU   8   ;Unit [us], 1k refresh 16ms
CASSetupTime    EQU   0    ;0=1cycle, 1=2cycle
CASHoldTime     EQU   0    ;0=1cycle, 1=2cycle, 2=3cycle,
                           ;3=4cycle, 4=5cycle,
RefCycleValue   EQU   ((2048+1-(RefCycle*fMCLK)):SHL:21)
Tcsr            EQU   (CASSetupTime:SHL:20)   ; 1cycle
Tcs             EQU   (CASHoldTime:SHL:17)    
ExtIOBase       EQU   0x18360      ; Refresh enable, VSF=1
;
rREFEXTCON      EQU   RefCycleValue+Tcsr+Tcs+ExtIOBase

;-------------------------------------------------------------

;SRefCycle     EQU   16   ;Unit [us], 4k refresh 64ms
SRefCycle      EQU   8   ;Unit [us], 4k refresh 64ms
ROWcycleTime   EQU   3    ;0=1cycle, 1=2cycle, 2=3cycle,
                           ;3=4cycle, 4=5cycle,
SRefCycleValue  EQU   ((2048+1-(SRefCycle*fMCLK)):SHL:21)
STrc            EQU   (ROWcycleTime:SHL:17)    
rSREFEXTCON     EQU   SRefCycleValue+STrc+ExtIOBase

;-------------------------------------------------------------

	AREA start,CODE,READONLY

	ENTRY

start_sandstone
	B	sandstone_init1
	B	ex_undef
	B 	ex_swi
	B	ex_pabt
	B	ex_dabt
	NOP
	B	int_irq
	B	int_fiq

; -- Dummy Exception Handlers

; -- exception Routine : Undefined

ex_undef	B 	ex_undef

; -- exception Routine : SWI

ex_swi		B	ex_swi

; -- exception Routine : Data Abort

ex_dabt		B	ex_dabt

; -- exception Routine : Prefetch Abort

ex_pabt		B	ex_pabt

; -- interrupt Routine : IRQ

int_irq		B	int_irq

; -- interrupt Routine : FIQ

int_fiq		B	int_fiq


; *****************************************************************************
; *
; * Sandstone initialize 1  
; *
; * First phase of initialization is broken into 2 sections. 
; *
; * Section 1 - initializes the SYSTEM register of the 
; *             microcontroller
; *
; * Section 2 - allows the segment display to be used. 
; *             Initialization is complete when the 0 appears 
; *             on the display.
; *
; *****************************************************************************

; -- local settings

SEG_MASK	EQU	(0x1fc00)
nSEG_MASK	EQU 	~SEG_MASK

sandstone_init1

; -- Section 1 : Place the SYSTEM register to address 0x3ff00000. Disable 
; -- both the cache and write-buffer on the microcontroller.

	LDR	r3, =SYSCFG
	LDR	r4, =0x03FFFFA0   
	STR	r4, [r3]	  	

; -- Section 2 : Initialize the hardware to use the segment display.
                           	        
	LDR 	r2, =SEG_MASK
	LDR 	r3, =IOPMOD	
	LDR 	r4, [r3]
	ORR	r4, r4, r2
	STR	r4, [r3]

	LDR 	r3, =IOPDATA	
	LDR 	r4, [r3]
	ORR	r4, r4, r2
	STR	r4, [r3]

	LDR 	r2,=nSEG_MASK

; -- To show hardware is configured correctly display 0 on 
; -- the segment display. 

	LDR	r5,data_dis0
	BL	_e7t_setSegmentDisplay

; -- Continue to the next stage 

	B 	sandstone_memory

; -- Data Section 

data_dis0 	
	DCD 	0x00017c00

; *****************************************************************************
; *
; * Remap memory. First change the segment display to show 1 and then 
; * start to initialize memory.
; *
; * ROM -> 0x01800000-0x01880000
; * SRAM Bank 1 -> 0x00000000->0x00040000
; * SRAM Bank 2 -> 0x00040000->0x00080000
; *
; *****************************************************************************
	
sandstone_memory

; -- Set segment display to show 1

	LDR 	r5,data_dis1 
	BL	_e7t_setSegmentDisplay

; -- configure the memory 

	B 	sandstone_memorycode

; * Data Section for segment display 

data_dis1 	DCD 0x00001800

sandstone_memorycode

; -- Code for initializing memory. 
; -- This code maps the reset ROM away from address zero. It is 
; -- assummed that bank 1 control register is set to 0x60 up on 
; -- powerup

	LDR	sp,=0x3fec000 

	LDR   r3, =ROMCON1
	LDR   r3, [r3]
	CMP   r3, #0x0060

; -- Error handler should be placed here 

	MRS   r3, cpsr
	BIC   r3, r3, #0x1F
	ORR   r3, r3, #0xD3 
	MSR   cpsr_fc, r3

; -- Configure the System Manger to remap flashROM
; -- The Memory Bank Control Registers must be set using store 
; -- multpiles. Set up a stack in internal sram to preserve the 
; -- original register contents.

	MOV	r3, sp
	LDR	sp, =0x03FE2000
	STR	r3, [sp, #-4]!		; preserve previous sp on 
					; new stack ...............
	STMFD	sp!, {r0-r12,lr}
	LDR	lr, =sandstone_init2
	LDR	r4, =0x1800000
	ADD	lr,lr,r4

; -- Load in the target values into the control registers

   	ADRL    r0, memorymaptable_str
	LDMIA   r0, {r1-r12}
	LDR	r0, =EXTDBWTH

; -- remap and jump to ROM code

	STMIA   r0, {r1-r12}
	MOV	pc, lr

memorymaptable_str
	DCD rEXTDBWTH	; ROM0(Half), ROM1(Word), ROM1(Word), rest Disabled
	DCD rROMCON0	; 0x1800000 ~ 0x1880000, RCS0, 4Mbit, 4cycle
	DCD rROMCON1	; 0x0000000 ~ 0x0040000, RCS1, 256KB, 2cycle
   	DCD rROMCON2	; 0x0040000 ~ 0x0080000, RCS2, 256KB, 2cycle
	DCD rROMCON3	; 
	DCD rROMCON4	; 
	DCD rROMCON5	; 
	DCD rDRAMCON0   ; 
	DCD rDRAMCON1	; 
	DCD rDRAMCON2	; 
	DCD rDRAMCON3	; 
	DCD rREFEXTCON  ;

	ALIGN


; *****************************************************************************
; *
; * Intialize Communication Hardware
; * This code initializes the serial port and then outputs a 
; * Sandstone banner to that port.
; *
; *****************************************************************************
	
sandstone_init2

	LDR 	r5,data_dis4 
	BL	_e7t_setSegmentDisplay

	B 	sandstone_serialcode

; -- Data Section for segment display

data_dis4 	DCD 0x00019800

sandstone_serialcode

; -- equivalent to *(volatile unsigned *) (UART0_BASE + UCON) = 0;

   	LDR 	r1, =UART0_BASE
   	ADD 	r1, r1,#UCON
   	MOV 	r2, #0
   	STR 	r2, [r1]

; -- equivalent to *(volatile unsigned *) (UART0_BASE + ULCON) = (ULCR8bits);

	LDR 	r1, =UART0_BASE
   	ADD 	r1, r1,#ULCON
   	MOV 	r2, #ULCR8bits
   	STR 	r2, [r1]

; -- equivalent to *(volatile unsigned *) (UART0_BASE + UCON) = UCRRxM | UCRTxM;

	LDR 	r1, =UART0_BASE
   	ADD 	r1, r1, #UCON
   	MOV 	r2, #(UCRRxM | UCRTxM)
   	STR 	r2, [r1]
	
; -- equivalent to *(volatile unsigned *) (UART0_BASE + UBRDIV) = baud;

	LDR 	r1, =UART0_BASE
   	ADD 	r1, r1, #UBRDIV
   	MOV 	r2, #(BAUD_9600)
   	STR 	r2, [r1]

; -- Print Banner

	ADRL	r0,sandstone_banner

print_loop
print_wait
	
; -- equivalent to GET_STATUS(p)	(*(volatile unsigned  *)((p) + USTAT))

	LDR	r3,=UART0_BASE
	ADD	r3,r3,#USTAT
	LDR	r4,[r3]
	
; -- equivalent to TX_READY(s)    	((s) & USRTxHoldEmpty)	

	MOV	r5, #USRTxHoldEmpty
	AND	r4,r4,r5
	CMP	r4,#0
	BEQ	print_wait
			
; -- equivalent to PUT CHAR (*(unsigned  *)((p) + UTXBUF) = (unsigned )(c))

	LDR 	r3,=UART0_BASE
	ADD	r3,r3,#UTXBUF
	STR	r1,[r3]

	LDRB	r1,[r0]
	ADD	r0,r0,#1
	CMP 	r1,#0
	BNE	print_loop	

	B 	sandstone_load_and_boot 

; -- Data Section : Text banner

sandstone_banner
	DCB	"\n\r*\n\r"
	DCB 	"\n\rSandstone Firmware (0.01)\n\r"
	DCB	"- platform ......... e7t\n\r"
	DCB	"- status ........... alive\n\r"
	DCB     "- memory ........... remapped\n\r"
	DCB	"\n\r+ booting payload ...",0

; *****************************************************************************
; *
; * Copying and passing control over to the Payload
; * This occurs in two sections. The first copies the payload to
; * address 0x0000000 and the second section pass control over to 
; * the payload by updating the PC directly.
; *
; *****************************************************************************

	ALIGN 4

sandstone_load_and_boot

; -- Section 1 : Copy payload to address 0x00000000

	MOV	r13,#0

	LDR	r12,payload_start_address
	LDR	r14,payload_end_address

block_copy	
	LDMIA	r12!,{r0-r11}
	STMIA   r13!,{r0-r11}
	CMP	r12,r14
	BLE	block_copy
	
; -- Section 2 : Relingish control over to the payload

	MOV	pc,#0

     LTORG
     
; -- Data Section : Payload information inserted at build time.

payload_start_address
	DCD     startAddress
payload_end_address
	DCD     endAddress
	
; * -- _e7t_setSegmentDisplay ------------------------------------------
; *
; * Description : set the segment display on the E7T platform 
; * 
; * Parameters	: register r5 - contains the new value...
; * Return    	: none...
; * Notes	: none...
; *

_e7t_setSegmentDisplay

	LDR 	r2,=nSEG_MASK
	LDR 	r3,=IOPDATA	
	LDR 	r4,[r3]
	AND 	r4,r4,r2
	STR 	r4,[r3]
	LDR 	r5,data_dis1 
	ORR 	r4,r4,r5
	STR 	r4,[r3]	
	MOV 	pc,lr

startAddress
     INCBIN ../../payload/slos.bin
endAddress
	END

