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
 * Module      : init.c
 * Description : initializes the memory protection unit on a ARM940
 * Platform    : CM940IAP
 * History
 *
 * 4 July 2002 (Independence Day) Andrew N. Sloss 
 * - taken from Chris Wright MPU example
 * - removed dependency on stdio.
 *
 *****************************************************************************/

/*****************************************************************************
 * IMPORT
 *****************************************************************************/

#include "regions.h"
#include "mem_init.h"

/*****************************************************************************
 * PROTOTYPES
 *****************************************************************************/

int initStdActiveRegions(void);
int initExtActiveRegions(void);

int configStdRegion(unsigned, unsigned []);
int configExtRegion(unsigned, unsigned []);

void defaultRegions(void);

extern unsigned MpuPCB_RegionTable1[5];

/*****************************************************************************
 * DEFINES
 *****************************************************************************/

#define perfBASE     0x10000000
#define ledBASE      0x1A000000

#define sSBASE       0x00010000
#define pSBASE       0x00000000

/*****************************************************************************
 * STATICS
 *****************************************************************************/

/* --------------------------------------------------------------------------
 *
 *  Protection Region definition
 *  _region
 *  {                
 *  BASE - base address of the region     
 *  SIZE - size of the region     
 *  AP - region propertie   
 *  CB - cache(able) buffer(able)   
 *  ENABLE - enabled | disabled 
 *  }
 *
 * -------------------------------------------------------------------------
 */

unsigned  defaultPCB[5] = {dfltBASE,SIZE_4G,RWXrwx,ccb,R_DISABLE};
unsigned  perfPCB[5] = {perfBASE,SIZE_256M,RWXrwx,ccb,R_ENABLE};
unsigned  perfLEDPCB[5] = {ledBASE,SIZE_16M,RWXrwx,ccb,R_ENABLE};

extern unsigned MpuPCB_RegionTable1[5];

unsigned  sharedPCB[5] = {sSBASE,SIZE_64K,RWXRWX,CWT,R_ENABLE};
unsigned  protectPCB[5] = {pSBASE,SIZE_4G,RWXrwx,CWT,R_ENABLE};

/****************************************************************************
 * ROUTINES
 ****************************************************************************/

/* -- initStdActiveRegions --------------------------------------------------
 *
 * Description : initializes the standard Active Regions
 * Parameters  : none...
 * Return      : TRUE - always
 * Notes       : Task1 is active
 *
 */

int initStdActiveRegions(void)
{

configStdRegion(PROTECTED_SYSTEM,protectPCB);
configStdRegion(SHARED_SYSTEM,sharedPCB);
configStdRegion(TASK,MpuPCB_RegionTable1);
configStdRegion(PERIPHERAL,perfPCB);
configStdRegion(LEDPERIPHERAL,perfLEDPCB);

return 0;
}

/* -- initExtActiveRegions --------------------------------------------------
 *
 * Description : initialize the extended active regions
 * Parameters  : none...
 * Return	     : TRUE - always
 * Notes       : 
 *
 */

int initExtActiveRegions(void)
{  
configExtRegion(PROTECTED_SYSTEM,protectPCB);
configExtRegion(SHARED_SYSTEM,sharedPCB);
configExtRegion(TASK,MpuPCB_RegionTable1);  
configExtRegion(PERIPHERAL,perfPCB);

return 0;
}

/* -- configStdRegion -------------------------------------------------------
 *
 * Description : configures the standard regions.
 * Parameters  : unsigned region - region to be configured
 *             : unsigned PCB[] - process control block 
 * Return      : TRUE - always
 * Notes       : 
 *
 */

int configStdRegion(unsigned region, unsigned PCB[])
{
mpuRegionDefine(region, PCB[0], PCB[1]);
mpuRegionStdAccess(region, PCB[2]);
mpuRegionCB(region, PCB[3]);
mpuRegionEnable(region, PCB[4]);

return 0;
}

/* -- configExtRegion ---------------------------------------------------------
 *
 * Description : configures the extended regions (946E Only)
 * Parameters  : unsigned region - region to be configured
 *             : unsigned PCB[] - process control block
 * Return      : TRUE - always
 * Notes       :
 *
 */

int configExtRegion(unsigned region, unsigned PCB[] )
{
mpuRegionDefine(region, PCB[0], PCB[1]);
mpuRegionExtAccess(region, PCB[2]);
mpuRegionCB(region, PCB[3]);
mpuRegionEnable(region, PCB[4]);

return 0;
}

/* -- defaultRegions ----------------------------------------------------------
 *
 * Description : setup the the protection to a standard configuration.
 *
 * Parameters  : none...
 * Return      : none...
 * Notes       : 
 *
 */

void defaultRegions(void)
{
int i;

/* ------------------------------------------------------------------
 *
 * fastbus, disable icache, dcache, wbuffer, MPU
 * Note: change control should not have hardcoded values, use defines
 * 
 * ------------------------------------------------------------------ 
 */

mpuChangeControl(0x00, 0xC000100D); 

  for ( i=0 ; i < 8; i++)
  {
  configStdRegion(i, defaultPCB);
  }

}

/* -- initMpuSystem ---------------------------------------------------------
 *
 * Description : initialize MPU system
 *
 * Parameters  : none...
 * Return      : none...
 * Notes       : 
 *
 */

void memoryMpuSystem(void)
{
 
/* -----------------------------------------------------------------
 *
 * Setup a know protection state
 *
 * -----------------------------------------------------------------
 */

defaultRegions();

/* -----------------------------------------------------------------
 *
 * Setup protection state for system
 *
 * -----------------------------------------------------------------
 */

initStdActiveRegions();
}

