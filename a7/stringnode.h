#ifndef __STRINGNODE_H__
#define __STRINGNODE_H__

/**
 * struct definition of class and external definition of class table
 */
struct StringNode_class {
  struct Node_class* super;
  int  (*compareTo) (void*, void*);
  void (*printNode) (void*);
  void (*insert)    (void*, void*);
  void (*print)     (void*);
  void (*delete)    (void*);
};
extern struct StringNode_class StringNode_class_table;


/**
 * struct definition of object
 */
struct StringNode;
struct StringNode {
  struct StringNode_class* class;

  // instance variables defined in super class(es)
  struct StringNode* left;
  struct StringNode* right;

  // instance variables defined in this class
  char* s;
};

/**
 * definition of methods implemented by this class
 */
void StringNode_ctor(void*, char*);
int StringNode_compareTo(void*, void*);
void StringNode_printNode(void*);

/**
 * definition of new for class
 */
void* new_StringNode(char*);

#endif /*__STRINGNODE_H__*/
