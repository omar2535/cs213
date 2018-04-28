#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include "list.h"
#include <string.h>
#include "list.c"

void printInt (element_t ev) {
  int* e = (int*) ev;
  printf ("%d\n", e);
}

void printString (element_t ev) {
  char* e = ev;
  if(e == NULL){
    printf("%s\n", "NULL");
  }else{
    printf ("%s\n", e);
  }

}

int isPositive (element_t av) {
    intptr_t a = (intptr_t) av;
    return a >= 0;
}

void stringToNumber (element_t* rv, element_t av) {
  char*  a = (char*)  av;
  intptr_t* r = (intptr_t*) rv;
  char*pEnd;
  *r = strtol(a, &pEnd, 10);
  if (pEnd == a) {
    *r = -1;
  }
}

void strs (element_t* rv, element_t av, element_t bv) {
  char *  a = (char *)  av;
  intptr_t  b = (intptr_t)  bv;
  char** r = (char**) rv;
  if (b < 0) {
    *r = a;
  } else {
    *r = NULL;
  }
}
void trunct (element_t* rv, element_t av, element_t bv) {
  char *  a = (char *)  av;
  intptr_t  b = (intptr_t)  bv;
  char** r = (char**) rv;
  if (strlen(a) <= b) {
    *r = a;
    return;
  }
  a[(int)b] = 0;
  *r = a;
}

void max (element_t* rv, element_t av, element_t bv) {
  intptr_t  a = (intptr_t)  av;
  intptr_t  b = (intptr_t)  bv;
  intptr_t* r = (intptr_t*) rv;
  if(a>b){
      *r = a;
  }else{
      *r = b;
  }
}

int isNotNull (element_t av) {
    char* a = (char*) av;
    return a != NULL;
}

int main(int argc, char **argv){
    //Make the initial list to hold variables
    struct list* list0 = list_create();

    for(int i=1; i<argc; i++){
        list_append(list0, (element_t)argv[i]);
        //printf("argv[%d] %s\n", i, argv[i]);
    }

    struct list* list1 = list_create();
    list_map1 (stringToNumber, list1, list0);

    struct list* list2 = list_create();
    list_map2 (strs, list2, list0, list1);

    struct list* list3 = list_create();
    list_filter (isPositive, list3, list1);

    struct list* list4 = list_create();
    list_filter(isNotNull, list4, list2);

    struct list* list5 = list_create();
    list_map2(trunct, list5, list4, list3);

    list_foreach(printString, list5);

    intptr_t maxv = -1;
    list_foldl (max, (element_t*)&maxv, list3);

    printf("%d\n", maxv);

    list_destroy (list0);
    list_destroy (list1);
    list_destroy (list2);
    list_destroy (list3);
    list_destroy (list4);
    list_destroy (list5);
    
}