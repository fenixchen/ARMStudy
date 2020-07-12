@ ; ***************************************************************************
@ ; * Simple Little Operating System - SLOS
@ ; ***************************************************************************

@ ; ***************************************************************************
@ ; *
@ ; * Module     : mpupcb.s
@ ; * OS         : SLOS
@ ; * Version	: 0.09
@ ; * Originator	: Andrew N. Sloss
@ ; *
@ ; * 14 July 2003 Andrew N. Sloss
@ ; * - separated the pcbSetUp routine
@ ; *
@ ; ***************************************************************************

     .text
     .code 32
     .align 0
     .global pcbSetup
     .global MpuPCB_CurrentTask
     .global MpuPCB_Table
     .global MpuPCB_TopOfIRQStack
     .global MpuPCB_PtrCurrentTask
     .global MpuPCB_PtrNextTask
     .global MpuPCB_PtrTask1
     .global MpuPCB_BottomTask1
     .global MpuPCB_RegionTable1
     .global MpuPCB_PtrTask2
     .global MpuPCB_BottomTask2
     .global MpuPCB_RegionTable1
     .global MpuPCB_PtrTask3
     .global MpuPCB_BottomTask3
     .global MpuPCB_RegionTable1
     .global pcbSetUp

@ ; -- pcbSetUp ---------------------------------------------------------------
@ ;
@ ; Description : PCB setup 
@ ;
@ ; Parameters  : r0=<thread entry address>
@ ;               r1=<PCB Address>
@ ;               r2=<stack address>
@ ; Return      : setup PCB
@ ; Notes       :
@ ;

pcbSetUp:
     STR     r0,[r1,#-4]          
     STR     r0,[r1,#-64]      
     STR     r2,[r1,#-8]     
     MOV     r0,#0x50             
     STR     r0,[r1,#-68] 
     MOV     pc,lr

MpuPCB_Table:
     .word   MpuPCB_PtrTask1
     .word   MpuPCB_PtrTask2
     .word   MpuPCB_PtrTask3

MpuPCB_TopOfIRQStack:
     .word   0x9000                      @ ; real value

MpuPCB_PtrCurrentTask:
     .word   0x1

MpuPCB_PtrNextTask:
     .word   0x1

MpuPCB_CurrentTask:
     .word   0x1

@ ; -----------------------------------------------------------
@ ; Task(1): Full MPU PCB 
@ ; mpupcb 
@ ; {
@ ; PCB
@ ; RegionTable
@ ; }
@ ; -----------------------------------------------------------

MpuPCB_BottomTask1:
     .skip 72
MpuPCB_PtrTask1:

MpuPCB_RegionTable1:
     .word   0x20000          @ ; base address 
     .word   14 	      @ ; SIZE_32K address 
     .word   (3<<4)+(3)       @ ; permissions (RWXRWX)
     .word   6                @ ; cache and write through
     .word   1                @ ; R_ENABLED

@ ; -----------------------------------------------------------
@ ; Task(2): Full MPU PCB 
@ ; mpupcb 
@ ; {
@ ; PCB
@ ; RegionTable
@ ; }
@ ; -----------------------------------------------------------

MpuPCB_BottomTask2:
     .skip 72
MpuPCB_PtrTask2:

MpuPCB_RegionTable2:
     .word   0x28000 	   @ ; base address 
     .word   14            @ ; SIZE_32K address 
     .word   (3<<4)+(3)	   @ ; permissions (RWXRWX)
     .word   6             @ ; cache and write through
     .word   1             @ ; R_ENABLED

@ ; -----------------------------------------------------------
@ ; Task(3): Full MPU PCB 
@ ; mpupcb 
@ ; {
@ ; PCB
@ ; RegionTable
@ ; }
@ ; -----------------------------------------------------------

MpuPCB_BottomTask3:
     .skip 72
MpuPCB_PtrTask3:

MpuPCB_RegionTable3:
     .word   0x30000       @ ; base address 
     .word   14            @ ; SIZE_32K address 
     .word   (3<<4)+(3)	   @ ; permissions (RWXRWX)
     .word   6             @ ; cache and write through
     .word   1             @ ; R_ENABLED
     .end
