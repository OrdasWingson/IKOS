#ifndef LISTFS_H
#define LISTFS_H

void ata_lba_read(uint32 sectorLBA, uint32 count, void *addres);

void init_FS(void *);
void file_list();
void fsInfo();
void change_dir(char *);
char *get_cur_dir();
void open_file(char *);
void error_msg(char*, char*);
#endif