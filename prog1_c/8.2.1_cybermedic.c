// https://github.com/pekmil/CTutorial/blob/master/Programoz%C3%A1s%20I%20-%20Feladatgy%C5%B1jtem%C3%A9ny%20v1.0.pdf
// Feladat 8.2.1

#include <stdio.h>
#include <time.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

typedef unsigned int uint;

typedef struct CyberMedic {
    char ip[16];
    char name[31];
} CyberMedic;

typedef struct Computer {
    uint id;
    int manufacture_year;
    uint repair_count;
    CyberMedic* medic;
} Computer;

int med_sort_by_name(CyberMedic a, CyberMedic b) {
    /*for (int i = 0; i < 31; i++) {
        if (a.name[i] != b.name[i]) {
            return a.name[i] - b.name[i];
        }
    }
    return 0;*/
    return strcmp(a.name, b.name);
}

CyberMedic* findMed(CyberMedic* meds, char* ip) {
    for (int i = 0; i < 5; i++) {
        if (strcmp(ip, meds[i].ip) == 0) {
            return &meds[i];
        }
    }
    return NULL;
}

Computer* create_comps(int size) {
    return malloc(sizeof(Computer) * size);
}

Computer* find_oldest(Computer* comps, int size) {
    Computer* oldest = &comps[0];
    for (int i = 1; i < size; i++) {
        if (comps[i].manufacture_year < oldest->manufacture_year) {
            oldest = &comps[i];
        }
    }
    return oldest;
}

int repair_comps(Computer* comps, CyberMedic* medic, int comps_size) {
    int i = 0;
    for (; i < comps_size; i++) {
        comps[i].medic = medic;
        comps[i].repair_count++;
    }
    return i;
}

int main (){
    int MEDS_LEN = 5;
    CyberMedic meds[MEDS_LEN];
    FILE* def_inp = fopen("..\\def_in.txt", "r");
    for (int i = 0; i < 5; i ++) {
        fscanf(def_inp, "%s", meds[i].ip);
        fscanf(def_inp, "%s", meds[i].name);
    }
    fclose(def_inp);

    qsort(meds, MEDS_LEN, sizeof(CyberMedic), (int (*)(const void *, const void *)) med_sort_by_name);
    for (int i = 0; i < 5; i ++) {
        printf("%s %s\n", meds[i].ip, meds[i].name);
    }

    printf("Adja meg a szamitogepek szamat: ");
    int COMP_SIZE;
    scanf("%d", &COMP_SIZE);
    Computer* computers = create_comps(COMP_SIZE);

    for (int i = 0; i < COMP_SIZE; i++) {
        char tip[15];
        scanf("%u %d %u %s", &computers[i].id, &computers[i].manufacture_year, &computers[i].repair_count, tip);
        computers[i].medic = findMed(meds, tip);
    }

    for (int i = 0; i < COMP_SIZE; i++) {
        Computer ic = computers[i];
        CyberMedic med = *ic.medic;
        printf("%u %d %u %s %s\n", ic.id, ic.manufacture_year, ic.repair_count, med.name, med.ip);
    }

    Computer oldest = *find_oldest(computers, COMP_SIZE);
    Computer ic = oldest;
    CyberMedic med = *ic.medic;
    printf("%u %d %u %s %s\n", ic.id, ic.manufacture_year, ic.repair_count, med.name, med.ip);

    printf("Adj medicet: ");
    char n[16];
    scanf("%s", n);
    CyberMedic* med2 = findMed(meds, n);
    repair_comps(computers, med2, COMP_SIZE);

    free(computers);

    /*for (int i = 0; i < COMP_SIZE; i++) {
        Computer ic = computers[i];
        CyberMedic med = *ic.medic;
        printf("%u %d %u %s %s\n", ic.id, ic.manufacture_year, ic.repair_count, med.name, med.ip);
    }*/

    // print a random number between 1-10 cuz why not
    /*srand(time(NULL));
    printf("%d", rand() % 10 + 1);*/

}