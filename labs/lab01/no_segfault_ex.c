#include <stdio.h>
int main() {
    int a[5] = {1, 2, 3, 4, 5};
    unsigned total = 0;
    for (int j = 0; j < sizeof(a); j++) {
        total += a[j];
        printf("j is %d\na[%d] is %d\ntotal is %d\n",j,j,a[j],total);
    }
    printf("sum of array is %d\n", total);
}
