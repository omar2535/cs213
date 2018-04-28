#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "node.h"
#include "stringnode.h"

struct StringNode_class StringNode_class_table = {
  &Node_class_table,  /* super */
  StringNode_compareTo,
  StringNode_printNode,
  Node_insert,
  Node_print,
  Node_delete,
};

void StringNode_ctor(void* thisv, char* s) {
  struct StringNode* this = thisv;
  Node_ctor(this);
  this->s = s;
}

int StringNode_compareTo(void* thisv, void* nodev) {
  struct StringNode* this = thisv;
  struct StringNode* node = nodev;
  return strcmp (this->s, node->s);
}

void StringNode_printNode(void* thisv) {
  struct StringNode* this = thisv;
  printf("%s\n", this->s);
}

void* new_StringNode(char* s) {
  struct StringNode* obj = malloc(sizeof(struct StringNode));
  obj->class = &StringNode_class_table;
  StringNode_ctor(obj, s);
  return obj;
}
