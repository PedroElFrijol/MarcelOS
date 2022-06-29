OUTPUT_FORMAT(binary)           /*binary would be the output after compiling*/
ENTRY (kernel_main)

SECTIONS
{
	.text : ALIGN(0x1000)	    /* align at 4 KB*/
	{
		*(.text)	            /* all text sections from all files*/
	}

    /* Read-write data (initialized) */
	.data : ALIGN(0x1000)
	{
		*(.data)	            /* all data sections from all files*/
	}
	/* Read-only data. */
	.rodata : ALIGN(0x1000)
	{
		*(.rodata)	            /* all read-only data sections from all files*/
	}
    /* Read-write data (uninitialized) and stack */
	.bss : ALIGN(0x1000)
	{
		*(COMMON)	            /* all COMMON sections from all files*/
        *(.bss)                 /* all bss sections from all files*/
	}
}