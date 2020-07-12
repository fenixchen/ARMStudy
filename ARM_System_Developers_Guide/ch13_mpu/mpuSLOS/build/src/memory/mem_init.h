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
 * Simple Little Operating System (SLOS) MPU
 *****************************************************************************/

/*****************************************************************************
 *
 * Module      : mem_init.h
 * Description : general header information for MPU
 * Platform    : CM940IAP
 * History
 *
 * 4 July 2002 (Independence Day) Andrew N. Sloss 
 * - taken from Chris Wright MPU example
 * 
 *
 *****************************************************************************/

/*****************************************************************************
 * PROTOTYPES
 *****************************************************************************/

extern int mpuChangeControl(unsigned int, unsigned int);
extern int mpuRegionDefine(unsigned int, unsigned int, unsigned int);
extern int mpuRegionStdAccess(unsigned int, unsigned int);
extern int mpuRegionExtAccess(unsigned int, unsigned int);
extern int mpuRegionCB(unsigned int, unsigned int);
extern int mpuRegionEnable(unsigned int, unsigned int);

/*****************************************************************************
 * ROUTINES
 *****************************************************************************/

/* -- initStdActiveRegions --------------------------------------------------
 *
 * Description : initializes the standard Active Regions
 * Parameters  : none...
 * Return      : TRUE - always
 * Notes       : Task1 is active
 *
 */

int initStdActiveRegions(void);

/* -- initExtActiveRegions --------------------------------------------------
 *
 * Description : initialize the extended active regions
 * Parameters  : none...
 * Return	     : TRUE - always
 * Notes       : 
 *
 */

int initExtActiveRegions(void);

/* -- configStdRegion -------------------------------------------------------
 *
 * Description : configures the standard regions.
 * Parameters  : unsigned region - region to be configured
 *             : unsigned PCB[] - process control block 
 * Return      : TRUE - always
 * Notes       : 
 *
 */

int configStdRegion(unsigned region, unsigned []);

/* -- configExtRegion ---------------------------------------------------------
 *
 * Description : configures the extended regions (946E Only)
 * Parameters  : unsigned region - region to be configured
 *             : unsigned PCB[] - process control block
 * Return      : TRUE - always
 * Notes       :
 *
 */

int configExtRegion(unsigned region, unsigned [] );

/* -- defaultRegions ----------------------------------------------------------
 *
 * Description : setup the the protection to a standard configuration.
 *
 * Parameters  : none...
 * Return      : none...
 * Notes       : 
 *
 */

void defaultRegions(void);

/* -- initMpuSystem ---------------------------------------------------------
 *
 * Description : initialize MPU system
 *
 * Parameters  : none...
 * Return      : none...
 * Notes       : 
 *
 */

void memoryMpuSystem(void);
