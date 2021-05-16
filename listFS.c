#include "stdlib.h"
#include "listFS.h"
#include "tty.h"
#include "memory_manager.h"

typedef struct {
	uint32 fs_magic; //Сигнатура файловой системы. Должна быть равна 0x84837376.
	uint32 fs_version; //Версия файловой системы - для возможности будущих изменений. Сейчас, равна единице.
	uint32 fs_flags; //Атрибуты файловой системы.
	uint64 fs_base;	//Номер начального сектора файловой системы.
	uint64 fs_size;	//Размер файловой системы в секторах
	uint64 fs_map_base;	//Базовый адрес битовой карты свободных секторов.
	uint64 fs_map_size;	//Размер битовой карты свободных секторов. Равно fs_size / 8 / fs_block_size
	uint64 fs_first_file; //Номер сектора, содержащего заголовок первого файла в корневом каталоге. Если диск пуст -1.
	uint64 fs_uid; //Уникальный идентификатор файловой системы
	uint32 fs_block_size; //Размер сектора. Для поддержки любых блочных устройств. У нас равно 512.
} __attribute__((packed)) HeaderListFS;


typedef struct {
	char name[256];
	uint64 next;
	uint64 prev;
	uint64 parent;
	uint64 flags;
	uint64 data;
	uint64 size;
	uint64 create_time;
	uint64 modify_time;
	uint64 access_time;
} __attribute((packed)) listfs_file_header;



HeaderListFS *headFS;
listfs_file_header *file = (void*)0x8f000; //(void*)0xFFFF1000;
void *file_data_addres = (void*)0x8e000;
void *temp_addres = (void*)0x8d000;
char *directory = "/..";
uint64 ferst_file_sector;

void init_FS(void *addr)
{
	headFS = addr;
	ferst_file_sector = headFS->fs_first_file;
	ata_lba_read(ferst_file_sector, 1, (size_t*)file);
	//map_pages(kernel_page_dir, file, 0xf1000, 1, PAGE_VALID | PAGE_WRITABLE);
	
}

void fsInfo()
{
	printf("FS INFO\nFS magic number addres 0x%x\n", (size_t*)headFS);//headFS->fs_magic
	printf("FS magic number 0x%x\n", headFS->fs_magic);
	printf("FS version 0x%x\n", headFS->fs_version);
	printf("FS flags 0x%x\n",headFS->fs_flags);
	printf("FS base sector %d\n",headFS->fs_base);
	printf("FS size (sectors) %d\n",headFS->fs_size);
	printf("FS map base addres 0x%x\n", headFS->fs_map_base );
	printf("FS map size 0x%x\n", headFS->fs_map_size);
	printf("FS sector of first file %d\n", headFS->fs_first_file);
	printf("FS uid 0x%x\n",headFS->fs_uid);
	printf("FS block size %d\n",headFS->fs_block_size);
}

void file_list()
{
	
	do
	{	
		if(file->flags == 0) printf("file            ");
		else printf("dir             ");
		printf("%s\n", file);
		if(file->next == -1) break;
		ata_lba_read(file->next, 1, file);
				
	}
	while(true);
	ata_lba_read(ferst_file_sector, 1, (size_t*)file);
}

char *get_cur_dir()
{
	return directory;
}

void change_dir(char * in_dir_name)
{
	if(strcmp(in_dir_name, "..") == 0)
	{
		ata_lba_read(file->parent, 1, (size_t*)file);
		if(file->parent == -1)
		{
			ferst_file_sector = headFS->fs_first_file;
			ata_lba_read(ferst_file_sector, 1, (size_t*)file);		
			directory = "/..";
		}
		else
		{
			
			ata_lba_read(file->parent, 1, (size_t*)file);	
			strcpy(directory, file->name);
			ferst_file_sector = file->data;
		}
	}
	else
	{
		do
		{
			if(strcmp(in_dir_name, (char*)file->name) == 0)
			{
				if(file->flags == 0) 
				{
					error_msg("is not a directory", in_dir_name);
					break;
				}
				ferst_file_sector = file->data;
				strcpy(directory, in_dir_name);
				ata_lba_read((uint32)ferst_file_sector, 1, file);
				break;
			}
			else
			{
				if(file->next == -1)
				{
					set_text_attr(0x14);
					printf("%s does not exist\n", in_dir_name);
					set_text_attr(0x1E);
					break;
				}
				ata_lba_read(file->next, 1, file);
				
			}
		}
		while(true);
	}
	ata_lba_read(ferst_file_sector, 1, (size_t*)file);
}

void open_file(char * file_name)
{
	do
	{
		if(strcmp(file_name, (char*)file->name) == 0)
		{
			if(file->flags == 1) 
			{
				printf("%s is not a file\n", file_name);
				break;
			}
			ata_lba_read((uint32)file->data, 1, file_data_addres);
			ata_lba_read(*(uint32*)file_data_addres, 1, file_data_addres);
			clear_screen();
			
			out_string(file_data_addres);
			break;
		}
		else
		{
			if(file->next == -1)
			{
				printf("%s does not exist\n", file_name);
				break;
			}
			ata_lba_read(file->next, 1, file);
				
		}
	}
	while(true);
	printf("\n");
	ata_lba_read(ferst_file_sector, 1, (size_t*)file);
}

void error_msg(char* msg, char* name)
{
	set_text_attr(0x1c);
	printf("%s %s\n", name, msg);
	set_text_attr(0x1E);
}