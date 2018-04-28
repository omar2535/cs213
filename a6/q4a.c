#include <stdio.h>

int c[] = {0,0,0,0,0,0,0,0,0,0,0};
int *d = c;

void add(int a, int b){
    a = d[b] + a;
    d[b] = a;
}

void main(){
    int a=1;
    int b=2;
    add(3,4);
    add(a,b);
    for (int i=0; i<10;i++) {
         printf("%d\n", c[i]);
    }
}
