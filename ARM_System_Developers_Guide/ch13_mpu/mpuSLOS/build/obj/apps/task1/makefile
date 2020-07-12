
# Task 1 base address 0x20000

OBJS = led.o \
start.o 


all : ${OBJS}
	armlink -first start.o -entry entry -ro 0x20000 -o ../../../image/apps/task1.elf ${OBJS}
	fromelf -bin -o ../../../image/apps/task1.bin ../../../image/apps/task1.elf

led.o : ../../../src/apps/task1/led.c
	armcc -c -o $@ $<
 
start.o : ../../../src/apps/task1/start.c
	armcc -c -o $@ $<


