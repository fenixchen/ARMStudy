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
 * Simple Little Operating System - SLOS
 *****************************************************************************/

/*****************************************************************************
 *
 * Module      : lldebug.h
 * Descripion  : Low Level Debug
 * Toolchain   : Toolchain specific
 * OS          : SLOS 0.03
 * Platform    : generic
 * History     :
 *
 * 14th July 2002 Andrew N. Sloss
 * - added the header		
 *
 *****************************************************************************/

/*****************************************************************************
 * IMPORT
 *****************************************************************************/

#ifndef LLDEBUG
#define LLDEBUG 1

#include "../cm940iap/events/swis.h"

/*****************************************************************************
 * MACRO
 *****************************************************************************/

/* -- bringUpTrace ------------------------------------------------------------
 *
 * Description : very low level trace tool
 *
 * Parameters  : none...
 * Return      : none...
 * Notes       :
 * 
 */

__swi (SLOS) void _bringUpTrace (UINT,unsigned int,UID);
#define bringUpTrace(a,b) _bringUpTrace (BringUp_Trace,(a),(b))

/* -- bringUpFatalError -------------------------------------------------------
 *
 * Description : very low level fatal error
 *
 * Parameters  : none...
 * Return      : none...
 * Notes       : when this SWI is called SLOS goes into an infinite 
 *               loop. It is designed for basic fatal loops.
 * 
 */

__swi (SLOS) void _bringUpFatalError (UINT,UID);
#define bringUpFatalError(a) _bringUpFatalError (BringUp_FatalError,(a))


/* -- lltrace -----------------------------------------------------------------
 *
 * Description : low level trace 
 *
 * Parameters  : r - routine u - uid
 * Return      : none
 * Notes       : Example of trace:
 *
 *     lltrace(print("hello"),DEVICEDRIVER);
 *
 * or alternatively using the primitives
 *
 * lltracebefore(BEFORERETURN);
 * a = anumber ();
 * lltraceafter(AFTERRETURN);
 */

#define ENTRY	123
#define EXIT	321

#define lltracebefore(u) bringUpTrace(ENTRY,(u))
#define lltraceafter(u)  bringUpTrace(EXIT,(u))

#define lltrace(r,u)     lltracebefore((u)); \
                         (r);                \
		         lltraceafter((u))

/* -- fatalerror --------------------------------------------------------------
 *
 * Description : set a fatal error 
 *
 * Parameters  : r - routine u - uid
 * Return      : none
 * Notes       : Example of trace:
 *
 *     lltrace(initialize_drivers,DEVICEDRIVER);
 *
 */

#define llfatalerror(e) bringUpFatalError((e))

#endif 

