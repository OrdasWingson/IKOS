#include "stdlib.h"
#include "interrupts.h"
#include "memory_manager.h"
#include "tty.h"

typedef struct {
	uint16 address_0_15;
	uint16 selector;
	uint8 reserved;
	uint8 type;
	uint16 address_16_31;
} __attribute__((packed)) IntDesc;

typedef struct {
	uint16 limit;
	void *base;
} __attribute__((packed)) IDTR;

IntDesc *idt = (void*)0xFFFC0000;//(void*)0xFFFFC000;

void timer_int_handler();

void empty_handler();

void init_interrupts() {
	map_pages(kernel_page_dir, idt, 0x8000, 1, PAGE_VALID | PAGE_WRITABLE);//0x20000 0x1110000
	//*((size_t*)0xFFFFEF00) = 0x10000 | 3;//*((size_t*)0xFFFFEFF0) = 0x9000 | 3; //0xff52000 | 3 //ff52000
	memset(idt, 0, 256 * sizeof(IntDesc));
	IDTR idtr = {256 * sizeof(IntDesc), idt};
	asm("lidt (,%0,)"::"a"(&idtr));
	irq_base = 0x20;
	irq_count = 16;
	outportb(0x20, 0x11);
	outportb(0x21, irq_base);
	outportb(0x21, 4);
	outportb(0x21, 1);
	outportb(0xA0, 0x11);
	outportb(0xA1, irq_base + 8);
	outportb(0xA1, 2);
	outportb(0xA1, 1);
	NMI_enable();
	//NMI_disable();
	for ( uint8 i = 0; i<16; i++)
	{
		set_int_handler(irq_base+i, empty_handler, 0x8E);
	}
	set_int_handler(irq_base, timer_int_handler, 0x8E);
	asm("sti");
}

void set_int_handler(uint8 index, void *handler, uint8 type) {
	asm("pushf \n cli");
	idt[index].selector = 8;
	idt[index].address_0_15 = (size_t)handler & 0xFFFF;
	idt[index].address_16_31 = (size_t)handler >> 16;
	idt[index].type = type;
	idt[index].reserved = 0;
	asm("popf"); 
}

IRQ_HANDLER(timer_int_handler) {
	(*((char*)(0xB8000 + 79 * 2)))++;
}
IRQ_HANDLER(empty_handler) {
	
}


void NMI_enable() {
	uint8 status;
	inportb(0x70,status);
    outportb(0x70,  status & 0x7F);
 }
 
 void NMI_disable() {
	uint8 status;
	inportb(0x70,status);
    outportb(0x70, status | 0x80);
 }
