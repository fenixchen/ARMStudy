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
; * Small Little Operating System - SLOS
; ****************************************************************************

; ****************************************************************************
; *
; * Module       : bringup
; * Description  : provides the low level debug capabilities used
; *                in the bringup stage. This debug information is 
; *                stored in the FIQ registers. 
; * OS           : SLOS MPU 0.03
; * Platform     : generic
; *
; ****************************************************************************

; ****************************************************************************
; * EXPORT
; ****************************************************************************

     EXPORT     bringupSetR8fiq
     EXPORT     bringupSetR9fiq
     EXPORT     bringupSetR10fiq
     EXPORT     bringupInitFIQRegisters

     AREA bringup,CODE,READONLY

; -- switchToFIQMode --------------------------------------------------------
;
; Description   : sets the r8 in FIQ mode and return back to SVC mode
;
; Parameters    : r1 - fatal number
; Return	      : none... 
;

switchToFIQMode

     MOV     r3,lr
     MRS     r1,CPSR
     BIC     r1,r1,#0x1f
     ORR     r1,r1,#0x11 
     MSR     CPSR_c,r1
     MOV     pc,r3 

; -- switchToSVCMode --------------------------------------------------------
;
; Description  : sets the r8 in FIQ mode and return back to SVC mode
;
; Parameters   : r1 - fatal number
; Return       : none... 
;

switchToSVCMode

     MOV     r3,lr                     
     MRS     r1,CPSR
     BIC     r1,r1,#0x1f
     ORR     r1,r1,#0x13 
     MSR     CPSR_c,r1
     MOV     pc,r3

; -- bringup_setR8fiq -------------------------------------------------------
;
; Description  : sets the r8 in FIQ mode and return back to SVC mode
;
; Parameters   : r1 - fatal number
; Return       : none... 
;

bringupInitFIQRegisters

	; r1 - fatal error number

     MOV     r2,lr                 ; copy link register into r2
     BL      switchToFIQMode       ; change FIQ
     MOV     r8,#0                 ; r8FIQ=0
     MOV     r9,#0                 ; r9FIQ=0
     MOV     r10,#0                ; r10FIQ=0
     BL 	   switchToSVCMode       ; change SVC
     MOV     pc,r2                 ; return back

; -- bringup_setR8fiq -------------------------------------------------------
;
; Description  : sets the r8 in FIQ mode and return back to SVC mode
;
; Parameters   : r1 - fatal number
; Return       : none... 
;

bringupSetR8fiq

     ; r1 - fatal error number

     MOV     r2,lr                  ; copy link register into r2
     BL      switchToFIQMode        ; change FIQ 	
     MOV     r8,r0                  ; r10_fiq = r0
     BL      switchToSVCMode        ; change SVC
     MOV     pc,r2                  ; return back

; -- bringup_setR9fiq -------------------------------------------------------
;
; Description  : sets the r10 FIQ mode and return back to SVC mode
;
; Parameters   : r2 - exit trace number
; Return       : none... 
;

bringupSetR9fiq
	
     ; r2 - entry trace number

     MOV     r2,lr
     BL      switchToFIQMode       ; change FIQ 	
     MOV     r9,r0                 ; r9_fiq = r2
     BL      switchToSVCMode       ; change SVC
     MOV     pc,r2                 ; return back

; -- bringup_setR10fiq ------------------------------------------------------
;
; Description  : sets the r10 FIQ mode and return back to SVC mode
;
; Parameters   : r2 - exit trace number
; Return       : none... 
;

bringupSetR10fiq

     ; r2 - exit trace number

     MOV     r2,lr
     BL      switchToFIQMode       ; change FIQ 	
     MOV     r10,r0                ; r10_fiq = r2
     BL      switchToSVCMode       ; change SVC
     MOV     pc,r2                 ; return back
     END
