; ****************************************************************************
; * Simple Little Operating System - SLOS
; ****************************************************************************

; ****************************************************************************
; *
; * Module     : init.s
; * Project	: SLOS
; * Version	: 0.09
; * Originator	: Andrew N. Sloss
; * History    :
; * 
; * 16th July 2003 Andrew N. Sloss
; * - added header information
; *
; ****************************************************************************

; ------------------------------------------------
; IMPORT/EXPORT key functions
; ------------------------------------------------

     EXPORT     coreInitialize
     EXPORT     initSetUpStacks

     IMPORT     MmuPCB_PtrTask2
     IMPORT     MmuPCB_PtrTask3
     IMPORT     mmuFlushCache
     IMPORT     bringupInitFIQRegisters
     IMPORT     C_Entry
     IMPORT     MmuPCB_CurrentTask
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

     BL   mmuFlushCache
     BL   bringupInitFIQRegisters
     B    applicationLoader

; ------------------------------------------------
; Setup stacks for SVC|IRQ|SYS&USER 
; Mode = SVC
; ------------------------------------------------

initSetUpStacks

     MOV     sp,#0x10000           ; Kernel Stack
     MSR     CPSR_c,#NoInt|SYS32md
     LDR     sp,=0x408000          ; System Stack=0x408000
     MSR     CPSR_c,#NoInt|IRQ32md
     MOV     sp,#0x9000	          ; IRQ Stack = 0x9000
     MSR     CPSR_c,#NoInt|SVC32md

; ------------------------------------------------
; Setup Task Process Control Block (MPUPCB).
; Mode = SVC
; ------------------------------------------------

     LDR     r0,=0x400000          ; Task 2
     LDR     r1,=MmuPCB_PtrTask2
     LDR     r2,=0x408000
     BL      pcbSetUp
     
     LDR     r0,=0x400000          ; Task 3
     LDR     r1,=MmuPCB_PtrTask3
     LDR     r2,=0x408000
     BL      pcbSetUp

; -- set the current ID to TASK1 ...........

     LDR     r0, =MmuPCB_CurrentTask
     MOV     r1, #0
     STR     r1,[r0]              ; first task ID=0
     LDR     lr,=C_Entry
     MOV     pc,lr                ; enter the CEntry world
     END
