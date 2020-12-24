#include "stdlib.h"

typedef struct {
	uint64 base;
	uint64 size;
} BootModuleInfo;

void kernel_main(uint8 boot_disk_id, void *memory_map, BootModuleInfo *boot_module_list) {
	char *screen_buffer = (void*)0xB8000;
	memset_word(screen_buffer, 0x0E00, 2000);
	char msg[] = {'H',0x01,'e',0x02,'l',0x03,'l',0x04,'o',0x05,' ',0x0E,'w',0x06,'o',0x07,'r',0x08,'l',0x09,'d',0x0a,'!',0x0b};
	memcpy(screen_buffer, msg, sizeof(msg));
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