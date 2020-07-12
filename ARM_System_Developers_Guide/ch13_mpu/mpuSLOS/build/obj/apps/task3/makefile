
# Base load address 0x30000

OBJS = start.o \
serial.o \
com.o \
shell.o \
readline.o


all : ${OBJS}
	armlink -first start.o -entry entry -ro 0x30000 -o ../../../image/apps/task3.elf ${OBJS}
	fromelf -bin -o ../../../image/apps/task3.bin ../../../image/apps/task3.elf


start.o : ../../../src/apps/task3/start.c
	armcc -c -o $@ $<

serial.o : ../../../src/apps/task3/serial.c
	armcc -c -o $@ $<
 
shell.o : ../../../src/apps/task3/shell.c
	armcc -c -o $@ $<
 
com.o : ../../../src/apps/task3/com.c
	armcc -c -o $@ $<
 
readline.o : ../../../src/apps/task3/readline.c
	armcc -c -o $@ $<
 
