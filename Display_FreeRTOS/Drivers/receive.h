

/**
 * @file
 * Declaration of functions that handle data receiving via a UART.
 *
 * @author Jernej Kovacic
 */

#ifndef _RECEIVE_H_
#define _RECEIVE_H_

#include <FreeRTOS.h>

int16_t recvInit(uint8_t uart_nr);

void recvTask(void* params);


#endif  /* _RECEIVE_H_ */
