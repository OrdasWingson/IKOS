#ifndef INTERRUPTS_H
#define INTERRUPTS_H

uint8 irq_base;
uint8 irq_count;

#define IRQ_HANDLER(name) void name(); \
	asm("_"#name ":\n pusha \n call __" #name " \n movb $0x20, %al \n outb %al, $0x20 \n outb %al, $0xA0 \n popa \n iret"); \
	void _ ## name()

void init_interrupts();
void set_int_handler(uint8 index, void *handler, uint8 type);
void NMI_enable();
void NMI_disable();

#endif
