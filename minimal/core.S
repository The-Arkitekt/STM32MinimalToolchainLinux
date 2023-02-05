// These instructions define attributes of our chip and  the assembly language we'll use:

.syntax unified
.cpu cortex-m4
//.fpu softvfp   This should be filled with proper FPU hardware version	
.thumb

// Global memory locations
.global vtable
.global reset_handler

/*
* THe actual vector table
* Only the size of RAM and reset handler are included for 
* simplilcity
*/
.type vtable, %object
vtable:
	.word _estack
	.word reset_handler
.size vtable, .-vtable

/*
* The reset handler called on reset
*/
.type reset_handler, %function
reset_handler:
	// set stack pointer to end of stack
	// The _estack value is defined in linker script
	LDR r0, =_estack
	MOV sp, R0

	// Set some dummy values. When we see these values in
	// our debugger, we'll know that our program worked
	LDR r7, =0xDEADBEEF
	MOVS r0, #0
	main_loop:
		// Add 1 to register r0
		ADDS r0, r0, #1
		// loop back
		B main_loop
.size reset_handler, .-reset_handler
