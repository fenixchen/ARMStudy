CC = arm-elf-gcc
ASSEMBLER = arm-elf-as
LINKER = arm-elf-ld -Map ../image/map.dat 
CONVERT = arm-elf-strip -O binary -o
CFLAGS = -mapcs -fomit-frame-pointer -O1 -c
ASFLAGS =

OBJS = start.o \
init.o \
mpu.o \
async.o \
mem_init.o \
mpupcb.o \
swiapi.o \
undef.o \
swi.o \
prefetch.o \
data.o \
reserved.o \
irq.o \
fiq.o \
scheduler.o \
swi_handler.o \
irq_handler.o \
bringup.o \
cpsr.o \
events_init.o \
tick_service.o \
ddf_io.o \
led_driver.o \
serial_driver.o \
cinit.o \
uid.o \
jump.o \
sal.o

all : ${OBJS}
	${LINKER} -o ../image/mpuslos.elf linker.dat
	${CONVERT} ../image/mpuslos.bin -s ../image/mpuslos.elf

start.o : ../src/start.s
	${ASSEMBLER} ${ASFLAGS} -o $@ $<
 
init.o : ../src/cm940iap/init.s
	${ASSEMBLER} ${ASFLAGS} -o $@ $<
 
mpupcb.o : ../src/cm940iap/mpupcb.s
	${ASSEMBLER} ${ASFLAGS} -o $@ $<
 
undef.o : ../src/undef.s
	${ASSEMBLER} ${ASFLAGS} -o $@ $<
 
mpu.o : ../src/memory/mpu.s
	${ASSEMBLER} ${ASFLAGS} -o $@ $<
 
async.o : ../src/memory/async.s
	${ASSEMBLER} ${ASFLAGS} -o $@ $<
 
mem_init.o : ../src/memory/mem_init.c
	${CC} ${CFLAGS} -o $@ $<

swi.o : ../src/swi.s
	${ASSEMBLER} ${ASFLAGS} -o $@ $<
 
sal.o : ../src/sal.s
	${ASSEMBLER} ${ASFLAGS} -o $@ $<

jump.o : ../src/core/jump.s
	${ASSEMBLER} ${ASFLAGS} -o $@ $<

prefetch.o : ../src/prefetch.s
	${ASSEMBLER} ${ASFLAGS} -o $@ $<
 
data.o : ../src/data.s
	${ASSEMBLER} ${ASFLAGS} -o $@ $<
 
reserved.o : ../src/reserved.s
	${ASSEMBLER} ${ASFLAGS} -o $@ $<
 
irq.o : ../src/irq.s
	${ASSEMBLER} ${ASFLAGS} -o $@ $<
 
fiq.o : ../src/fiq.s
	${ASSEMBLER} ${ASFLAGS} -o $@ $<
 
scheduler.o : ../src/scheduler.s
	${ASSEMBLER} ${ASFLAGS} -o $@ $<
 
irq_handler.o : ../src/cm940iap/events/irq_handler.s
	${ASSEMBLER} ${ASFLAGS} -o $@ $<
 
bringup.o : ../src/events/bringup.s
	${ASSEMBLER} ${ASFLAGS} -o $@ $<
 
cpsr.o : ../src/events/cpsr.s
	${ASSEMBLER} ${ASFLAGS} -o $@ $<
 
events_init.o : ../src/cm940iap/events/events_init.c
	${CC} ${CFLAGS} -o $@ $<
 
swiapi.o : ../src/core/swiapi.c
	${CC} ${CFLAGS} -o $@ $<

swi_handler.o : ../src/cm940iap/events/swi_handler.c
	${CC} ${CFLAGS} -O1 -c -o $@ $<

tick_service.o : ../src/cm940iap/events/tick_service.c
	${CC} ${CFLAGS} -o $@ $<
 
ddf_io.o : ../src/devices/ddf_io.c
	${CC} ${CFLAGS} -o $@ $<
 
led_driver.o : ../src/cm940iap/devices/led_driver.c
	${CC} ${CFLAGS} -o $@ $<
 
serial_driver.o : ../src/cm940iap/devices/serial_driver.c
	${CC} ${CFLAGS} -o $@ $<
   
cinit.o : ../src/core/cinit.c
	${CC} ${CFLAGS} -o $@ $<
 
uid.o : ../src/core/uid.c
	${CC} ${CFLAGS} -o $@ $<
 
