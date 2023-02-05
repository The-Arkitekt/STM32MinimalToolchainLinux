/* Define the end of RAM and limit of stack memory */
/* (112 KB main RAM on the stm32f446re line, 114688 = 0x1C000) */
/* (RAM starts at address 0x20000000) */
_estack = 0x2001C000;

MEMORY 
{
	FLASH(rx) 	: ORIGIN = 0x08000000, LENGTH = 512K
	RAM(rxw)	: ORIGIN = 0x20000000, LENGTH = 112K
}
