.syntax unified
.cpu cortex-m4
.fpu softvfp
.thumb

.section  .text.Reset_Handler
.weak  Reset_Handler
.type  Reset_Handler, %function

Reset_Handler:  
	ldr   sp, =_estack      /* set stack pointer */

/* Copy the data segment initializers from flash to SRAM */  
	movs  r1, #0
	b  LoopCopyDataInit

CopyDataInit:
	ldr  r3, =_sidata
	ldr  r3, [r3, r1]
	str  r3, [r0, r1]
	adds  r1, r1, #4
    
LoopCopyDataInit:
	ldr  r0, =_sdata
	ldr  r3, =_edata
	adds  r2, r0, r1
	cmp  r2, r3
	bcc  CopyDataInit
	ldr  r2, =_sbss
	b  LoopFillZerobss
/* Zero fill the bss segment. */  
FillZerobss:
	movs  r3, #0
 	str  r3, [r2], #4
    
LoopFillZerobss:
	ldr  r3, = _ebss
	cmp  r2, r3
	bcc  FillZerobss

/* Call the clock system intitialization function.*/
//	bl  SystemInit   
/* Call static constructors */
//	bl __libc_init_array
/* Call the application's entry point.*/
	bl  main
	bx  lr    
.size  Reset_Handler, .-Reset_Handler
