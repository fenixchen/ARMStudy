; ****************************************************************************
; * Simple Little Operating System - SLOS
; ****************************************************************************

; ****************************************************************************
; *
; * Module     : scheduler.s
; * Project	: SLOS
; * Version	: 0.09
; * Originator	: Andrew N. Sloss
; * History    :
; * 
; * 16th July 2003 Andrew N. Sloss
; * - added header information
; *
; ****************************************************************************

     IMPORT     MpuPCB_CurrentTask
     IMPORT     MpuPCB_PtrCurrentTask
     IMPORT     MpuPCB_PtrNextTask
     IMPORT     MpuPCB_Table
     IMPORT     MpuPCB_TopOfIRQStack
     IMPORT     mpuScheduleRegion2

     EXPORT	 kernelScheduler

     AREA SCHEDULER,CODE,READONLY

kernelScheduler

; ---------------------------------------------------
; Round Robin Scheduler
; ---------------------------------------------------

CurrentTask
     LDR     r3,=MpuPCB_CurrentTask
     LDR     r0,[r3]                ; r0 = Current Task ID
     LDR     r1,=MpuPCB_Table
     LDR     r1,[r1,r0,LSL#2]       ; r1 = address of current task
     LDR     r2,=MpuPCB_PtrCurrentTask
     STR     r1,[r2]	            ; save current structure task
; ** PCB_PtrCurrentTask - updated with the new address
NextTask
     ADD     r0,r0,#1               ; r0 = Current_Task+1
     CMP     r0,#3
     MOVEQ   r0,#0                  ; if r0==MaxTask then r0=0
     STR     r0,[r3]                ; save new Task ID
; change Region2 to the new task
     BL      mpuScheduleRegion2	    ; change region
; complete the new task information
     LDR     r1,=MpuPCB_Table
     LDR     r1,[r1,r0,LSL#2]       ; r1 = new next task PCB address
     LDR     r0,=MpuPCB_PtrNextTask
     STR     r1,[r0]                ; save current structure task

; ** MpuPCB_PtrCurrentTask = current PCB
; ** MpuPCB_PtrNextTask	= next PCB
; ** MpuPCB_CurrentTask	= new TASK_ID

; ---------------------------------------------------
; Context Switch
; ---------------------------------------------------

handler_contextswitch
     LDMFD   sp!,{r0-r3,r12,r14}     ; restore remaining registers
     LDR     r13,=MpuPCB_PtrCurrentTask
     LDR     r13,[r13]               ; load current PCB
     SUB     r13,r13,#60
     STMIA   r13,{r0-r14}^           ; store the User reg into current PCB
     MRS     r0, SPSR
     STMDB   r13,{r0,r14}
     LDR     r13,=MpuPCB_PtrNextTask
     LDR     r13,[r13]
     SUB     r13,r13,#60             ; load and position next PCB
     LDMDB   r13,{r0,r14}            ; load the new task
     MSR     spsr_cxsf, r0
     LDMIA   r13,{r0-r14}^           ; load User regs
     LDR     r13,=MpuPCB_TopOfIRQStack
     LDR     r13,[r13]               ; load IRQ stack
     MOVS    pc,r14                  ; return next task
     END
