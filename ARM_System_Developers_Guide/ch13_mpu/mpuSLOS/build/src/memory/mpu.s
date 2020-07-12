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
; ****************************************************************************
; * Simple Little Operating System - mpuSLOS
; ****************************************************************************

; ****************************************************************************
; *
; * Module      : mpu.s
; * Description : provides a set of simple MPU routines
; * Platform    : CM940IAP
; * History     :
; *
; * 4 July 2002 (Independence Day) Andrew N. Sloss 
; * - taken from Chris Wright MPU example
; *
; ****************************************************************************

; ****************************************************************************
; * IMPORT/EXPORT
; ****************************************************************************

   IMPORT MpuPCB_Table

   EXPORT mpuInitFlush
   EXPORT mpuRegionDefine    
   EXPORT mpuRegionStdAccess    
   EXPORT mpuRegionExtAccess    
   EXPORT mpuRegionCB
   EXPORT mpuRegionEnable    
   EXPORT mpuChangeControl    
   EXPORT mpuScheduleRegion2

; ****************************************************************************
; * ROUTINES
; ****************************************************************************

   AREA MPU,CODE,READONLY

mpuInitFlush

   MOV r0, #0x78
   MCR p15, 0x0, r0, c1, c0, 0x0  ;
   MOV r0, #0x0 
   MCR p15, 0x0, r0, c7, c5, 0x0  ; invalidate instruction cache
   MCR p15, 0x0, r0, c7, c6, 0x0  ; invalidate data cache

   MOV pc,lr
   
;-----------------
; Change Control Register Values
; int changeControl(unsigned value, unsigned mask)
;-----------------   

mpuChangeControl
   MVN r2, r1                ; invert mask
   BIC r3, r0, r2            ; clear values that are not masked
   CMP r3, r0
   BNE ErrorControl          ; values outside of mask set 
   MRC p15, 0, r3, c1, c0, 0 ; get control register values
   BIC r3, r3, r1            ; mask off bit that change
   ORR r3, r3, r0            ; set value of bits that change
   MCR p15, 0, r3, c1, c0, 0 ; set control register values
   MOV r0, #0
   MOV pc, lr

;-----------------
; Define Data Region Base and Size
; int mpuRegionDefine(unsigned region, unsigned base, unsigned size)
;-----------------   

mpuRegionDefine

mpuRegionDefineErrorCheck
   CMP r2, #11                ; check if size value too small (<11)
   BLO ErrorSize              ; ERROR: region size to small
   CMPHI r2, #31              ; check if size value too large (>31)
   BHI ErrorSize              ; ERROR: region size too large

   ADD r12, r2, #1            ; adjust multiple of size (off by one)
   MOV r3, r1, lsr r12        ; clear trailing zeros part1
   MOV r3, r3, lsl r12        ; clear trailing zeros part2
   CMP r1, r3                 ; check if Address is aligned on size
   BHI ErrorAddress           ; ERROR: address is not aligned

   ORR r3, r3, r2, lsl #1     ; combine size and base address
   MOV r12, r0                ; clear r0 for return value
   MOV r0 , #0			         ; set return value to zero
   CMP r12, #8                ; check if region is in range
   ADDLO pc, pc, r12, lsl #4  ; branch to base and size routine 
                              ; lsl value (940T=#4 740/946=#3)
   B  ErrorRegion             ; ERROR: Region to large, pad for jump

defineRegion0                 ; defining region disables region
   MCR p15, 0, r3, c6, c0, 0  ; set Dregion base and size
   MCR p15, 0, r3, c6, c0, 1  ; set Iregion base and size, 940T only
   MOV pc, lr                 ; region set return
   NOP                        ; pad for jump, remove in 740T/946ES

defineRegion1                 ; defining region disables region
   MCR p15, 0, r3, c6, c1, 0  ; set Dregion base and size
   MCR p15, 0, r3, c6, c1, 1  ; set Iregion base and size, 940T only
   MOV pc, lr                 ; region set return
   NOP                        ; pad for jump, remove in 740T/946ES

defineRegion2                 ; defining region disables region
   MCR p15, 0, r3, c6, c2, 0  ; set Dregion base and size
   MCR p15, 0, r3, c6, c2, 1  ; set Iregion base and size, 940T only
   MOV pc, lr                 ; region set return
   NOP                        ; pad for jump, remove in 740T/946ES

defineRegion3                 ; defining region disables region
   MCR p15, 0, r3, c6, c3, 0  ; set Dregion base and size
   MCR p15, 0, r3, c6, c3, 1  ; set Iregion base and size, 940T only
   MOV pc, lr                 ; region set return
   NOP                        ; pad for jump, remove in 740T/946ES

defineRegion4                 ; defining region disables region
   MCR p15, 0, r3, c6, c4, 0  ; set Dregion base and size
   MCR p15, 0, r3, c6, c4, 1  ; set Iregion base and size, 940T only
   MOV pc, lr                 ; region set return
   NOP                        ; pad for jump, remove in 740T/946ES

defineRegion5                 ; defining region disables region
   MCR p15, 0, r3, c6, c5, 0  ; set Dregion base and size
   MCR p15, 0, r3, c6, c5, 1  ; set Iregion base and size, 940T only
   MOV pc, lr                 ; region set return
   NOP                        ; pad for jump, remove in 740T/946ES

defineRegion6                 ; defining region disables region
   MCR p15, 0, r3, c6, c6, 0  ; set Dregion base and size
   MCR p15, 0, r3, c6, c6, 1  ; set Iregion base and size, 940T only
   MOV pc, lr                 ; region set return
   NOP                        ; pad for jump, remove in 740T/946ES

defineRegion7                 ; defining region disables region
   MCR p15, 0, r3, c6, c7, 0  ; set Dregion base and size
   MCR p15, 0, r3, c6, c7, 1  ; set Iregion base and size, 940T only
   MOV pc, lr                 ; region set return


;-----------------
; Define Access Permissions 
; int mpuRegionStdAccess(unsigned region, unsigned ap)
;-----------------   

mpuRegionStdAccess
   CMP r0, #0x7               ; check if region is in range
   BHI ErrorRegion            ; ERROR: Region out of Range
   TST r1, #0xCC              ; check extended permission use
   BNE ErrorPermission        ; ERROR: Use of Extended Permissions
   MOV r0, r0, lsl #1         ; double region number ap is 2bits
   MOV r2, #3                 ; set mask 2 bits wide

setStdDAP
   MRC p15, 0, r3, c5, c0, 0  ; get D access permissions
   BIC r3, r3, r2, lsl r0     ; clear D ap bits
   AND r12, r1, #0x3          ; clear all except std D AP bits   
   ORR r3, r3, r12, lsl r0    ; set std D AP bits
   MCR p15, 0, r3, c5, c0, 0  ; set std access permissions

setStdIAP
   MRC p15, 0, r3, c5, c0, 1  ; get I access permissions
   BIC r3, r3, r2, lsl r0     ; clear I ap bits
   MOV r1, r1, lsr #4         ; shift I AP bits in position
   AND r12, r1, #0x3          ; clear all except std I AP bits   
   ORR r3, r3, r12, lsl r0    ; set std D AP bits
   MCR p15, 0, r3, c5, c0, 1  ; set std access permissions

   MOV r0, #0                 ; success
   MOV pc, lr                 ; region set return
;-----------------
; Define Access Permissions 
; int mpuRegionExtAccess(unsigned region, unsigned ap)
;-----------------   

mpuRegionExtAccess
   CMP r0, #0x7               ; check if region is in range
   BHI ErrorRegion            ; ERROR: Region out of Range
   TST r1, #0x88              ; check unpredictable ext permission
   BNE ErrorPermission        ; ERROR: unpredicable use Ext Permissions

   MOV r12, #4
   TEQ r12, r1, lsr #4        ; check inst permission 0x100 unpredicable
   MOV r12, #7
   TEQNE r12, r1, lsr #4      ; check inst permission 0x111 unpredicable
   BEQ ErrorPermission        ; ERROR: unpredicable use Ext Permissions

   AND r12, r1, #0xf
   TEQ r12, #4                ; check data permission 0x100 unpredicable
   TEQNE r12, #7              ; check data permission 0x111 unpredicable
   BEQ ErrorPermission        ; ERROR: unpredicable use Ext Permissions
                              ; 
   MOV r0, r0, lsl #1         ; double region number ap is 2bits
   MOV r2, #3                 ; set mask 2 bits wide

setExtDAP
   MRC p15, 0, r3, c5, c0, 2  ; get D access permissions
   BIC r3, r3, r2, lsl r0     ; clear D ap bits
   AND r12, r1, #0xf          ; clear all except ext D AP bits   
   ORR r3, r3, r12, lsl r0    ; set ext D AP bits
   MCR p15, 0, r3, c5, c0, 2  ; set ext access permissions

setExtIAP
   MRC p15, 0, r3, c5, c0, 3  ; get I access permissions
   BIC r3, r3, r2, lsl r0     ; clear I ap bits
   MOV r1, r1, lsr #4         ; shift I AP bits in position
   ORR r3, r3, r12, lsl r0    ; set ext D AP bits
   MCR p15, 0, r3, c5, c0, 3  ; set ext access permissions

   MOV r0, #0                 ; success
   MOV pc, lr                 ; region set return

;-----------------
; Set Cache and Buffer for Instruction and Data Regions
; mpuRegionCB(unsigned region, unsigned CB)
;-----------------   

mpuRegionCB
   CMP r0, #0x7               ; check if region is in range
   CMPLE r1, #0x7             ; check if CCB in range
   BHI  OutOfRange            ; jump to the error handler
   MOV r2, #1                 ; set bit mask 1 bit

setBuffer
   MRC p15, 0, r3, c3, c0, 0  ; get buffer info
   BIC r3, r3, r2, lsl r0     ; clear buffer bit
   BIC r12, r1, #0x6          ; clear I D cache part of CB   
   ORR r3, r3, r12, lsl r0    ; set buffer bit
   MCR p15, 0, r3, c3, c0, 0  ; set buffer bit for region

setDCache
   MRC p15, 0, r3, c2, c0, 0  ; get D cache info
   BIC r3, r3, r2, lsl r0     ; clear D cache bit
   MOV r1, r1, lsr #1         ; drop buffer bit move D cache in position
   BIC r12, r1, #0x2          ; clear I cache part of CB   
   ORR r3, r3, r1, lsl r0     ; set D cache bit
   MCR p15, 0, r3, c2, c0, 0  ; set D cache for region

setICache
   MRC p15, 0, r3, c2, c0, 1  ; get I cache info
   BIC r3, r3, r2, lsl r0     ; clear I cache bit
   MOV r1, r1, lsr #1         ; drop D cache bit move I cache in position
   ORR r3, r3, r1, lsl r0     ; set I cache bit
   MCR p15, 0, r3, c2, c0, 1  ; set I cache for region


  MOV r0, #0                 ; success
  MOV pc, lr                 ; return

;-----------------
; Enable Region
; int mpuRegionEnable(unsigned region, unsigned enable)
;-----------------

mpuRegionEnable
   CMP r0, #7                 ; check if region is in range
   CMPLE r1, #1
   BHI  OutOfRange            ; ERROR handler

   MOV r2, r0                 ; r3 = region
   MOV r0, #0                 ; set function success
   MOV     r12, pc            ; Load address of jump table
   LDR     pc, [r12,r2,LSL#2] ; Jump to the routine
EnableJumpTable
   DCD     enableRegion0
   DCD     enableRegion1
   DCD     enableRegion2
   DCD     enableRegion3
   DCD     enableRegion4
   DCD     enableRegion5
   DCD     enableRegion6
   DCD     enableRegion7

enableRegion0                 ; set region 0 enable
   MRC p15, 0, r3, c6, c0, 0  ; get D region 0 base and size
   BIC r3, r3, #1             ; clear D region enable       
   ORR r3, r3, r1             ; set enable or disable D region 
   MCR p15, 0, r3, c6, c0, 0  ; set D region 0 enable

   MRC p15, 0, r3, c6, c0, 1  ; get region 0 base and size
   BIC r3, r3, #1             ; clear D region enable       
   ORR r3, r3, r1             ; set I enable or disable region 
   MCR p15, 0, r3, c6, c0, 1  ; set I region 0 enable
   MOV pc, lr                 ; region set return

enableRegion1                 ; define D region disables region
   MRC p15, 0, r3, c6, c1, 0  ; get D region 1 base and size
   BIC r3, r3, #1             ; clear D region enable       
   ORR r3, r3, r1             ; set enable or disable D region 
   MCR p15, 0, r3, c6, c1, 0  ; set D region 1 enable

   MRC p15, 0, r3, c6, c1, 1  ; get I region 1 base and size
   BIC r3, r3, #1             ; clear D region enable       
   ORR r3, r3, r1             ; set enable or disable I region 
   MCR p15, 0, r3, c6, c1, 1  ; set I region 1 enable
   MOV pc, lr                 ; region set return

enableRegion2                 ; define region disables region
   MRC p15, 0, r3, c6, c2, 0  ; get D region 2 base and size
   BIC r3, r3, #1             ; clear D region enable       
   ORR r3, r3, r1             ; set enable or disable D region 
   MCR p15, 0, r3, c6, c2, 0  ; set D region 2 enable

   MRC p15, 0, r3, c6, c2, 1  ; get I region 2 base and size
   BIC r3, r3, #1             ; clear D region enable       
   ORR r3, r3, r1             ; set enable or disable I region 
   MCR p15, 0, r3, c6, c2, 1  ; set I region 2 enable
   MOV pc, lr                 ; region set return

enableRegion3                 ; define region disables region
   MRC p15, 0, r3, c6, c3, 0  ; get D region 3 base and size
   BIC r3, r3, #1             ; clear D region enable       
   ORR r3, r3, r1             ; set enable or disable D region 
   MCR p15, 0, r3, c6, c3, 0  ; set D region 3 enable

   MRC p15, 0, r3, c6, c3, 1  ; get region 3 base and size
   BIC r3, r3, #1             ; clear D region enable       
   ORR r3, r3, r1             ; set enable or disable I region 
   MCR p15, 0, r3, c6, c3, 1  ; set I region 3 enable
   MOV pc, lr                 ; region set return

enableRegion4                 ; define region disables region
   MRC p15, 0, r3, c6, c4, 0  ; get D region 4 base and size
   BIC r3, r3, #1             ; clear D region enable       
   ORR r3, r3, r1             ; set enable or disable D region 
   MCR p15, 0, r3, c6, c4, 0  ; set D  region 4 enable

   MRC p15, 0, r3, c6, c4, 1  ; get I region 4 base and size
   BIC r3, r3, #1             ; clear D region enable       
   ORR r3, r3, r1             ; set enable or disable I region 
   MCR p15, 0, r3, c6, c4, 1  ; set I region 4 enable
   MOV pc, lr                 ; region set return

enableRegion5                 ; define region disables region
   MRC p15, 0, r3, c6, c5, 0  ; get D region 5 base and size
   BIC r3, r3, #1             ; clear D region enable       
   ORR r3, r3, r1             ; set enable or disable D region 
   MCR p15, 0, r3, c6, c5, 0  ; set region 5 enable

   MRC p15, 0, r3, c6, c5, 1  ; get I region 5 base and size
   BIC r3, r3, #1             ; clear D region enable       
   ORR r3, r3, r1             ; set enable or disable I region 
   MCR p15, 0, r3, c6, c5, 1  ; set I region 5 enable
   MOV pc, lr                 ; region set return

enableRegion6                 ; define region disables region
   MRC p15, 0, r3, c6, c6, 0  ; get D region 6 base and size
   BIC r3, r3, #1             ; clear D region enable       
   ORR r3, r3, r1             ; set enable or disable D region 
   MCR p15, 0, r3, c6, c6, 0  ; set D region 6 enable

   MRC p15, 0, r3, c6, c6, 1  ; get I region 6 base and size
   BIC r3, r3, #1             ; clear I region enable       
   ORR r3, r3, r1             ; set enable or disable I region 
   MCR p15, 0, r3, c6, c6, 1  ; set I region 6 enable
   MOV pc, lr                 ; region set return

enableRegion7                 ; define region disables region
   MRC p15, 0, r3, c6, c7, 0  ; get D region 7 base and size
   BIC r3, r3, #1             ; clear D region enable       
   ORR r3, r3, r1             ; set enable or disable D region 
   MCR p15, 0, r3, c6, c7, 0  ; set D region 7 enable

   MRC p15, 0, r3, c6, c7, 1  ; get I region 7 base and size
   BIC r3, r3, #1             ; clear I region enable       
   ORR r3, r3, r1             ; set enable or disable I region 
   MCR p15, 0, r3, c6, c7, 1  ; set I region 7 enable
   MOV pc, lr                 ; region set return

OutOfRange
   B OutOfRange               ; loop at error for debugging

ErrorControl
   b ErrorControl
ErrorPermission               ; Error Permission =4
   b ErrorPermission          ; debug test
   ADD r0, r0, #1
ErrorSize                     ; Error  Size = 3
   ADD r0, r0, #1
ErrorAddress                  ; Error  Address unaligned = 2
   ADD r0, r0, #1
ErrorRegion                   ; Error  Region not valid = 1
   ADD r0, r0, #1
   MOV pc, lr

; /* -------------------------------------------------------
;  *
;  * Change Region 2 (called from the context switch)
;  * 
;  * fn: mpuRegionDefine (region, PCB[0], PCB[1]);
;  * fn: mpuRegionStdAccess (region, PCB[2]);
;  * fn: mpuRegionCB (region, PCB[3]);
;  * fn: mpuRegionEnable (region, PCB[4]);
;  * 
;  * -------------------------------------------------------
;  */

mpuScheduleRegion2

; /* -------------------------------------------------------
;  *
;  * Change Region 2 (called from the context switch) to a 
;  * new task...
;  * 
;  * Register r0 points to the new identifier...
;  *
;  * fn: mpuRegionDefine (region2, PCB[0], PCB[1]);
;  * fn: mpuRegionStdAccess (region2, PCB[2]);
;  * fn: mpuRegionCB (region2, PCB[3]);
;  * fn: mpuRegionEnable (region2, PCB[4]);
;  * 
;  * -------------------------------------------------------
;  */

     STMFD    sp!,{r0-r4,r12,lr}   ; save context
     LDR      r1,=MpuPCB_Table
     LDR      r4,[r1,r0,LSL#2]     ; r4= new PCB address
  
; --------------------------------------------------------
; define the new region ... 
; --------------------------------------------------------

     MOV     r0,#2                 ; parameter 1 region2
     LDR     r1,[r4]               ; parameter 2 RegionTable[0]
     LDR     r2,[r4,#4]            ; parameter 3 RegionTable[1]
     BL      mpuRegionDefine  	 

; --------------------------------------------------------
; define standard access permissions ...
; --------------------------------------------------------

     MOV     r0,#2                 ; parameter 1 region2
     LDR     r1,[r4,#8]            ; parameter 2 RegionTable[2]
     BL      mpuRegionStdAccess       

; --------------------------------------------------------
; cache and write through ...
; --------------------------------------------------------

     MOV     r0,#2                 ; parameter 1 region2
     LDR     r1,[r4,#12]           ; parameter 2 RegionTable[3]
     BL      mpuRegionCB          

; --------------------------------------------------------
; enable new region ...
; --------------------------------------------------------

     MOV     r0,#2                 ; parameter 1 region2
     LDR     r1,[r4,#16]           ; parameter 2 RegionTable[4]
     BL      mpuRegionEnable          

; --------------------------------------------------------
; restore context and return to scheduler ...
; --------------------------------------------------------  

     LDMFD   sp!,{r0-r4,r12,pc}
     END

