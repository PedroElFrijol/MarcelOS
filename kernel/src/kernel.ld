OUTPUT_FORMAT(elf32-i386) /* (for wsl) */
/*OUTPUT_FORMAT("pe-i386") /* (for macos) */
/* The output file format that the linker will produce */

ENTRY(main) /*Set the entry point to the "main" function */

SECTIONS {
    . = 0x7E00; /*Set the starting address of the program to 0x7E00 */

    /* .text section: contains executable code */
    .text : AT(0x7E00) /*Set the address of the .text section to 0x7E00 */
    {
        *(__start*); /*Include all symbols starting with "__start" */
        *(.text*); /*Include all .text sections from object files */
    }

    /* .data section: contains initialized writable data */
    .data : 
    {
        *(.bss*); /*Include all .bss sections from object files */
        /* Represents a block of memory that is reserved for uninitialized data in a program */

        *(.data*); /*Include all .data sections from object files */

        *(.rodata*); /*Include all .rodata sections from object files (Read-Only data) */
        /* Any attempt to modify the data at runtime will result in a segmentation fault or other error because its read only */

        *(COMMON*); /*Include all COMMON sections from object files */
    }
}