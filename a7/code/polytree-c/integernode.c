#include <stdlib.h>
#include <stdio.h>
#include "node.h"
#include "integernode.h"

//Overwrites compareTo and printNode

struct IntegerNode_class IntegerNode_class_table = {
    &Node_class_table,
    IntegerNode_compareTo,
    IntegerNode_printNode,
    Node_insert,
    Node_print,
    Node_delete,
};

void IntegerNode_ctor(void* thisv, int* n){
    struct IntegerNode* this = thisv;
    Node_ctor(this);
    this->n = n;
}

int IntegerNode_compareTo(void* thisv, void* nodev){
    struct IntegerNode* this = thisv;
    struct IntegerNode* node = nodev;
    if(this->n < node->n){
        return -1;
    }else if(this->n > node->n){
        return 1;
    }else{
        return 0;
    }
}
void IntegerNode_printNode(void* thisv){
    struct IntegerNode* this = thisv;
    printf("%d\n", this->n);
}


void* new_IntegerNode(int* n) {
  struct IntegerNode* obj = malloc(sizeof(struct IntegerNode));
  obj->class = &IntegerNode_class_table;
  IntegerNode_ctor(obj, n);
  return obj;
}
