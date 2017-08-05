all:test.bin

startup.o: startup.s
	arm-none-eabi-as -mcpu=arm926ej-s -g startup.s -o startup.o

test.o:test.c
	arm-none-eabi-gcc -c -mcpu=arm926ej-s -g test.c -o test.o

test.elf:test.ld test.o startup.o
	arm-none-eabi-ld -T test.ld test.o startup.o -o test.elf

test.bin:test.elf
	arm-none-eabi-objcopy -O binary test.elf test.bin

clean:
	-rm startup.o test.o test.elf test.bin -rf

run:
	qemu-system-arm -M versatilepb -m 128M -nographic -kernel test.bin

debug:
	qemu-system-arm -M versatilepb -m 128M -nographic -kernel test.bin -s -S
