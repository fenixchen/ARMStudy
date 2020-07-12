; ****************************************************************************
; * Simple Little Operating System - SLOS
; ****************************************************************************

; ****************************************************************************
; *
; * Module     : irq.s
; * Project	: SLOS
; * Version	: 0.09
; * Originator	: Andrew N. Sloss
; * History    :
; * 
; * 16th July 2003 Andrew N. Sloss
; * - added header information
; *
; ****************************************************************************

     EXPORT     coreIRQHandler

     IMPORT     events_irq_cm940iap_handler


     AREA IRQSLOS,CODE,READONLY

coreIRQHandler

     B    events_irq_cm940iap_handler       ; branch IRQ handler

	END
