/*
 * Memory region between 0x00000000 and 0x07FFFFFF is reserved for max. 128MB of RAM.
 * See page 4-3 of the DUI0225D.
 */

ENTRY(vectors_start)

SECTIONS
{
    __ld_Vectors_Size = 16 * 4;   /* Vectors at the very beginning of the memory (rounded up to 16) */
    __ld_Init_Addr = 0x10000;     /* Qemu starts execution at this address */
    __ld_Svc_Stack_Size = 0x1000; /* Very generous size of the Supervisor mode's stack (4 kB) */
    __ld_Irq_Stack_size = 0x1000; /* Very generous size of the IRQ mode's stack (4 kB) */
    __ld_Ram_size = 128M;         /* Total capacity of RAM */


    . = __ld_Vectors_Size;        /* Move the pointer after the "reserved" area for exception vectors */
    . = ALIGN(16);                /* Align it to a multiple of 16; just in case... */

    . = . + __ld_Svc_Stack_Size;  /* Allocate memory for Supervisor mode's stack */
    svc_stack_top = .;            /* Initial stack pointer for the Supervisor mode */

    . = . + __ld_Irq_Stack_size; /* Allocate memory for IRQ mode's stack */
    irq_stack_top = .;           /* Initial stack pointer for the IRQ mode */

    /* Approx. 50 kB remains for the System mode's stack: */
    . = __ld_Init_Addr - 4;      /* Allocate memory for System mode's stack */
    stack_top = .;               /* It starts just in front of the startup address */

    . = __ld_Init_Addr;          /* Qemu will boot from this address */
    .init :
    {
        __init_begin = .;
        *(.init)                 /* ARM exception vectors must be placed to startup address */
        __init_end = .;
    }

    /* The other sections follow: */
    .text :
    {
        __text_begin = .;
        *(.text)
        __text_end = .;
    }

    /* followed by other sections... */
    .rodata :
    {
        __rodata_begin = .;
        *(.rodata)
        __rodata_end = .;
    }

    .data :
    {
        __data_begin = .;
        *(.data)
        __data_end = .;
    }

    .bss :
    {
        __bss_begin = .;
        *(.bss)
        __bss_end = .;
    }
    . = ALIGN(4);                  /* The section size is aligned to the 4-byte boundary */

    __ld_FootPrint_End = .;        /* A convenience symbol to determine the actual memory footprint */

    /* The remainder of RAM is reserved for the heap (if malloc is ever used) */
    .heap :
    {
        __heap_begin = .;
        *(.heap)
        . = __ld_Ram_size;
        __heap_end = .;
    }
}
