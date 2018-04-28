#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "node.h"
#include "stringnode.h"
#include "reversestringnode.h"


struct ReverseStringNode_class ReverseStringNode_class_table = {
    &StringNode_class_table,
    ReverseStringNode_compareTo,
    StringNode_printNode,
    Node_insert,
    Node_print,
    Node_delete,
};

void ReverseStringNode_ctor(void* thisv, char* s){
    struct ReverseStringNode* this = thisv;
    StringNode_ctor(this, s);
    this->s = s;
}

int ReverseStringNode_compareTo(void* thisv, void* nodev){
    struct ReverseStringNode* this = thisv;
    struct ReverseStringNode* node = nodev;
    return strcmp (node->s, this->s);
}

void* new_ReverseStringNode(char* s) {
  struct ReverseStringNode* obj = malloc(sizeof(struct ReverseStringNode));
  obj->class = &ReverseStringNode_class_table;
  ReverseStringNode_ctor(obj, s);
  return obj;
}
