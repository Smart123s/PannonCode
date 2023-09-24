//
// Created by tombo on 9/24/2023.
//

#ifndef PROG2CPP_OSOBJEKTUM_H
#define PROG2CPP_OSOBJEKTUM_H

#include <string>
#include <iostream>

using namespace std;

class osobjektum {

    static int hatarertek;

public:
    virtual string megnevezes() const = 0;
    virtual int csucsok() const = 0;
    virtual int haromszogek() const = 0;
    void adatkiir() const {
        string cs = csucsok() > hatarertek ? "TUL SOK" : to_string(csucsok());
        string ha = haromszogek() > hatarertek ? "TUL SOK" : to_string(haromszogek());
        cout << "Nev: " << megnevezes() + ", csucsok: " << cs << ", haromszogek: " << ha << endl;
    }
    virtual ~osobjektum() {

    }

    static void setHatarertek(int h) {
        hatarertek = h;
    }

    static int getHatarertek() {
        return hatarertek;
    }

    bool operator < (osobjektum const &a) const {
        return this->csucsok() < a.csucsok();
    }

    friend ostream& operator<<(ostream& os, const osobjektum& o);

    int operator ~ () const {
        return this->haromszogek();
    }
};

ostream& operator<<(ostream& os, const osobjektum& o){
os << "Nev: " << o.megnevezes() + ", csucsok: " << o.csucsok() << ", haromszogek: " << o.haromszogek();
return os;
}

int osobjektum::hatarertek = 500;

#endif //PROG2CPP_OSOBJEKTUM_H
