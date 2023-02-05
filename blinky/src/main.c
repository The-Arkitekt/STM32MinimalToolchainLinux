/* Main program. */
#include "main.h"

int main(void) {
	// Enable GPIO clocks
	RCC->AHB1ENR |= RCC_AHB1ENR_GPIOAEN;
	RCC->AHB1ENR |= RCC_AHB1ENR_GPIOCEN;	
	
	// Initialize the GPIOC pin
	// Should be set to Input mode with pull-up
	GPIOC->MODER &= ~(0x3 << (BUTTON_PIN*2));
	GPIOC->PUPDR &= ~(0x3 << (BUTTON_PIN*2));
	GPIOC->PUPDR |=  (0x1 << (BUTTON_PIN*2));
	
	// Initialize the GPIOA pin
	// Should be set to push-pull low-speed output
	GPIOA->MODER &= ~(0x3 << (LED_PIN*2));
	GPIOA->MODER |= (0x1 << (LED_PIN*2));
	GPIOA->OTYPER &= ~(1 << LED_PIN);

	GPIOA->ODR &= ~(1 << LED_PIN);

	for(;;) {
		//Invert the IDR register since '0' means 
		//pressed
		uint32_t input = ~GPIOC->IDR;
		if(input & (0x1 << BUTTON_PIN)){
			// The button is pressed; if it was not
			GPIOA->ODR |= (1 << LED_PIN);
		}
		else {
			GPIOA->ODR &= ~(1 << LED_PIN);
		}
	}
}
