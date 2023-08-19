#include <stdio.h>

int main() {
    printf("%s", "Hello world!\n");
    printf("%s", "Enter a number: ");
    int i;
    scanf("%d", &i);
    printf("You have entered %d", i);
    return 0;
}