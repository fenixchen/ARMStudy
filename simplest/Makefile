test.elf:test.ld test.o startup.o
	arm-none-eabi-ld -T test.ld test.o startup.o -o test.elf

test.o:test.c
	arm-none-eabi-gcc -c -mcpu=arm926ej-s -g test.c -o test.o

startup.o:startup.s
	arm-none-eabi-as -mcpu=arm926ej-s -g startup.s -o startup.o

clean:
	-rm startup.o test.o test.elf test.bin -rf




run:
	arm-none-eabi-gdb #load test.elf; target sim; 
