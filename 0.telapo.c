#include <stdio.h>
#include <stdlib.h>

typedef unsigned int uint;

typedef struct present {
    char name[21];
    float min_goodness;
} Present;

typedef struct kid {
    char name[21];
    uint age;
    float goodness;
    Present *present;
} Kid;

void print_kid(Kid kid) {
    printf("\tNev: %s\n", kid.name);
    printf("\tEletkor (ev): %u\n", kid.age);
    printf("\tJosag-index (0.0-10.0): %f\n", kid.goodness);
    if (kid.present) {
        printf("\tAjandek neve: %s (Min. josag: %f)\n", (*kid.present).name, (*kid.present).min_goodness);
    } else {
        printf("\tNincs ajandeka.\n");
    }
}

/**
 * Read data from stdin
 * @param kids array of Kid struct
 * @param kids_l Length of the above array
 */
void readData(Kid *kids, int kids_l, int start) {
    for (int i = start; i < kids_l; i++) {
        printf("%d. gyerek adatai\n\tNev: ", i);
        scanf("%s", kids[i].name);
        printf("\tEletkor (ev): ");
        scanf("%u", &kids[i].age);
        printf("\tJosag-index (0.0-10.0): ");
        scanf("%f", &kids[i].goodness);
        kids[i].present = NULL;
    }
}

void readDataFeladat(Kid *kids, int kids_l) {
    readData(kids, kids_l, 0);
}

/**
 * Write stored data to stdout
 * @param kids array of Kid struct
 * @param kids_l Length of the above array
 */
void writeData(Kid *kids, int kids_l) {
    for (int i = 0; i < kids_l; i++) {
        printf("%d. gyerek adatai\n", i);
        print_kid(kids[i]);
    }
}

/**
 * Returns the number of bad kids
 * @param kids array of Kid struct
 * @param kids_l Length of the above array
 */
int bad(Kid *kids, int kids_l) {
    printf("Rossz gyerekek nevei:\n");
    int a = 0;
    for (int i = 0; i < kids_l; i++) {
        Kid kid = kids[i];
        if (kid.age < 10 && kid.goodness < 3.5) {
            a++;
            printf("\t%s\n", kid.name);
        }
    }
    return a;
}

int comp(const void* a, const void* b) {
    Kid A = *(Kid*) a;
    Kid B = *(Kid*) b;
    return B.goodness - A.goodness;
}

/**
 * Sort array based on goodness (desc.)
 * @param kids array of Kid struct
 * @param kids_l Length of the above array
 */
void sorter(Kid *kids, int kids_l) {
    qsort(kids, kids_l, sizeof(Kid), comp);
}

int main() {
    // read length of kids
    printf("Gyerekek szama: ");
    int kids_l;
    scanf("%d", &kids_l);

    // allocate memory for kids array
    Kid *kids = malloc(sizeof(Kid) * kids_l);
    readDataFeladat(kids, kids_l);

    // Read present data
    Present presents[5];
    printf("Ajandekok megadasa:\n");
    for (int i = 0; i < 5; i++) {
        printf("%d. ajándék neve: ", i);
        scanf("%s", presents[i].name);
        scanf("%f", &presents[i].min_goodness);
    }

    kids[0].present = &presents[0];
    kids[1].present = &presents[1];
    kids[2].present = &presents[2];

    writeData(kids, kids_l);

    int badKids = bad(kids, kids_l);
    printf("Rossz gyerekek szama: %d\n", badKids);

    printf("Legjobb gyerekek: \n");
    sorter(kids, kids_l);
    for (int i = 0; i < 3; i++) {
        printf("%d.\n", i);
        print_kid(kids[i]);
    }

    printf("Uj gyerekek szama: ");
    int new_kids;
    scanf("%d", &new_kids);

    int kids_l_original = kids_l;
    kids_l += new_kids;
    realloc(kids, kids_l * sizeof(Kid));

    readData(kids, kids_l, kids_l_original);
    writeData(kids, kids_l);

    return 0;
}