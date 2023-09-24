//
// Created by tombo on 9/24/2023.
//

#ifndef PROG2CPP_GULA_H
#define PROG2CPP_GULA_H


#include "osobjektum.h"

class Gula : public osobjektum {

    int oldalak;

public:
    explicit Gula(int oldalak) {
        this->oldalak = oldalak;
    }

    void setOldalak(int oldalak) {
        this->oldalak = oldalak;
    }

    int getOldalak() const {
        return oldalak;
    };

    string megnevezes() const override {
        return "Gula";
    }

    int csucsok() const override {
        return oldalak + 1;
    }

    int haromszogek() const override {
        return oldalak * 2 - 2;
    }

};


#endif //PROG2CPP_GULA_H
