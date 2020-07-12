; ****************************************************************************
; * Simple Little Operating System - SLOS
; ****************************************************************************

; ****************************************************************************
; *
; * Module     : init.s
; * OS         : SLOS
; * Version	: 0.09
; * Originator	: Andrew N. Sloss
; *
; * 14 July 2003 Andrew N. Sloss
; * - separated the pcbSetUp routine
; *
; ****************************************************************************

; ------------------------------------------------
; IMPORT/EXPORT key functions
; ------------------------------------------------

     EXPORT     coreInitialize
     EXPORT     initSetUpStacks

     IMPORT     MpuPCB_PtrTask2
     IMPORT     MpuPCB_PtrTask3
     IMPORT     mpuInitFlush
     IMPORT     bringupInitFIQRegisters
     IMPORT     C_Entry
     IMPORT     MpuPCB_CurrentTask
     IMPORT     applicationLoader
     IMPORT     pcbSetUp

; ------------------------------------------------
; Define useful constants 
; ------------------------------------------------

IRQ32md   EQU   0x12
SVC32md   EQU   0x13
SYS32md   EQU   0x1f
NoInt     EQU   0xc0

     AREA INITSLOS,CODE,READONLY

; ------------------------------------------------
; Start initializing the core parts 
; ------------------------------------------------

coreInitialize


     BL     mpuInitFlush
     BL     bringupInitFIQRegisters
     B      applicationLoader

; ------------------------------------------------
; Setup stacks for SVC|IRQ|SYS&USER 
; Mode = SVC
; ------------------------------------------------

initSetUpStacks

     MOV     sp,#0x10000	  ; Kernel Stack
     MSR     CPSR_c,#NoInt|SYS32md
     MOV     sp,#0x28000	  ; System Stack=0x28000 
     MSR     CPSR_c,#NoInt|IRQ32md
     MOV     sp,#0x9000	          ; IRQ Stack=0x9000
     MSR     CPSR_c,#NoInt|SVC32md

; ------------------------------------------------
; Setup Task Process Control Block (MPUPCB).
; Mode = SVC
; ------------------------------------------------

     MOV     r0,#0x28000          ; Task2
     LDR     r1,=MpuPCB_PtrTask2
     MOV     r2,#0x30000
     BL      pcbSetUp

     MOV     r0,#0x30000          ; Task3
     LDR     r1,=MpuPCB_PtrTask3
     MOV     r2,#0x38000
     BL      pcbSetUp
     
; -- set the current ID to TASK1 ...........

     LDR     r0, =MpuPCB_CurrentTask
     MOV     r1, #0
     STR     r1,[r0]              ; first task ID=0
     LDR     lr,=C_Entry
     MOV     pc,lr                ; call C_Entry
     END
