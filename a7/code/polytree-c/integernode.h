#ifndef __INTEGERNODE_H__
#define __INTEGERNODE_H__

/*
struct definition of class and external definition of class table
*/
struct IntegerNode_class{
    struct Node_class* super;
    int  (*compareTo) (void*, void*);
    void (*printNode) (void*);
    void (*insert)    (void*, void*);
    void (*print)     (void*);
    void (*delete)    (void*);
};
extern struct IntegerNode_class IntegerNode_class_table;

/*
struct defintion of object 
*/
struct IntegerNode;

struct IntegerNode{

    struct IntegerNode* class;
    struct IntegerNode* left;
    struct IntegerNode* right;
    int* n;

};

int  IntegerNode_compareTo(void*, void*);
void IntegerNode_printNode(void*);

void* new_IntegerNode(int*);


#endif /*__INTEGERNODE_H__*/
