//
// Created by tombo on 9/24/2023.
//

#ifndef PROG2CPP_KOCKA_H
#define PROG2CPP_KOCKA_H


#include "osobjektum.h"

class Kocka : public osobjektum {

public:
    string megnevezes() const override {
        return "Kocka";
    }

    int csucsok() const override {
        return 8;
    }

    int haromszogek() const override {
        return 12;
    }

};


#endif //PROG2CPP_KOCKA_H
