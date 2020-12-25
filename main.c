#include "stdlib.h"
#include "interrupts.h"
#include "tty.h"


typedef struct {
	uint64 base;
	uint64 size;
} BootModuleInfo;

void kernel_main(uint8 boot_disk_id, void *memory_map, BootModuleInfo *boot_module_list) {
	/*char *screen_buffer = (void*)0xB8000;
	memset_word(screen_buffer, 0x0E00, 2000);
	char msg[] = {'H',0x01}; //,'e',0x02,'l',0x03,'l',0x04,'o',0x05,' ',0x0E,'w',0x06,'o',0x07,'r',0x08,'l',0x09,'d',0x0a,'!',0x0b};
	memcpy(screen_buffer, msg, sizeof(msg));*/
	init_interrupts();
	init_tty();
	set_text_attr(0x1F);
	clear_screen();
		
	//set_text_attr(15);
	write("Welcome to IKOS!\n");
	write("Boot disk id is %d\n", boot_disk_id);
	write("Memory map at 0x%x\n", memory_map);
	write("Boot module list at 0x%x\n", boot_module_list);


} 

/*
0 - черный 8 - черный * 
1 - низкий синий 9 - высокий синий 
2 - низкий зеленый 10 - высокий зеленый 
3 - низкий голубой 11 - высокий голубой 
4 - низкий красный 12 - высокий красный 
5 - слабый пурпурный 13 - высокий пурпурный 
6 - слабый желтый * 14 - желтый 
7 - светло-серый 15 - белый
*/