@ ****************************************************************************
@ * Simple Little Operating System - SLOS
@ ****************************************************************************

@ ****************************************************************************
@ *
@ * Module     : init.s
@ * OS         : SLOS
@ * Version	: 0.09
@ * Originator	: Andrew N. Sloss
@ *
@ * 14 July 2003 Andrew N. Sloss
@ * - separated the pcbSetUp routine
@ *
@ ****************************************************************************

     .text
     .code 32
     .align 0
     .global coreInitialize
     .extern C_Entry
     .extern MpuPCB_PtrTask2
     .extern MpuPCB_PtrTask3
     .extern mpuInitFlush
     .extern C_EntryTask2
     .extern C_EntryTask3
     .extern MpuPCB_CurrentTask
     .extern applicationLoader
     .extern pcbSetUp
     .global initSetUpStacks
     
     .extern coreCallSWI

     .equ IRQ32md, 0x12
     .equ SVC32md, 0x13
     .equ SYS32md, 0x1f
     .equ NoInt, 0xc0

coreInitialize:

     BL     mpuInitFlush
     BL     bringUpInitFIQRegisters
     B      applicationLoader

/*
@ ------------------------------------------------
@ Setup stacks for SVC,IRQ,SYS&USER 
@ Mode = SVC 
@ ------------------------------------------------
*/
initSetUpStacks:

     MOV     sp,#0x10000	  @ ; Kernel Stack
     MSR     CPSR_c,#NoInt|SYS32md
     MOV     sp,#0x28000	  @ ; System Stack=0x28000 
     MSR     CPSR_c,#NoInt|IRQ32md
     MOV     sp,#0x9000	          @ ; IRQ Stack=0x9000
     MSR     CPSR_c,#NoInt|SVC32md

/*
@ ------------------------------------------------
@ Setup Task Process Control Block (PCB).
@ Mode = SVC
@ ------------------------------------------------
*/
     MOV     r0,#0x28000          @ ; Task2
     LDR     r1,=MpuPCB_PtrTask2
     MOV     r2,#0x30000
     BL      pcbSetUp

     MOV     r0,#0x30000          @ ; Task3
     LDR     r1,=MpuPCB_PtrTask3
     MOV     r2,#0x38000
     BL      pcbSetUp
     
@ ; -- set the current ID to TASK1 ...........

     LDR     r0, =MpuPCB_CurrentTask
     MOV     r1, #0
     STR     r1,[r0]              @ ; first task ID=0
     LDR     lr,=C_Entry
     MOV     pc,lr                @ ; call C_Entry
     .end

