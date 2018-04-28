#include <stdio.h>

int l = 0;
int args[] = {0,0,0};

int q2 (int i, int j, int k) {
    if (i < 10 || i > 18)
        l = 0;
    else if (i % 2 == 1)
        l = 0;

    else if (i == 10) 
        l = j + k;
    else if (i == 12) 
        l = j - k;
    else if (i == 14) {
        if (j > k) {
            l = j - k;
        }
        else {
            l = 0;
        }
    }
    else if (i == 16) {
        if (j < k) {
            l = 1;
        }
        else {
            l = 0;  
        }
    }
    else if (i == 18) {
        if (j == k) {
            l = 1;
        }
        else {
            l = 0;  
        }
    }
    return l;
}

int main (int argc, char** argv) {

    for (int i = 1; i < argc; ++i){
        args[i-1] = atoi(argv[i]);
    }
    int i = q2(args[0],args[1],args[2]);
    printf("%d\n" , i);
}
