/*
 * Include the provided hashtable library.
 */
#include "hashtable.h"

/*
 * Include the header file.
 */
#include "philspel.h"

/*
 * Standard IO and file routines.
 */
#include <stdio.h>

/*
 * General utility routines (including malloc()).
 */
#include <stdlib.h>

/*
 * Character utility routines.
 */
#include <ctype.h>

/*
 * String utility routines.
 */
#include <string.h>

/*
 * this hashtable stores the dictionary.
 */
HashTable *dictionary;

/*
 * the MAIN routine.  You can safely print debugging information
 * to standard error (stderr) and it will be ignored in the grading
 * process, in the same way which this does.
 */
int main(int argc, char **argv) {
  if (argc != 2) {
    fprintf(stderr, "Specify a dictionary\n");
    return 0;
  }
  /*
   * Allocate a hash table to store the dictionary
   */
  fprintf(stderr, "Creating hashtable\n");
  dictionary = createHashTable(2255, &stringHash, &stringEquals);

  fprintf(stderr, "Loading dictionary %s\n", argv[1]);
  readDictionary(argv[1]);
  fprintf(stderr, "Dictionary loaded\n");

  fprintf(stderr, "Processing stdin\n");
  processInput();

  /* main in C should always return 0 as a way of telling
     whatever program invoked this that everything went OK
     */
  return 0;
}

/*
 * You need to define this function. void *s can be safely casted
 * to a char * (null terminated string) which is done for you here for
 * convenience.
 */
unsigned int stringHash(void *s) {
    char *string = (char *)s;
//  fprintf(stderr, "Need to define stringHash\n");
//  exit(0);
    if (string == NULL) {
        fprintf(stderr, "undefined stringHash for NULL");
        exit(0);
    }
    unsigned int hash= 0;
    while (*(string) != '\0') {
        hash = ((hash * NUMCHAR) % PRIME_BASE + *string) % PRIME_BASE;
        string++;
    }
    return hash;
}

/*
 * You need to define this function.  It should return a nonzero
 * value if the two strings are identical (case sensitive comparison)
 * and 0 otherwise.
 */
int stringEquals(void *s1, void *s2) {
    char *string1 = (char *)s1;
    char *string2 = (char *)s2;
//  fprintf(stderr, "Need to define stringEquals\n");
//  exit(0);
    while (*string1 != '\0' && *string2 != '\0') {
        if (*string1 != *string2) {
            return 0;
        }
        string1++;
        string2++;
    }

    if (*string1 == '\0' && *string2 == '\0') {
        return 1;
    } else {
        return 0;
    }
}

// read in an arbitrary length word from file, returns first char
// that is not an alphabet. returns -1 at eof
char readWord(FILE *fp, char **word, int size) {
    int len = 0;
    *word = malloc(sizeof(char) * size);
    char c;
    while (!feof(fp)) {
        c = (char) fgetc(fp);
        // reallocate memory if cannot hold
        if (len == size) {
            size = size * 2;
            *word = realloc(*word, sizeof(char) * size);
        }

        // space and newline is the sign of the end of a word
        if (!isalpha(c)) {
            (*word)[len] = '\0';
            return c;
        } else {
            (*word)[len] = c;
        }
        len++;
    }

    if (len == 0) {
        return 0;
    } else {
        if (len == size) {
            size += 1;
            *word = realloc(*word, sizeof(char) * size);
        }
        (*word)[len] = '\0';
        return 0;
    }
}

/*
 * this function should read in every word in the dictionary and
 * store it in the dictionary.  You should first open the file specified,
 * then read the words one at a time and insert them into the dictionary.
 * Once the file is read in completely, exit.  You will need to allocate
 * (using malloc()) space for each word.  As described in the specs, you
 * can initially assume that no word is longer than 60 characters.  However,
 * for the final 20% of your grade, you cannot assumed that words have a bounded
 * length.  You can NOT assume that the specified file exists.  If the file does
 * NOT exist, you should print some message to standard error and call exit(0)
 * to cleanly exit the program.
 *
 * Since the format is one word at a time, with returns in between,
 * you can safely use fscanf() to read in the strings until you want to handle
 * arbitrarily long dictionary chacaters.
 */
void readDictionary(char *filename) {
    FILE *fp = fopen(filename, "r");
    // file doesn't exist, print information and exit
    if (fp == NULL) {
        fprintf(stderr, "file %s does not exist\n", filename);
        exit(0);
    }
    char *nWord;
    int initWordSize = 8;
    char delimiter;
    delimiter = readWord(fp, &nWord, initWordSize);
    while (delimiter != 0) {
        insertData(dictionary, (void *)nWord, (void *)nWord);
        delimiter = readWord(fp, &nWord, initWordSize);
    }
    fclose(fp);
}

void appendWord(char **dest, unsigned int *size, char *word, char del) {
    int end = strlen(*dest) + strlen(word) + 1;
    if (*size <= end) {
        *size = *size * 2;
        *dest = realloc(*dest, sizeof(char) * *size);
    }
    strcat(*dest, word);
    if (del != '\0' && del != -1) {
        (*dest)[end - 1] = del;
        (*dest)[end] = '\0';
    }
}

/*
 * This should process standard input and copy it to standard output
 * as specified in specs.  EG, if a standard dictionary was used
 * and the string "this is a taest of  this-proGram" was given to
 * standard input, the output to standard output (stdout) should be
 * "this is a teast [sic] of  this-proGram".  All words should be checked
 * against the dictionary as they are input, again with all but the first
 * letter converted to lowercase, and finally with all letters converted
 * to lowercase.  Only if all 3 cases are not in the dictionary should it
 * be reported as not being found, by appending " [sic]" after the
 * error.
 *
 * Since we care about preserving whitespace, and pass on all non alphabet
 * characters untouched, and with all non alphabet characters acting as
 * word breaks, scanf() is probably insufficent (since it only considers
 * whitespace as breaking strings), so you will probably have
 * to get characters from standard input one at a time.
 *
 * As stated in the specs, you can initially assume that no word is longer than
 * 60 characters, but you may have strings of non-alphabetic characters (eg,
 * numbers, punctuation) which are longer than 60 characters. For the final 20%
 * of your grade, you can no longer assume words have a bounded length.
 */
void processInput() {
    char *nWord;
    unsigned int outsize = 8;
    int initWordSize = 8;
    char delimiter = readWord(stdin, &nWord, initWordSize);
    char *out = malloc(sizeof(char) * initWordSize);
    out[0] = '\0';
    char *message = " [sic]";
    while (delimiter != 0) {
        // convert all but initial letter to lowercase
        char *nWORD = malloc(sizeof(char) * strlen(nWord));
        strcpy(nWORD, nWord);
        for (int j = 1; j < strlen(nWORD); ++j) {
            nWORD[j] = (char) tolower(nWORD[j]);
        }
        //convert all letters to lower case
        char *nword = malloc(sizeof(char) * strlen(nWord));
        strcpy(nword, nWord);
        for (int i = 0; i < strlen(nword); ++i) {
            nword[i] = (char) tolower(nword[i]);
        }
        if (!findData(dictionary, nWord) && !findData(dictionary, nWORD) && !findData(dictionary, nword)) {
            appendWord(&out, &outsize, nWord, '\0');
            appendWord(&out, &outsize, message, delimiter);
        } else {
            appendWord(&out, &outsize, nWord, delimiter);
        }
        free(nWORD);
        free(nword);
        delimiter = readWord(stdin, &nWord, initWordSize);
    }

    printf("%s", out);
//  fprintf(stderr, "Need to define processInput\n");
//  exit(0);
}
