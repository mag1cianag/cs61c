#include<stdio.h>
int main() {
    int a[20];
    for (int i = 0; ; i++) {
        printf("a[%d] is %d\n",i,a[i]);
        a[i] = i;
    }
}
