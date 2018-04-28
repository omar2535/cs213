#ifndef __LOGGINGSTRINGNODE_H__
#define __LOGGINGSTRINGNODE_H__

/*
struct definition of class and external definition of class table
*/
struct LoggingStringNode_class{
    struct StringNode_class* super;
    int  (*compareTo) (void*, void*);
    void (*printNode) (void*);
    void (*insert)    (void*, void*);
    void (*print)     (void*);
    void (*delete)    (void*);
};
extern struct LoggingStringNode_class LoggingStringNode_class_table;

/*
struct defintion of object 
*/
struct LoggingStringNode;

struct LoggingStringNode{

    struct LoggingStringNode* class;
    struct LoggingStringNode* left;
    struct LoggingStringNode* right;
    char* s;

};

void LoggingStringNode_ctor(void*, char*);
void LoggingStringNode_insert(void*, void*);

void* new_LoggingStringNode(char*);

#endif /*__LOGGINGSTRINGNODE_H__*/
