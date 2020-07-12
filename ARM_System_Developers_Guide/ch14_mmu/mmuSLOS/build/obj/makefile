OBJS = start.o \
undef.o \
swi.o \
prefetch.o \
data.o \
reserved.o \
irq.o \
fiq.o \
scheduler.o \
mmu.o \
util.o \
async.o \
swi_handler.o \
bringup.o \
cpsr.o \
irq_handler.o \
events_init.o \
tick_service.o \
ddf_io.o \
led_driver.o \
serial_driver.o \
cinit.o \
uid.o \
jump.o \
init.o \
mmupcb.o \
sal.o


all : ${OBJS}
	armlink -first start.o -ro 0x0 -o ../image/slos.elf ${OBJS}
	fromelf -bin -o ../image/slos.bin ../image/slos.elf

start.o : ../src/start.s
	armasm -o $@ $<
 
init.o : ../src/cm920iap/init.s
	armasm -o $@ $<
 
mmupcb.o : ../src/cm920iap/mmupcb.s
	armasm -o $@ $<
 
undef.o : ../src/undef.s
	armasm -o $@ $<
 
swi.o : ../src/swi.s
	armasm -o $@ $<
 
prefetch.o : ../src/prefetch.s
	armasm -o $@ $<
 
data.o : ../src/data.s
	armasm -o $@ $<
 
reserved.o : ../src/reserved.s
	armasm -o $@ $<
 
irq.o : ../src/irq.s
	armasm -o $@ $<
 
fiq.o : ../src/fiq.s
	armasm -o $@ $<
 
scheduler.o : ../src/scheduler.s
	armasm -o $@ $<
 
mmu.o : ../src/memory/mmu.s
	armasm -o $@ $<

util.o : ../src/memory/util.c
	armcc -c -o $@ $<
 
swi_handler.o : ../src/cm920iap/events/swi_handler.c
	armcc -c -o $@ $<

async.o : ../src/memory/async.s
	armasm -o $@ $<

cpsr.o : ../src/events/cpsr.s
	armasm -o $@ $<

bringup.o : ../src/events/bringup.s
	armasm -o $@ $<

irq_handler.o : ../src/cm920iap/events/irq_handler.s
	armasm -o $@ $<

jump.o : ../src/core/jump.s
	armasm -o $@ $<

sal.o : ../src/sal.s
	armasm -o $@ $<

events_init.o : ../src/cm920iap/events/events_init.c
	armcc -c -o $@ $<

tick_service.o : ../src/cm920iap/events/tick_service.c
	armcc -c -o $@ $<

ddf_io.o : ../src/devices/ddf_io.c
	armcc -c -o $@ $<

led_driver.o : ../src/cm920iap/devices/led_driver.c
	armcc -c -o $@ $<

serial_driver.o : ../src/cm920iap/devices/serial_driver.c
	armcc -c -o $@ $<

cinit.o : ../src/core/cinit.c
	armcc -c -o $@ $<

uid.o : ../src/core/uid.c
	armcc -c -o $@ $<
