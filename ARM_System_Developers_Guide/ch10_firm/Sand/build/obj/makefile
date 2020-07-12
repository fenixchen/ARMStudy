

OBJS = sand.o

all : ${OBJS}
	armlink  -o ../image/sand.elf ${OBJS}
	fromelf -bin -o ../image/rom.bin ../image/sand.elf

sand.o : ../src/sand.s
	armasm -o $@ $<


