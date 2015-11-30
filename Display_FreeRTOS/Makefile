TOOLCHAIN = arm-none-eabi-
CC = $(TOOLCHAIN)gcc
CXX = $(TOOLCHAIN)g++
AS = $(TOOLCHAIN)as
LD = $(TOOLCHAIN)ld
OBJCOPY = $(TOOLCHAIN)objcopy
AR = $(TOOLCHAIN)ar
OBJDUMP = $(TOOLCHAIN)objdump

OFLAG = -o
INCLUDEFLAG = -I
CPUFLAG = -mcpu=arm926ej-s
WFLAG = -Wall -Wextra -Werror -Wno-error=unused-value
CFLAGS = $(CPUFLAG) $(WFLAG) -O0 -g3

LD_SCRIPT=Drivers/qemu.ld

OBJDIR=obj/
INCLUDES = Source/include  Source/portable/GCC/ARM926EJ-S/ Drivers/
SRC_DIRS=Source/ Source/portable/MemMang/ Source/portable/GCC/ARM926EJ-S/ Drivers/
CFLAGS += $(addprefix -I, $(INCLUDES))

EXTRA_OBJS=$(OBJDIR)Drivers/startup.o


define folder-rule 
D=$1
$(OBJDIR)$(D)%.o:$(D)%.c
	$(CC) -c $$< -o $$@ $$(CFLAGS)
endef


OBJ_DIRS=$(addprefix $(OBJDIR), $(SRC_DIRS))
$(foreach d,$(SRC_DIRS),$(eval SRCS+=$(wildcard $(d)*.c)))
OBJS=$(addprefix $(OBJDIR), $(subst .c,.o,$(SRCS)))
OBJS+=$(EXTRA_OBJS)
$(foreach d,$(SRC_DIRS),$(eval $(call folder-rule, $(d))))


DISPLAY_BIN=display.bin

DISPLAY_ELF=$(subst .bin,.elf,$(DISPLAY_BIN))

all:$(DISPLAY_BIN)

$(DISPLAY_BIN):objdir $(DISPLAY_ELF)
	$(OBJCOPY) -O binary $(DISPLAY_ELF) $@

$(DISPLAY_ELF):$(OBJS) $(LD_SCRIPT)
	$(LD) -o $@ -T$(LD_SCRIPT) $(OBJS)
	$(OBJDUMP) -D $@ > $(subst .elf,.s,$(DISPLAY_ELF))

objdir:
	@$(foreach d, $(OBJ_DIRS), mkdir -p $(d)) 

clean:
	rm -rf $(OBJDIR) $(DISPLAY_BIN) $(DISPLAY_ELF) display.s

$(OBJDIR)Drivers/startup.o:Drivers/startup.s
	$(CC) -c $< -o $@ $(CFLAGS)

.PHONY : all clean objdir
