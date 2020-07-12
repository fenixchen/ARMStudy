
# Base load address 0x28000

OBJS = led.o \
start.o 


all : ${OBJS}
	armlink -first start.o -entry entry -ro 0x28000 -o ../../../image/apps/task2.elf ${OBJS}
	fromelf -bin -o ../../../image/apps/task2.bin ../../../image/apps/task2.elf

led.o : ../../../src/apps/task2/led.c
	armcc -c -o $@ $<
 
start.o : ../../../src/apps/task2/start.c
	armcc -c -o $@ $<


