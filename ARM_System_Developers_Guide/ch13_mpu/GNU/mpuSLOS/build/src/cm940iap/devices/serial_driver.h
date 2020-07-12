/*****************************************************************************
 * Simple Little Operating System - mpuSLOS
 *****************************************************************************/

/*****************************************************************************
 * 
 * Module       : serial_driver.h
 * Description  : low level serial device driver interface
 * OS           : SLOS 0.03
 * Platform     : cm940iap
 * History      : 
 *
 * 25th November 2001 Andrew N. Sloss
 * - create a template
 *
 *****************************************************************************/

/* -- serial_init ------------------------------------------------------------
 *
 * Description : initalize the driver
 * 
 * Parameters  : none...
 * Return      : none...
 * Notes       : none...
 *
 */

void serial_init (void);

/* -- serial_open ------------------------------------------------------------
 *
 * Description : open the serial display  
 * 
 * Parameters  : unsigned device = DEVICE_serial_e7t
 *             : unsigned ignored - for this device
 * Return      : UID -
 * Notes       : 
 *
 */

UID serial_open (unsigned device,unsigned ignored);

/* -- serial_close -----------------------------------------------------------
 *
 * Description : example open on the serial 
 * 
 * Parameters  : UID id = DEVICE_serial_e7t 
 * Return      : 
 *   DEVICE_SUCCESS - successfully close the device
 *   DEVICE_UNKNOWN - couldn't identify the UID
 * Notes       : 
 *
 */

int serial_close (UID id);

/* -- serial_write_byte ------------------------------------------------------
 *
 * Description : read a particular byte value 
 * 
 * Parameters  : UID id
 *             : BYTE serial = 0-9 
 * Return      : none...
 *
 * Notes       : 
 */

void serial_write_byte (UID id,BYTE serial);

/* -- serial_read_byte -------------------------------------------------------
 *
 * Description : read a particular byte value 
 * 
 * Parameters  : UID id
 * Return      : BYTE value 0-9 
 *
 * Notes       : an example of a led read bit
 */

BYTE serial_read_byte (UID id);


