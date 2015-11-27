.section .text

.global _start
_start:
    movl $4, %eax
    movl $1, %ebx
    movl $message, %ecx
    movl $13, %edx
    int $0x80
    
    movl $1, %eax
    movl $12, %ebx
    int $0x80

.section .data
message:
    .ascii "Hello, world\n"
