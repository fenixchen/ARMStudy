; ****************************************************************************
; * Simple Little Operating System - SLOS
; ****************************************************************************

; ****************************************************************************
; *
; * Module     : mpupcb.s
; * OS         : SLOS
; * Version	: 0.09
; * Originator	: Andrew N. Sloss
; *
; * 14 July 2003 Andrew N. Sloss
; * - separated the pcbSetUp routine
; *
; ****************************************************************************


     EXPORT     MpuPCB_CurrentTask
     EXPORT     MpuPCB_Table
     EXPORT     MpuPCB_TopOfIRQStack
     EXPORT     MpuPCB_PtrCurrentTask
     EXPORT     MpuPCB_PtrNextTask
     EXPORT     MpuPCB_PtrTask1
     EXPORT     MpuPCB_BottomTask1
     EXPORT     MpuPCB_RegionTable1
     EXPORT     MpuPCB_PtrTask2
     EXPORT     MpuPCB_BottomTask2
     EXPORT     MpuPCB_RegionTable2
     EXPORT     MpuPCB_PtrTask3
     EXPORT     MpuPCB_BottomTask3
     EXPORT     MpuPCB_RegionTable3
     EXPORT     pcbSetUp

; -- pcbSetUp ----------------------------------------------------------------
;
; Description : PCB setup 
;
; Parameters  : r0=<thread entry address>
;               r1=<PCB Address>
;               r2=<stack address>
; Return      : setup PCB
; Notes       :
;

     AREA PCBSetUp,CODE,READWRITE 
pcbSetUp
     STR     r0,[r1,#-4]          ; PCB[-4]=C_TaskEntry<2>
     STR     r0,[r1,#-64]         ; PCB[-64]=C_TaskEntry<2>
     STR     r2,[r1,#-8]          ; PCB[-8]=<stack address>
     MOV     r0,#0x50             
     STR     r0,[r1,#-68]         ; PCB[-68]=iFt_User
     MOV     pc,lr

     AREA MpuPCBTable,DATA,READWRITE

MpuPCB_Table
     DCD     MpuPCB_PtrTask1
     DCD     MpuPCB_PtrTask2
     DCD     MpuPCB_PtrTask3

     AREA MpuPCBIRQ,DATA,READWRITE
MpuPCB_TopOfIRQStack
     DCD     0x9000                      ; real value

     AREA MpuPCBPtrCURRENT,DATA,READWRITE
MpuPCB_PtrCurrentTask
     DCD     0x1

	AREA MpuPCBPtrNEXT,DATA,READWRITE
MpuPCB_PtrNextTask
     DCD     0x1

	AREA MpuPCBActive,DATA,READWRITE
MpuPCB_CurrentTask
     DCD     0x1

; -----------------------------------------------------------
; Task(1): Full MPU PCB 
; mpupcb 
; {
; PCB
; RegionTable
; }
; -----------------------------------------------------------

     AREA PCB1,DATA,READWRITE

MpuPCB_BottomTask1
     % 72
MpuPCB_PtrTask1

MpuPCB_RegionTable1
     DCD     0x20000          ; base address 
     DCD     14 		     ; SIZE_32K address 
     DCD     (3<<4)+(3)	     ; permissions (RWXRWX)
     DCD     6                ; cache and write through
     DCD     1		          ; R_ENABLED

; -----------------------------------------------------------
; Task(2): Full MPU PCB 
; mpupcb 
; {
; PCB
; RegionTable
; }
; -----------------------------------------------------------

     AREA PCB2,DATA,READWRITE

MpuPCB_BottomTask2
     % 72
MpuPCB_PtrTask2

MpuPCB_RegionTable2
     DCD     0x28000 	   ; base address 
     DCD     14 		   ; SIZE_32K address 
     DCD     (3<<4)+(3)	   ; permissions (RWXRWX)
     DCD     6		        ; cache and write through
     DCD     1              ; R_ENABLED

; -----------------------------------------------------------
; Task(3): Full MPU PCB 
; mpupcb 
; {
; PCB
; RegionTable
; }
; -----------------------------------------------------------

     AREA PCB3,DATA,READWRITE

MpuPCB_BottomTask3
     % 72
MpuPCB_PtrTask3

MpuPCB_RegionTable3
     DCD     0x30000          ; base address 
     DCD     14 		     ; SIZE_32K address 
     DCD     (3<<4)+(3)	     ; permissions (RWXRWX)
     DCD     6		          ; cache and write through
     DCD     1                ; R_ENABLED
     END
