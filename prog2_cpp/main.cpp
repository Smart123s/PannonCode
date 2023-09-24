#include <iostream>
#include <string>
#include <fstream>
#include <sstream>

using namespace std;


// A feladatokhoz #define direktivak kellenek, lasd: megoldott_feladatok.h
// A megoldott_feladatok.h fajlt is be kell adni!

#include "megoldott_feladatok.h"

#ifdef PART1a
#include "osobjektum.h"
#endif

#define OsObjektum osobjektum

#ifdef PART2
#include "kocka.h"
#endif

#ifdef PART3
#include "gula.h"
#endif

#ifdef PART4
#include "tetraeder.h"
#endif

#ifdef PART7a
#include "objektumtar.h"
#endif

#ifdef PART1b
class Teszt1 : public osobjektum
{
	int i;
public:
	Teszt1(int _i):i(_i){}
	string megnevezes() const override{return "Teszt1";}
	int csucsok() const override{return i;}
	int haromszogek() const override{return i;}
};

class Teszt2 : public osobjektum
{
	int c, h;
public:
	Teszt2(int _c, int _h):c(_c),h(_h){}
	string megnevezes() const override{return "Teszt2";}
	int csucsok() const override{return c;}
	int haromszogek() const override{return h;}
};
#endif

struct TesterGuard
{
	string partname;
	TesterGuard (const string& partname);
	~TesterGuard();
};


int main()
{
	cout << "main() eleje!" << endl << endl;


#ifdef PART1a
	{
		TesterGuard tguard("PART1a");
		osobjektum *obj1=nullptr;
		if (!obj1){
			cout << "osobjektum virtual destruktor: " << (has_virtual_destructor<osobjektum>::value ? "IGEN" : "NEM") << endl;
		}
	}//
#endif



#ifdef PART1b
	{
		TesterGuard tguard("PART1b");
		cout << "osobjektum absztrakt: " << (is_abstract<osobjektum>::value ? "IGEN" : "NEM") << endl;
		const osobjektum *obj1=new Teszt1(6);
		const osobjektum *obj2=new Teszt2(80, 140);
		cout << obj1->megnevezes() << " " << obj1->csucsok() << " " << obj1->haromszogek() << endl;
		cout << obj2->megnevezes() << " " << obj2->csucsok() << " " << obj2->haromszogek() << endl;
		delete obj1;
		delete obj2;
	}//
#endif



#ifdef PART1c
	{
		TesterGuard tguard("PART1c");
		const osobjektum *obj1=new Teszt1(6);
		const osobjektum *obj2=new Teszt2(80, 140);
		obj1->adatkiir();
		obj2->adatkiir();
		delete obj1;
		delete obj2;
	}//
#endif



#ifdef PART2
	{
		TesterGuard tguard("PART2");
		cout << "Kocka az OsObjektum gyerekosztalya: " << (is_base_of<OsObjektum,Kocka>::value?"IGEN":"NEM") << endl;
		const OsObjektum *obj1=new Kocka();
		cout << obj1->megnevezes() << " " << obj1->csucsok() << " " << obj1->haromszogek() << endl;
		delete obj1;
	}//
#endif



#ifdef PART3
	{
		TesterGuard tguard("PART3");
		cout << "Gula az OsObjektum gyerekosztalya: " << (is_base_of<OsObjektum,Gula>::value?"IGEN":"NEM") << endl;
		const OsObjektum *obj1=new Gula(5);
		const OsObjektum *obj2=new Gula(20);
		const OsObjektum *obj3=new Gula(100);
		cout << obj1->megnevezes() << " " << obj1->csucsok() << " " << obj1->haromszogek() << endl;
		cout << obj2->megnevezes() << " " << obj2->csucsok() << " " << obj2->haromszogek() << endl;
		cout << obj3->megnevezes() << " " << obj3->csucsok() << " " << obj3->haromszogek() << endl;
		delete obj1;
		delete obj2;
		delete obj3;
	}//
#endif



#ifdef PART4
	{
		TesterGuard tguard("PART4");
		cout << "TetraEder a Gula gyerekosztalya: " << (is_base_of<Gula,TetraEder>::value?"IGEN":"NEM") << endl;
		const OsObjektum *obj1=new TetraEder();
		cout << obj1->megnevezes() << " " << obj1->csucsok() << " " << obj1->haromszogek() << endl;
		delete obj1;
	}//
#endif



#ifdef PART5a
	{
		TesterGuard tguard("PART5a");
		Teszt1 t1(6);
		Teszt2 t2(5,9);
		Teszt1 t3(12);
		cout << "t1<t2 : " << (t1<t2) << endl;
		cout << "t1<t2 : " << (t1<t3) << endl;
		cout << "t2<t1 : " << (t2<t1) << endl;
		cout << "t2<t3 : " << (t2<t3) << endl;
		cout << "t3<t1 : " << (t3<t1) << endl;
		cout << "t3<t2 : " << (t3<t2) << endl;
	}//
#endif



#ifdef PART5b
	{
		TesterGuard tguard("PART5b");
		Teszt1 t1(6);
		Teszt2 t2(5,9);
		Teszt1 t3(12);
		cout << t1 << endl << t2 << endl << t3 << endl;
		{
			ofstream out("out.txt");
			out << t3 << endl << t2 << endl << t1 << endl;
		}
		cout << "fajlban:" << endl;
		{
			ifstream in("out.txt");
			cout << in.rdbuf();
		}
	}//
#endif



#ifdef PART5c
	{
		TesterGuard tguard("PART5c");
		Teszt1 t1(6);
		Teszt2 t2(5,9);
		Teszt1 t3(12);
		cout << "~t1 : " << (~t1) << endl;
		cout << "~t2 : " << (~t2) << endl;
		cout << "~t3 : " << (~t3) << endl;
	}//
#endif



#ifdef PART6a
	{
		TesterGuard tguard("PART6a");
		cout << OsObjektum::getHatarertek() << endl;
		OsObjektum::setHatarertek(165);
		cout << OsObjektum::getHatarertek() << endl;
		OsObjektum::setHatarertek(1000);
		cout << OsObjektum::getHatarertek() << endl;
	}//
#endif



#ifdef PART6b
	{
		TesterGuard tguard("PART6b");
		const OsObjektum *obj1=new Teszt1(234);
		const OsObjektum *obj2=new Teszt2(121, 4253);
		obj1->adatkiir();
		obj2->adatkiir();
		OsObjektum::setHatarertek(165);
		obj1->adatkiir();
		obj2->adatkiir();
		OsObjektum::setHatarertek(1000);
		obj1->adatkiir();
		obj2->adatkiir();
		delete obj1;
		delete obj2;
	}//
#endif



#ifdef PART7a
	{
		TesterGuard tguard("PART7a");
		ObjektumTar *ot=nullptr;
		if (!ot) cout << "Latszolag rendben" << endl;
	}//
#endif



#ifdef PART7b
	{
		TesterGuard tguard("PART7b");
		ObjektumTar ot;
		ot.hozzaad(new Teszt1(6));
		ot.hozzaad(new Teszt2(7,134));
		ot.hozzaad(new Teszt2(1,25));
		ot.hozzaad(new Teszt1(64));
		ot.hozzaad(new Teszt2(87,243));
		cout << "Latszolag rendben" << endl;
	}//
#endif



#ifdef PART7c
	{
		TesterGuard tguard("PART7c");
		ObjektumTar ot;
		cout << ot.darabszam() << endl;
		ot.hozzaad(new Teszt1(6));
		cout << ot.darabszam() << endl;
		ot.hozzaad(new Teszt2(7,134));
		cout << ot.darabszam() << endl;
		ot.hozzaad(new Teszt2(1,25));
		cout << ot.darabszam() << endl;
		ot.hozzaad(new Teszt1(64));
		cout << ot.darabszam() << endl;
		ot.hozzaad(new Teszt2(87,243));
		cout << ot.darabszam() << endl;
	}//
#endif



#ifdef PART7d
	{
		TesterGuard tguard("PART7d");
		ObjektumTar ot;
		ot.hozzaad(new Teszt1(6));
		ot.hozzaad(new Teszt2(7,134));
		ot.hozzaad(new Teszt2(1,25));
		ot.hozzaad(new Teszt1(64));
		ot.hozzaad(new Teszt2(87,243));
		for (int i=0; i<5; i++)
		{
			OsObjektum *obj = ot.leker(i);
			if (obj!=nullptr) cout << obj->megnevezes() << " " << obj->csucsok() << " " << obj->haromszogek() << endl;
			else cout << "nullptr" << endl;
		}
	}//
#endif



#ifdef PART7e
	{
		TesterGuard tguard("PART7e");
		ObjektumTar ot;
		ot.hozzaad(new Teszt2(6,32));
		ot.hozzaad(new Teszt1(231));
		ot.hozzaad(new Teszt2(1,2));
		ot.hozzaad(new Teszt2(63,544));
		ot.hozzaad(new Teszt1(123));
		for (int i=0; i<10; i++)
		{
			OsObjektum *obj = ot.leker((i*3)%10);
			if (obj!=nullptr) cout << obj->megnevezes() << " " << obj->csucsok() << " " << obj->haromszogek() << endl;
			else cout << "nullptr" << endl;
		}
	}//
#endif



#ifdef PART7f
	{
		TesterGuard tguard("PART7f");
		ObjektumTar ot;
		ot.hozzaad(new Teszt2(43,32));
		OsObjektum *obj = ot.legkevesebbCsucs();
		if (obj!=nullptr) cout << obj->megnevezes() << " " << obj->csucsok() << " " << obj->haromszogek() << endl;
		else cout << "nullptr" << endl;
		ot.hozzaad(new Teszt1(23));
		obj = ot.legkevesebbCsucs();
		if (obj!=nullptr) cout << obj->megnevezes() << " " << obj->csucsok() << " " << obj->haromszogek() << endl;
		else cout << "nullptr" << endl;
		ot.hozzaad(new Teszt2(63,544));
		obj = ot.legkevesebbCsucs();
		if (obj!=nullptr) cout << obj->megnevezes() << " " << obj->csucsok() << " " << obj->haromszogek() << endl;
		else cout << "nullptr" << endl;
		ot.hozzaad(new Teszt2(12,24));
		obj = ot.legkevesebbCsucs();
		if (obj!=nullptr) cout << obj->megnevezes() << " " << obj->csucsok() << " " << obj->haromszogek() << endl;
		else cout << "nullptr" << endl;
		ot.hozzaad(new Teszt1(123));
		obj = ot.legkevesebbCsucs();
		if (obj!=nullptr) cout << obj->megnevezes() << " " << obj->csucsok() << " " << obj->haromszogek() << endl;
		else cout << "nullptr" << endl;
	}//
#endif




	cout << "main() vege!" << endl;
	return 0;
}

TesterGuard::TesterGuard(const string &p):
	partname(p)
{
	cout << endl << "----START OF " << partname << "----" << endl << endl;
}

TesterGuard::~TesterGuard()
{
	cout << endl << "----END OF " << partname << "----" << endl << endl;
}
