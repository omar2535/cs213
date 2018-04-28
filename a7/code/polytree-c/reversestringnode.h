#ifndef __REVERSESTRINGNODE_H__
#define __REVERSESTRINGNODE_H__

/*
struct definition of class and external definition of class table
*/
struct ReverseStringNode_class{
    struct StringNode_class* super;
    int  (*compareTo) (void*, void*);
    void (*printNode) (void*);
    void (*insert)    (void*, void*);
    void (*print)     (void*);
    void (*delete)    (void*);
};
extern struct ReverseStringNode_class ReverseStringNode_class_table;

/*
struct defintion of object 
*/
struct ReverseStringNode;
struct ReverseStringNode{
    struct ReverseStringNode* class;

    struct ReverseStringNode* left;
    struct ReverseStringNode* right;

    char* s;
};

void ReverseStringNode_ctor(void*, char*);
int ReverseStringNode_compareTo(void*, void*);

void* new_ReverseStringNode(char*);

#endif /*__REVERSESTRINGNODE_H__*/
