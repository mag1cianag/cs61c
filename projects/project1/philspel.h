#ifndef _PHILSPEL_H
#define _PHILSPEL_H
int NUMCHAR = 256;
int PRIME_BASE = 8849;
extern struct HashTable *dictionary;

extern unsigned int stringHash(void *string);

extern int stringEquals(void *s1, void *s2);

extern void readDictionary(char *dictName);

extern void processInput();

#endif
