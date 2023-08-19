#include <stdio.h>
#include <time.h>
#include <stdlib.h>

int main (){
    srand(time(NULL));
    FILE *f = fopen("..\\in.txt", "r");
    int len, max;
    fscanf(f, "%d %d", &len, &max);
    char test_string[20];
    fscanf(f, "%s", test_string);
    printf("Test stering: %s\n", test_string);
    printf("Length: %d\nMaximum: %d\n", len, max);

    FILE *of = fopen("..\\out.txt", "w");
    for (int i = 0; i < len; i++) {
        int num = rand() % max;
        printf("%d\n", num);
        fprintf(of, "%d\n", num);
    }

    fclose(of);
    fclose(f);

    return 0;
}