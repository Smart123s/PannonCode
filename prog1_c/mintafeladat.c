// Start: 2023.08.13 18:15
// https://mik.uni-pannon.hu/docs/ismell/230731-a-programozas-alapjai-programozas-i-mintafeladatsor.pdf

#include <stdio.h>
#include <stdlib.h>

typedef struct spending {
    unsigned short day;
    char phase;
    unsigned int price;
} Spending;

typedef struct daysum {
    unsigned short day;
    unsigned int price;
} DaySum;

Spending* find(short day, char phase, Spending* v, short len) {
    for (int i = 0; i < len; i++) {
        Spending s = v[i];
        if (s.day == day && s.phase == phase) {
            return &v[i];
        }
    }
    return NULL;
}

Spending* bevitel(short *len) {
    printf("Napok szama maximum: ");
    scanf("%hd", len);
    Spending *v = malloc(*len * sizeof(Spending));

    short added_days = 0;
    while (added_days != *len) {
        short day;
        char phase;
        printf("Nap azonositoja: ");
        scanf("%hd", &day);

        if (day == 0) {
            // free up unused memory
            v = realloc(v, sizeof(Spending) * added_days);
            *len = added_days;
            return v;
        }

        printf("Napszak azonositoja: ");
        do {
            scanf("%c", &phase);
        } while (phase == '\n');

        Spending* s = find(day, phase, v, added_days);
        if (s == NULL) {
            s = &v[added_days];
            added_days++;
            s->day = day;
            s->phase = phase;
        }

        printf("Etkezes ara: ");
        scanf("%u", &s->price);
    }
    return v;
}

void kiir(Spending* v, short len) {
    printf("\n\n");
    for (int i = 0; i < len; i++) {
        printf("Nap %hd (%c) -> %u\n", v[i].day, v[i].phase, v[i].price);
    }
}

unsigned int osszegez(Spending* v, short len) {
    unsigned int sum = 0;
    for (short i = 0; i < len; i++) {
        sum += v[i].price;
    }
    return sum;
}

DaySum kigyujtNap(Spending* v, short len, short dayId) {
    DaySum r;
    r.day = dayId;
    r.price = 0;
    for (int i = 0; i < len; i++) {
        if (v[i].day == dayId) {
            r.price+=v[i].price;
        }
    }
    return r;
}

short legdragabbNap(Spending* v, short len) {
    short MAXLEN = 31;
    // itt nem ker dinamikus memoriakezelest a feladat
    // szoval get rekt optimalizacio
    unsigned int t[MAXLEN];
    for (short i = 0; i < MAXLEN; i++) {
        t[i] = 0;
    }
    for (short i = 0; i < len; i++) {
        Spending s = v[i];
        t[s.day]+=s.price;
    }

    //find max in t
    short max = 0;
    for (short i = 1; i < MAXLEN; i++) {
        if (t[i] > t[max]) {
            max = i;
        }
    }
    return max;
}

int main() {
    short len;
    Spending *v = bevitel(&len);
    kiir(v, len);

    printf("Osszes koltes: %u\n", osszegez(v, len));

    printf("Napi osszkoltsegek\n");
    short dayId;
    while(1==1) {
        printf("Nap azonositoja: ");
        scanf("%hd", &dayId);
        if (dayId == 0) {
            break;
        }
        for (short i = 0; i < len; i++) {
            if (v[i].day == dayId) {
                printf("Nap %hd (%c) -> %u\n", v[i].day, v[i].phase, v[i].price);
            }
        }
        printf("A %hd. nap osszkoltsege %dFt volt\n", dayId, kigyujtNap(v, len, dayId).price);
    }

    // legdragabb nap
    printf("Legdragabb nap\n");
    dayId = legdragabbNap(v, len);
    for (short i = 0; i < len; i++) {
        if (v[i].day == dayId) {
            printf("Nap %hd (%c) -> %u\n", v[i].day, v[i].phase, v[i].price);
        }
    }
    printf("A %hd. nap osszkoltsege %dFt volt\n", dayId, kigyujtNap(v, len, dayId).price);

    free(v);

    return 0;
}
