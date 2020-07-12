; ***************************************************************************
; * Simple Little Operating System - SLOS
; ***************************************************************************

; ***************************************************************************
; *
; * Module     : sal.s
; * Project	: SLOS
; * Version	: 0.09
; * Originator	: Andrew N. Sloss
; * History    :
; * 
; * 16th July 2003 Andrew N. Sloss
; * - added header information
; *
; ***************************************************************************

     EXPORT    applicationLoader
     IMPORT    initSetUpStacks

     AREA APPLOADER,CODE,READONLY

; -- applicationLoader ------------------------------------------------------
;
; Descriptions : application loader
;
; Parameters   :
; Return       :
; Notes        :
; 

applicationLoader 

     LDR     r11,=ALT

applicationLoaderLoop
     LDR     r12,[r11],#4
     LDR     r14,[r11],#4
     LDR     r13,[r11],#4

     CMP     r13,#0
     BEQ     initSetUpStacks

applicationBlockCopy

     LDMIA   r12!,{r0-r10}
     STMIA   r13!,{r0-r10}
     CMP     r12,r14
     BLE     applicationBlockCopy
     B       applicationLoaderLoop

; ******************************************************************
; *
; * Application Loader Table
; *
; ******************************************************************

ALT
; entry into the table
; {
; src_startaddr
; src_endaddr
; dest_addr
; }

; task (3)

     DCD    task3start
     DCD    task3end
     DCD    0x30000

; task (2)

     DCD    task2start
     DCD    task2end
     DCD    0x28000

; task (1)

     DCD    task1start 
     DCD    task1end
     DCD    0x20000

; Terminate

     DCD     0
     DCD     0
     DCD     0


     AREA    zzzAIB,DATA,READONLY

	ALIGN 4
task1start
     INCBIN ../image/apps/task1.bin
task1end
task2start
     INCBIN ../image/apps/task2.bin
task2end
task3start
     INCBIN ../image/apps/task3.bin
task3end
     END
