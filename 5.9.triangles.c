#include <stdio.h>

typedef struct cord {
    int x;
    int y;
} Cord;

typedef struct triangle {
    Cord cords[3];
} Triangle;

int main() {
    Triangle v[2];

    v[0].cords[0].x = 5;
    v[0].cords[0].y = 6;
    v[0].cords[1].x = 7;
    v[0].cords[1].y = 8;
    v[0].cords[2].x = 9;
    v[0].cords[2].y = 10;

    printf("%d", v[0].cords[2].x);
    return 0;
}
