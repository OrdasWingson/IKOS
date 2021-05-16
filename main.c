#include "stdlib.h"
#include "interrupts.h"
#include "memory_manager.h"
#include "tty.h"
#include "listFS.h"



typedef struct {
	uint64 base;
	uint64 size;
} BootModuleInfo;


typedef struct {
        uint64 base; //Базовый физический адрес региона
        uint64 length; //Размер региона в байтах
        uint32 type; // Тип региона
        uint32 acpi_attrs; //Расширенные атрибуты ACPI
}  __attribute__((packed)) MemoryMap;

MemoryMap *memoryMap;
size_t *addressMemoryMap;

uint8 count_cmnd = 10;
const char *commands[10] = {"reset","ver","help","smm", "env", "clear", "info","fs", "cd","open"};

void commands_handler(char*);
void print_memMap(size_t *addr);
void envVar();
void info();
char *dir;

void kernel_main(uint8 boot_disk_id, void *memory_map, BootModuleInfo *boot_module_list, void *struct_listFS) {
	
	addressMemoryMap = memory_map;
	init_memory_manager(memory_map);
	init_interrupts();
	init_tty();
	init_FS(struct_listFS);//
	set_text_attr(0x1F);
	clear_screen();	
	dir = get_cur_dir();
	//set_text_attr(15);
	printf("Welcome to IKOS!\n");
	printf("kernel_page_dir = 0x%x\n", kernel_page_dir);
	printf("memory_size = %d MB\n", memory_size / 1024 / 1024);
	printf("Boot disk id is %d\n", boot_disk_id);
	printf("Memory map at 0x%x\n", addressMemoryMap);
	printf("Boot module list at 0x%x\n", boot_module_list);
	fsInfo();
	while (true) {
		char buffer[256];
		printf("%s> ", dir);
		in_string(buffer, sizeof(buffer));
		//printf("lenght from main -> %d\n", strlen(buffer));
		
		commands_handler(buffer);
		//printf("You typed: %s\n", buffer);
	}


} 

void commands_handler(char *cmnd)
{
	uint8 count;
	char buff[256];
	for( count = 0; count < count_cmnd; count++)
	{
		if (strcmp(cmnd, (char*)commands[count]) == 0)
		{
			break;
		}
		
	}
	set_text_attr(0x1E);
	switch(count) {
				case 0:
					printf("Sorry, this is imposible\n");
					outportb(0xCF9,0x6);
					break;
				case 1:
					printf("Version 0.0000001))))\n");
					break;
				case 2:
					printf("Command:\n");
					for(int i = 0; i < count_cmnd; i++)
					{
						printf("%d) %s\n",i+1,commands[i]);
					}
					break;
				case 3:
					print_memMap(addressMemoryMap);
					break;
				case 4:
					envVar();
					break;
				case 5:
					clear_screen();
					break;
				case 6:
					info();
					break;
				case 7:
					file_list();
					break;
				case 8:
					printf("insert name of directory: ");
					in_string(buff, sizeof(buff));
					change_dir((char*)buff);
					dir = get_cur_dir();
					break;
				case 9:
					printf("insert name of file: ");
					in_string(buff, sizeof(buff));
					open_file((char*)buff);
					break;
				default:
					printf("Command \"%s\" not found\n", cmnd);
					break;
	}
	set_text_attr(0x1F);
}

void print_memMap(size_t *memMap) {
	size_t *addr = memMap;
	printf("Base address - length - type - acpi_attrs\n");
	while( *(addr+2) != 0)
	{
		printf("%x | %x | %x | %x\n", *(addr), *(addr+2),*(addr+4),*(addr+5));
		addr += 6;
	}
} 

void envVar()
{
	printf("KERNEL_BASE = %x (hex), %d (dec)\n", KERNEL_BASE, KERNEL_BASE);
	printf("KERNEL_PAGE_TABLE = %x (hex), %d (dec)\n", KERNEL_PAGE_TABLE, KERNEL_PAGE_TABLE);
	printf("TEMP_PAGE = %x (hex), %d (dec)\n", TEMP_PAGE, TEMP_PAGE);
	printf("TEMP_PAGE_INFO = %x (hex), %d (dec)\n", TEMP_PAGE_INFO, TEMP_PAGE_INFO);
	printf("sizeof(phyaddr) = %d (dec)\n", sizeof(phyaddr));
	printf("----------------------------------\n");
	printf("TEMP_PAGE >> PAGE_OFFSET_BITS = %x (hex)\n", TEMP_PAGE >> PAGE_OFFSET_BITS);
	printf("T>P & PAGE_TABLE_INDEX_MASK = %x (hex)\n", (TEMP_PAGE >> PAGE_OFFSET_BITS) & PAGE_TABLE_INDEX_MASK);
	printf("T>P & p * sizeof(phyaddr) = %x (hex)\n", (TEMP_PAGE >> PAGE_OFFSET_BITS) & PAGE_TABLE_INDEX_MASK*sizeof(phyaddr));
}//(KERNEL_PAGE_TABLE + ((TEMP_PAGE >> PAGE_OFFSET_BITS) & PAGE_TABLE_INDEX_MASK) * sizeof(phyaddr))

void info()
{
	printf("IKOS\n");
	printf("32 bits\n");
	printf("kernel_page_dir = 0x%x\n", kernel_page_dir);
	printf("memory_size = %d MB\n", memory_size / 1024 / 1024);
    printf("get_page_info(kernel_page_dir, 0xB8000) = 0x%x\n", get_page_info(kernel_page_dir, (void*)0xB8000));
	printf("Memory map at 0x%x\n", addressMemoryMap);
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

/*char *screen_buffer = (void*)0xB8000;
	memset_word(screen_buffer, 0x0E00, 2000);
	char msg[] = {'H',0x01,'e',0x02,'l',0x03,'l',0x04,'o',0x05,' ',0x0E,'w',0x06,'o',0x07,'r',0x08,'l',0x09,'d',0x0a,'!',0x0b};
	memcpy(screen_buffer, msg, sizeof(msg));*/


/* printf("get_page_info(kernel_page_dir, 0xB8000) = 0x%x\n", get_page_info(kernel_page_dir, (void*)0xB8000));
	printf("get_page_info(kernel_page_dir, 0xFFFC0000) = 0x%x\n", get_page_info(kernel_page_dir, (void*)0xFFFC0000));
	
	map_pages(kernel_page_dir, (void*)0xFFFFC000, 0xff52000, 1, PAGE_VALID | PAGE_WRITABLE);
	printf(" alloc_phys_pages(1) = 0x%x\n",get_page_info(kernel_page_dir, (void*)0xFFFFC000));
	
	map_pages(kernel_page_dir, (void*)0xFFFFC000, 0x1f52000, 1, PAGE_VALID | PAGE_WRITABLE);
	printf("2 alloc_phys_pages(1) = 0x%x\n",get_page_info(kernel_page_dir, (void*)0xFFFFC000));*/