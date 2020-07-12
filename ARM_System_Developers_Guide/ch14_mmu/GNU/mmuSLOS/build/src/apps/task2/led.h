/*
 *  ____________________________________________________________________
 * 
 *  Copyright (c) 2002, Andrew N. Sloss, Chris Wright and Dominic Symes
 *  All rights reserved.
 *  ____________________________________________________________________
 * 
 *  NON-COMMERCIAL USE License
 *  
 *  Redistribution and use in source and binary forms, with or without 
 *  modification, are permitted provided that the following conditions 
 *  are met: 
 *  
 *  1. For NON-COMMERCIAL USE only.
 * 
 *  2. Redistributions of source code must retain the above copyright 
 *     notice, this list of conditions and the following disclaimer. 
 * 
 *  3. Redistributions in binary form must reproduce the above 
 *     copyright notice, this list of conditions and the following 
 *     disclaimer in the documentation and/or other materials provided 
 *     with the distribution. 
 * 
 *  4. All advertising materials mentioning features or use of this 
 *     software must display the following acknowledgement:
 * 
 *     This product includes software developed by Andrew N. Sloss,
 *     Chris Wright and Dominic Symes. 
 * 
 *   THIS SOFTWARE IS PROVIDED BY THE CONTRIBUTORS ``AS IS'' AND ANY 
 *   EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
 *   IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR 
 *   PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE CONTRIBUTORS BE 
 *   LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, 
 *   OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, 
 *   PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, 
 *   OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY 
 *   THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR 
 *   TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT 
 *   OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY 
 *   OF SUCH DAMAGE. 
 * 
 *  If you have questions about this license or would like a different
 *  license please email :
 * 
 * 	andrew@sloss.net
 * 
 * 
 */

/*****************************************************************************
 * Simple Little Operating System - mpuSLOS
 *****************************************************************************/

/*****************************************************************************
 *
 * Module       : led.c
 * Description  : controls 
 * Platform     : Integrator/AP
 * History      :
 *
 * 15 July 2003 Andrew N. Sloss
 * - added header information 
 *
 *****************************************************************************/

/*****************************************************************************
 * IMPORT
 *****************************************************************************/

/* none... */

/*****************************************************************************
 * MACROS
 *****************************************************************************/

/* none... */

/*****************************************************************************
 * ROUTINES
 *****************************************************************************/

/* -- openYellowLED -----------------------------------------------------------
 *
 * Description : opens the communication port to the YELLOW LED
 *
 * Parameters  : none...
 * Return      : BOOLean - successful or unsuccessful 
 * Notes       :
 *
 */
 
unsigned int openYellowLED(void);

/* -- switchOnYellowLED -------------------------------------------------------
 *
 * Description : switches on the YELLOW LED on the Intergrator/AP motherboard
 *
 * Parameter   : none...
 * Return      : none...
 * Notes       :
 *
 */

void switchOnYellowLED(void);

/* -- switchOffYellowLED ------------------------------------------------------
 *
 * Description : switches on the Red LED on the Intergrator/AP motherboard
 *
 * Parameter   : none...
 * Return      : none...
 * Notes       :
 *
 */

void switchOffYellowLED(void);

