test.bin:test.elf
	arm-none-eabi-objcopy -O binary test.elf test.bin

test.elf:test.ld test.o vectors.o
	arm-none-eabi-ld -T test.ld test.o vectors.o -o test.elf

test.o:test.c
	arm-none-eabi-gcc -c -mcpu=arm926ej-s -g test.c -o test.o

vectors.o:vectors.s
	arm-none-eabi-as -mcpu=arm926ej-s -g vectors.s -o vectors.o

clean:
	-rm vectors.o test.o test.elf test.bin -rf

run:
	qemu-system-arm -M versatilepb -m 128M -nographic -kernel test.bin

 
