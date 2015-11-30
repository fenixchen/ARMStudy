

/**
 * @file
 * Declaration of functions that handle printing via a UART.
 *
 * @author Jernej Kovacic
 */

#ifndef _PRINT_H_
#define _PRINT_H_

#include <FreeRTOS.h>


int16_t printInit(uint16_t uart_nr);

void printGateKeeperTask(void* params);

void vPrintMsg(const portCHAR* msg);

void vPrintChar(portCHAR ch);

void vDirectPrintMsg(const portCHAR* msg);

void vDirectPrintCh(portCHAR ch);


#endif  /* _PRINT_H_ */
