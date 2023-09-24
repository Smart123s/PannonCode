//
// Created by tombo on 9/24/2023.
//

#ifndef PROG2CPP_OBJEKTUMTAR_H
#define PROG2CPP_OBJEKTUMTAR_H


#include <vector>
#include "osobjektum.h"

class ObjektumTar {

    vector<osobjektum*> v;

public:
    void hozzaad(osobjektum* o) {
        v.push_back(o);
    }

    ~ObjektumTar() {
        for (auto o : v) {
            delete(o);
        }
    }

    unsigned long darabszam() {
        return v.size();
    }

    osobjektum* leker(long i) {
        if (v.size() - 1 < i) {
            return NULL;
        }
        return v.at(i);
    }

    osobjektum* legkevesebbCsucs() {
        osobjektum* min = v.at(0);
        for (auto o : v) {
            if (o->csucsok() < min->csucsok()) {
                min = o;
            }
        }
        return min;
    }

};


#endif //PROG2CPP_OBJEKTUMTAR_H
