_Készítette: Csontos Balázs_

_Hibajelentés és javaslat:_ [_csontos.balazs@mik.uni-pannon.hu_](mailto:csontos.balazs@mik.uni-pannon.hu)

_A dokumentum verziója: 9_

**ZÁRTHELYI 1. ALGORITMUSOK**

**I. Holtpont**

_I/1. Biztonságos sorozat keresés (amely alapja, hogy a folyamat csak maximális erőforrás megléte esetén fut csak le)_

Adott egy rendszer, amelyben 1 erőforrás osztály van, 10 erőforrással. A rendszerben 3 folyamat (P1, P2, P3) található, amelyek az alábbi foglalásokkal F=(3, 2, 2) és maximális igényekkel M=(9, 4, 7) rendelkeznek. Ha úgy véli, hogy a rendszer biztonságos állapotban van, akkor adja meg a folyamatoknak egy biztonságos sorrendjét, különben jelölje az összeset „-„ jellel:

Biztonságos sorozat:

|     | 🡪  |     | 🡪  |     |
| --- | --- | --- | --- | --- |

1\. lépés: Elkészítem a kiindulási táblázatot a megadott adatok alapján. Szükségünk van egy Foglal, egy Max, és egy Még oszlopra. Mivel a rendszerben 3 folyamat található meg (P1, P2, P3), így 3 sorra. A foglalásokat F=(3, 2, 2) a Foglal oszlopba, a maximális igényeket M=(9, 4, 7) a Max oszlopba írom be. A Még oszlopot kitöltöm a Max és a Foglal oszlopok értékeinek különbsége alapján. Utolsó lépésként összeadom a foglalt erőforrások számát, majd megnézem, hogy hány szabad maradt a 10 erőforrásból. Ezt az értéket a Szabad sorba írom be.

|     | Foglal | Max | Még |
| --- | --- | --- | --- |
| P1  | 3   | 9   | 6   |
| P2  | 2   | 4   | 2   |
| P3  | 2   | 7   | 5   |
| Szabad: 3 |     |     |     |

2\. lépés: A szabad erőforrások száma alapján meghatározom, hogy melyik folyamat erőforrás igényét tudom maximálisan kielégíteni. A választásom a P2 folyamatra esett mivel neki még 2 szabad erőforrásra van szüksége. Ezt követően a foglalt erőforrások számát (Foglal) a maximum értékre, a kérhető erőforrások számát (Még) pedig 0 értékre állítom. Végül összeadom a foglalt erőforrásokat, és kivonom a rendszerben lévő erőforrásokat számából: 10-9=1. Az szabad erőforrások száma 1 lesz.

|     | Foglal | Max | Még |
| --- | --- | --- | --- |
| P1  | 3   | 9   | 6   |
| P2  | 4   | 4   | 0   |
| P3  | 2   | 7   | 5   |
| Szabad: 1 |     |     |     |

3\. lépés: Lefut a P2 folyamat és visszaadja az általa foglalt erőforrásokat, így a szabad erdőforrások száma 5 lesz.

|     | Foglal | Max | Még |
| --- | --- | --- | --- |
| P1  | 3   | 9   | 6   |
| P2  | \-  | \-  | \-  |
| P3  | 2   | 7   | 5   |
| Szabad: 5 |     |     |     |

4\. lépés: A szabad erőforrások száma alapján újra meghatározom, hogy melyik folyamat erőforrás igényét tudom maximálisan kielégíteni. A választásom a P3 folyamatra esett mivel neki még 5 szabad erőforrásra van szüksége. Ezt követően a foglalt erőforrások számát (Foglal) a maximum értékre, a kérhető erőforrások számát (Még) pedig 0 értékre állítom. Végül összeadom a foglalt erőforrásokat, és kivonom a rendszerben lévő erőforrásokat számából: 10-10=0. Az szabad erőforrások száma 0 lesz.

|     | Foglal | Max | Még |
| --- | --- | --- | --- |
| P1  | 3   | 9   | 6   |
| P2  | \-  | \-  | \-  |
| P3  | 7   | 7   | 0   |
| Szabad: 0 |     |     |     |

5\. lépés: Lefut a P3 folyamat és visszaadja az általa foglalt erőforrásokat, így a szabad erdőforrások száma 7 lesz.

|     | Foglal | Max | Még |
| --- | --- | --- | --- |
| P1  | 3   | 9   | 6   |
| P2  | \-  | \-  | \-  |
| P3  | \-  | \-  | \-  |
| Szabad: 7 |     |     |     |

6\. lépés: A szabad erőforrások száma alapján újra meghatározom, hogy melyik folyamat erőforrás igényét tudom maximálisan kielégíteni. A választásom a P1 folyamatra esett mivel neki még 6 szabad erőforrásra van szüksége. Ezt követően a foglalt erőforrások számát (Foglal) a maximum értékre, a kérhető erőforrások számát (Még) pedig 0 értékre állítom. Végül összeadom a foglalt erőforrásokat, és kivonom a rendszerben lévő erőforrásokat számából: 10-9=1. Az szabad erőforrások száma 1 lesz.

|     | Foglal | Max | Még |
| --- | --- | --- | --- |
| P1  | 9   | 9   | 0   |
| P2  | \-  | \-  | \-  |
| P3  | \-  | \-  | \-  |
| Szabad: 1 |     |     |     |

7\. lépés: Lefut a P1 folyamat és visszaadja az általa foglalt erőforrásokat, így a szabad erdőforrások száma 10 lesz.

|     | Foglal | Max | Még |
| --- | --- | --- | --- |
| P1  | \-  | \-  | \-  |
| P2  | \-  | \-  | \-  |
| P3  | \-  | \-  | \-  |
| Szabad: 10 |     |     |     |

8\. lépés: Mivel mindegyik folyamat erőforrásigényét teljesíteni lehetett, így meg lehet határozni egy biztonságos sorozatot:

| P2  | 🡪  | P3  | 🡪  | P1  |
| --- | --- | --- | --- | --- |

_I/2. Coffman algoritmus_

A Coffman algoritmus segítségével állapítsa meg, hogy van-e holtpont, ha a rendszerben négy folyamatunk van (P1, P2, P3 és P4), amelyek három erőforrásosztályból már foglalnak néhány erőforrást, de továbbiakat is igényelnek a következő táblázat szerint:

|     | Foglal |     |     | Kér |     |     | Szabad |     |     |
| --- | --- |     |     | --- |     |     | --- |     |     | --- | --- | --- | --- | --- | --- |
|     | A   | B   | C   | A   | B   | C   | A   | B   | C   |
| P1  | 1   | 4   | 0   | 0   | 0   | 5   | 5   | 1   | 0   |
| P2  | 5   | 1   | 3   | 2   | 0   | 2   | &nbsp; |     | &nbsp; |
| P3  | 1   | 0   | 3   | 0   | 2   | 0   | &nbsp; |     | &nbsp; |
| P4  | 2   | 4   | 1   | 4   | 0   | 0   | &nbsp; | &nbsp; | &nbsp; |

Ha úgy véli, hogy a rendszerben nincs holtpont, akkor adja meg a folyamatoknak egy biztonságos sorozatát, különben jelölje az összeset „-„ jellel:

Biztonságos sorozat:

|     | 🡪  |     | 🡪  |     | 🡪  |     |
| --- | --- | --- | --- | --- | --- | --- |

1\. lépés: Olyan folyamatot keresek, amely erőforrásigényét teljesíteni tudom a szabad erőforrások (A:5, B:1, C:0) függvényében. A választásom a P4 folyamatra esett, mivel az ő erőforrásigénye (A:4, B:0, C:0) teljesíthető.

2\. lépés: P4 foglalt erőforrásait hozzáadom a szabad erőforrásokhoz:

5 + 2 = 7, 1 + 4 = 5, 1 + 0 = 1. A szabad erőforrások száma: A:7, B:5, C:1

3\. lépés: A P4 által kért erőforrásokat áthelyezem a Foglal oszlopba. Mivel a P4 nem kér több erőforrást a lefutáshoz, így a P4-hez tartozó Kér oszlop mezői kihúzhatók.

|     | Foglal |     |     | Kér |     |     | Szabad |     |     |
| --- | --- |     |     | --- |     |     | --- |     |     | --- | --- | --- | --- | --- | --- |
|     | A   | B   | C   | A   | B   | C   | A   | B   | C   |
| P1  | 1   | 4   | 0   | 0   | 0   | 5   | 7   | 5   | 1   |
| P2  | 5   | 1   | 3   | 2   | 0   | 2   | &nbsp; |     | &nbsp; |
| P3  | 1   | 0   | 3   | 0   | 2   | 0   | &nbsp; |     | &nbsp; |
| P4  | 4   | 0   | 0   | \-  | \-  | \-  | &nbsp; | &nbsp; | &nbsp; |

4\. lépés: Újra megvizsgálom, hogy tudok-e találni olyan folyamatot, amely erőforrásigényét teljesíteni tudom a szabad erőforrások (A:7, B:5, C:1) függvényében. A választásom a P3 folyamatra esett, mivel az ő erőforrásigénye (A:0, B:2, C:0) teljesíthető.

5\. lépés: P3 foglalt erőforrásait hozzáadom a szabad erőforrásokhoz:

7 + 1 = 8, 5 + 0 = 5, 1 + 3 = 4. A szabad erőforrások száma: A:8, B:5, C:4.

6\. lépés: A P3 által kért erőforrásokat áthelyezem a Foglal oszlopba. Mivel a P3 nem kér több erőforrást a lefutáshoz, így a P3-hez tartozó Kér oszlop mezői kihúzhatók.

|     | Foglal |     |     | Kér |     |     | Szabad |     |     |
| --- | --- |     |     | --- |     |     | --- |     |     | --- | --- | --- | --- | --- | --- |
|     | A   | B   | C   | A   | B   | C   | A   | B   | C   |
| P1  | 1   | 4   | 0   | 0   | 0   | 5   | 8   | 5   | 4   |
| P2  | 5   | 1   | 3   | 2   | 0   | 2   | &nbsp; |     | &nbsp; |
| P3  | 0   | 2   | 0   | \-  | \-  | \-  | &nbsp; |     | &nbsp; |
| P4  | 4   | 0   | 0   | \-  | \-  | \-  | &nbsp; | &nbsp; | &nbsp; |

7\. lépés: Újra megvizsgálom, hogy tudok-e találni olyan folyamatot, amely erőforrásigényét teljesíteni tudom a szabad erőforrások (A:8, B:5, C:4) függvényében. A választásom a P2 folyamatra esett, mivel az ő erőforrásigénye (A:2, B:0, C:2) teljesíthető.

8\. lépés: P2 foglalt erőforrásait hozzáadom a szabad erőforrásokhoz:

8 + 5 = 13, 5 + 1 = 6, 4 + 3 = 7. A szabad erőforrások száma: A:13, B:6, C:7

9\. lépés: A P2 által kért erőforrásokat áthelyezem a Foglal oszlopba. Mivel a P2 nem kér több erőforrást a lefutáshoz, így a P2-hez tartozó Kér oszlop mezői kihúzhatók.

|     | Foglal |     |     | Kér |     |     | Szabad |     |     |
| --- | --- |     |     | --- |     |     | --- |     |     | --- | --- | --- | --- | --- | --- |
|     | A   | B   | C   | A   | B   | C   | A   | B   | C   |
| P1  | 1   | 4   | 0   | 0   | 0   | 5   | 13  | 6   | 7   |
| P2  | 2   | 0   | 2   | \-  | \-  | \-  | &nbsp; |     | &nbsp; |
| P3  | 0   | 2   | 0   | \-  | \-  | \-  | &nbsp; |     | &nbsp; |
| P4  | 4   | 0   | 0   | \-  | \-  | \-  | &nbsp; | &nbsp; | &nbsp; |

10\. lépés: Újra megvizsgálom, hogy tudok-e találni olyan folyamatot, amely erőforrásigényét teljesíteni tudom a szabad erőforrások (A:13, B:6, C:7) függvényében. A választásom a P1 folyamatra esett, mivel az ő erőforrásigénye (A:0, B:0, C:5) teljesíthető.

11\. lépés: P1 foglalt erőforrásait hozzáadom a szabad erőforrásokhoz:

13 + 1 = 14, 6 + 4 = 10, 7 + 0 = 7. A szabad erőforrások száma: A:14, B:10, C:7

12\. lépés: A P1 által kért erőforrásokat áthelyezem a Foglal oszlopba. Mivel a P1 nem kér több erőforrást a lefutáshoz, így a P1-hez tartozó Kér oszlop mezői kihúzhatók.

|     | Foglal |     |     | Kér |     |     | Szabad |     |     |
| --- | --- |     |     | --- |     |     | --- |     |     | --- | --- | --- | --- | --- | --- |
|     | A   | B   | C   | A   | B   | C   | A   | B   | C   |
| P1  | 0   | 0   | 5   | \-  | \-  | \-  | 14  | 10  | 7   |
| P2  | 2   | 0   | 2   | \-  | \-  | \-  | &nbsp; |     | &nbsp; |
| P3  | 0   | 2   | 0   | \-  | \-  | \-  | &nbsp; |     | &nbsp; |
| P4  | 4   | 0   | 0   | \-  | \-  | \-  | &nbsp; | &nbsp; | &nbsp; |

13\. lépés: Mivel mindegyik folyamat erőforrásigényét teljesíteni lehetett, így meg lehet határozni egy biztonságos sorozatot:

| P4  | 🡪  | P3  | 🡪  | P2  | 🡪  | P1  |
| --- | --- | --- | --- | --- | --- | --- |

**II. Ütemezés**

_II/1. Legrégebben várakozó (First Come First Served, FCFS)_

_Adott öt folyamat P=(1, 2, 3, 4, 5), amelyeknek futásideje C=(1, 2, 6, 5, 3). A folyamatok T=(2, 4, 5, 0, 8) időpontban kerülnek futásra kész állapotba. A rendszerben legrégebben várakozó (FCFS) CPU ütemezés működik._

_Adja meg a folyamatok ütemezését:_

|     | 🡪  |     | 🡪  |     | 🡪  |     | 🡪  |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |

1\. lépés: Elkészítem a kiindulási táblázatot a megadott adatok alapján. A folyamatokat az 1. oszlopba, a folyamatok futásra állapotainak idejét (T) a 2. oszlopba, még a futási időt (C) a harmadik oszlopba írom be.

|     | Érkezik | CPU-idő |
| --- | --- | --- |
| P1  | 2   | 1   |
| P2  | 4   | 2   |
| P3  | 5   | 6   |
| P4  | 0   | 5   |
| P5  | 8   | 3   |

2\. lépés: Az algoritmus alapja, hogy az a folyamat lesz leghamarabb kiszolgálva, amelyik leghamarabb érkezett meg futásra kész állapotba. Érkezési sorrendben a folyamatok ütemezése a következő:

| P4  | 🡪  | P1  | 🡪  | P2  | 🡪  | P3  | 🡪  | P5  |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |

_II/2. Körbeforgó (Round Robin, RR)_

Adott négy folyamat P=(1, 2, 3, 4), amelyeknek futásideje C=(3, 6, 2, 5). A folyamatok T=(1, 3, 0, 5) időpontban kerülnek futásra kész állapotba. A rendszerben körforgó (RR) CPU ütemezés működik, az időszelet hossza 3 ms.

Adja meg a folyamatok ütemezését:

|     | 🡪  |     | 🡪  |     | 🡪  |     | 🡪  |     | 🡪  |     | 🡪  |     | 🡪  |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |

(Ha valamelyik helyre már nincs mit ütemezni, akkor jelölje "-" jellel!)

1\. lépés: Elkészítem a kiindulási táblázatot a megadott adatok alapján. A folyamatokat az 1. oszlopba, a folyamatok futásra állapotainak idejét (T) a 2. oszlopba, még a futási időt (C) a harmadik oszlopba írom be.

|     | Érkezik | CPU-idő | Indul | Vége | Vár |
| --- | --- | --- | --- | --- | --- |
| P1  | 1   | 3   |     |     |     |
| P2  | 3   | 6   |     |     |     |
| P3  | 0   | 2   |     |     |     |
| P4  | 5   | 5   |     |     |     |

2\. lépés: Megkeresem a legkorábban érkező folyamatot (P3), majd az érkezési idejét, beírom az Indul oszlop megfelelő helyére. Mivel a P3 folyamat CPU-ideje (2) kisebb, mint az időszelet hossza (3), így az indulási időhöz hozzáadom a CPU-időt, majd ezt az értéket a Vége oszlop megfelelő sorába írom be. Végül, mivel a folyamatnak nem kellett várakoznia, így a Vár oszlop megfelelő sorába a 0 értéket írom be.

|     | Érkezik | CPU-idő | Indul | Vége | Vár |
| --- | --- | --- | --- | --- | --- |
| P1  | 1   | 3   |     |     |     |
| P2  | 3   | 6   |     |     |     |
| P3  | 0   | 2   | 0   | 2   | 0   |
| P4  | 5   | 5   |     |     |     |

3\. lépés: Megkeresem a következő legkorábban érkező folyamatot (P1), majd az indulási idejének megadom az előző folyamat (P3) végzési idejét. Mivel a P1 folyamat CPU-ideje (3) megegyezik az időszelet hosszával (3), így az indulási időhöz hozzáadom a CPU-időt, majd ezt az értéket (5) a Vége oszlop megfelelő sorába írom be. Végül, mivel a P1 folyamat az 1. időszeletben érkezett, de csak a 2. időszeletben indult, így 1 időszeletet kellett várnia. Ezt az értéket a Vár oszlop megfelelő helyére írom be.

|     | Érkezik | CPU-idő | Indul | Vége | Vár |
| --- | --- | --- | --- | --- | --- |
| P1  | 1   | 3   | 2   | 5   | 1   |
| P2  | 3   | 6   |     |     |     |
| P3  | 0   | 2   | 0   | 2   | 0   |
| P4  | 5   | 5   |     |     |     |

4\. lépés: Megkeresem a következő legkorábban érkező folyamatot (P2), majd az indulási idejének megadom az előző folyamat (P1) végzési idejét. Mivel a P2 folyamat CPU-ideje (6) nagyobb, mint az időszelet hossza (3), így az indulási időhöz (5) hozzáadom az időszelet hosszát (3), majd ezt az értéket (8) írom be a végzési időnek. Ezt követően létrehozok egy új P2 folyamatot, amelynek érkezési ideje, az előző végzési ideje (8), a CPU-ideje pedig az eredeti CPU-idő és az időszelet különbsége (6-3=3). Végül, mivel a P2 folyamat a 3. időszeletben érkezett, de csak az 5. időszeletben indult el, így 2 időszeletet kellett várnia. Ezt az értéket a Vár oszlop megfelelő helyére írom be.

|     | Érkezik | CPU-idő | Indul | Vége | Vár |
| --- | --- | --- | --- | --- | --- |
| P1  | 1   | 3   | 2   | 5   | 1   |
| P2  | 3   | 6   | 5   | 8   | 2   |
| P3  | 0   | 2   | 0   | 2   | 0   |
| P4  | 5   | 5   |     |     |     |
| P2  | 8   | 3   |     |     |     |

5\. lépés: Megkeresem a következő legkorábban érkező folyamatot (P4), majd az indulási idejének megadom az előző folyamat (P2) végzési idejét. Mivel a P4 folyamat CPU-ideje (5) nagyobb, mint az időszelet hossza (3), így az indulási időhöz (8) hozzáadom az időszelet hosszát (3), majd ezt az értéket (11) írom be a végzési időnek. Ezt követően létrehozok egy új P4 folyamatot, amelynek érkezési ideje, az előző végzési ideje (11), a CPU-ideje pedig az eredeti CPU-idő és az időszelet különbsége (5-3=2). Végül, mivel a P4 folyamat az 5. időszeletben érkezett, de csak a 8. időszeletben indult el, így 3 időszeletet kellett várnia. Ezt az értéket a Vár oszlop megfelelő helyére írom be.

|     | Érkezik | CPU-idő | Indul | Vége | Vár |
| --- | --- | --- | --- | --- | --- |
| P1  | 1   | 3   | 2   | 5   | 1   |
| P2  | 3   | 6   | 5   | 8   | 2   |
| P3  | 0   | 2   | 0   | 2   | 0   |
| P4  | 5   | 5   | 8   | 11  | 3   |
| P2  | 8   | 3   |     |     |     |
| P4  | 11  | 2   |     |     |     |

6\. lépés: Megkeresem a következő legkorábban érkező folyamatot (P2), majd az indulási idejének megadom az előző folyamat (P4) végzési idejét. Mivel a P2 folyamat CPU-ideje (3) megegyezik az időszelet hosszával (3), így az indulási időhöz hozzáadom a CPU-időt, majd ezt az értéket (14) a Vége oszlop megfelelő sorába írom be. Végül, mivel a P2 folyamat az 8. időszeletben érkezett, de csak a 11. időszeletben indult, így 3 időszeletet kellett várnia. Ezt az értéket a Vár oszlop megfelelő helyére írom be.

|     | Érkezik | CPU-idő | Indul | Vége | Vár |
| --- | --- | --- | --- | --- | --- |
| P1  | 1   | 3   | 2   | 5   | 1   |
| P2  | 3   | 6   | 5   | 8   | 2   |
| P3  | 0   | 2   | 0   | 2   | 0   |
| P4  | 5   | 5   | 8   | 11  | 3   |
| P2  | 8   | 3   | 11  | 14  | 3   |
| P4  | 11  | 2   |     |     |     |

7\. lépés: Megkeresem a következő legkorábban érkező folyamatot (P4), majd az indulási idejének megadom az előző folyamat (P2) végzési idejét. Mivel a P4 folyamat CPU-ideje (2) kisebb, mint az időszelet hossza (3), így az indulási időhöz hozzáadom a CPU-időt, majd ezt az értéket (16) a Vége oszlop megfelelő sorába írom be. Végül, mivel a P4 folyamat a 11. időszeletben érkezett, de csak a 14. időszeletben indult, így 3 időszeletet kellett várnia. Ezt az értéket a Vár oszlop megfelelő helyére írom be.

|     | Érkezik | CPU-idő | Indul | Vége | Vár |
| --- | --- | --- | --- | --- | --- |
| P1  | 1   | 3   | 2   | 5   | 1   |
| P2  | 3   | 6   | 5   | 8   | 2   |
| P3  | 0   | 2   | 0   | 2   | 0   |
| P4  | 5   | 5   | 8   | 11  | 3   |
| P2  | 8   | 3   | 11  | 14  | 3   |
| P4  | 11  | 2   | 14  | 16  | 3   |

7\. lépés: Indulási idők növekvő sorendje alapján meghatározható a folyamatok ütemezése:

| P3  | 🡪  | P1  | 🡪  | P2  | 🡪  | P4  | 🡪  | P2  | 🡪  | P4  | 🡪  | \-  | 🡪  | \-  |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |

_II/3. Prioritásos_

_Adott öt folyamat P=(1, 2, 3, 4, 5), amelyeknek futásideje C=(3, 6, 2, 1, 3), prioritása pedig Prioritas=(5, 4, 2, 3, 1). A folyamatok T=0 időpontban kerülnek futásra kész állapotba._

1\. lépés: Elkészítem a kiindulási táblázatot a megadott adatok alapján. A folyamatokat az 1. oszlopba, a futási időt (C) a 2. oszlopba, míg a prioritást a 3. oszlopba írom be.

|     | CPU-idő | Prioritás |
| --- | --- | --- |
| P1  | 3   | 5   |
| P2  | 6   | 4   |
| P3  | 2   | 2   |
| P4  | 1   | 3   |
| P5  | 3   | 1   |

2\. lépés: Mivel minden folyamat a 0. időegységben kerül futásra kész állapotba, így az algoritmusnál a prioritás értéke a mérvadó. Minél kisebb a prioritás annál hamarabb kerül beütemezésre a folyamat. Prioritási sorrendben a folyamatok ütemezése a következő:

| P5  | 🡪  | P3  | 🡪  | P4  | 🡪  | P2  | 🡪  | P1  |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |

_II/4. Legrövidebb hátralévő idejű (Shortest Remaining Time First, SRTF)_

_Adott négy folyamat P=(1, 2, 3, 4), amelyeknek futásideje C=(4, 5, 7, 1). A folyamatok T=(5, 2, 4, 0) időpontban kerülnek futásra kész állapotba. A rendszerben a legrövidebb hátralévő idejű (Shortest Remaining Time First - SRTF) CPU ütemezés működik._

Adja meg a folyamatok ütemezését:

|     | 🡪  |     | 🡪  |     | 🡪  |     | 🡪  |     | 🡪  |     | 🡪  |     | 🡪  |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |

(Megjegyzés: ha egy döntés után ugyanaz a folyamat folytatódik, akkor azt újból fel kell venni! Ha valamelyik hely már nincs mit ütemezni, akkor jelölje "-" jellel!)

1\. lépés: Elkészítem a kiindulási táblázatot a megadott adatok alapján. A folyamatokat az 1. oszlopba, a folyamatok futásra állapotainak idejét (T) a 2. oszlopba, még a futási időt (C) a harmadik oszlopba írom be.

|     | Érkezik | CPU-idő | Indul | Vége | Vár |
| --- | --- | --- | --- | --- | --- |
| P1  | 5   | 4   |     |     |     |
| P2  | 2   | 5   |     |     |     |
| P3  | 4   | 7   |     |     |     |
| P4  | 0   | 1   |     |     |     |

2\. lépés: Megkeresem a legkorábban érkező folyamatot (P4), majd az érkezési idejét, beírom az Indul oszlop megfelelő helyére. Mivel futás közben nem érkezik új folyamat, így a végzési idő egyenlő lesz a P4 folyamat CPU-idejével (1).

|     | Érkezik | CPU-idő | Indul | Vége | Vár |
| --- | --- | --- | --- | --- | --- |
| P1  | 5   | 4   |     |     |     |
| P2  | 2   | 5   |     |     |     |
| P3  | 4   | 7   |     |     |     |
| P4  | 0   | 1   | 0   | 1   | 0   |

3\. lépés: Megkeresem a legkorábban érkező folyamatot (P2), majd az érkezési idejét (2), beírom az Indul oszlop megfelelő helyére, mivel a P4 folyamat már hamarabb befejeződött. Mivel a CPU-idő 5, így egészen a 7. időszeletig tartana a folyamat. Azonban a 4. időszeletben futásra kész állapotba került a P3 folyamat is. Ekkor meg kell vizsgálni, hogy melyik folyamatnak kisebb a szükséges CPU-ideje a 4. időszeletben. Mivel a P2 folyamatnak 3, a P3 folyamatnak pedig 7 a CPU-ideje, így a P2 folyamat folytatódhat tovább. (Ezt jelezni kell a megoldásban úgy, hogy újra leírom a P2 folyamatot.) Az 5. időszeletben azonban futásra kész lesz a P1 folyamat is. Ekkor meg kell vizsgálni, hogy melyik folyamatnak kisebb a szükséges CPU-ideje az 5. időszeletben. Mivel a P2 folyamatnak 2, a P1 folyamatnak pedig 4 a CPU-ideje, így a P2 folyamat folytatódhat tovább. (Ezt jelezni kell a megoldásban úgy, hogy újra leírom a P2 folyamatot.) Ezt követően már nem lesz új folyamat, amely futásra kész áll, így a P2 végzési ideje az érkezési és CPU-idő összege lesz (2+5=7). Végül mivel nem kellett várakoznia, így a 0 értéket kell beírni a Vár oszlop megfelelő oszlopába.

|     | Érkezik | CPU-idő | Indul | Vége | Vár |
| --- | --- | --- | --- | --- | --- |
| P1  | 5   | 4   |     |     |     |
| P2  | 2   | 5   | 2   | 7   | 0   |
| P3  | 4   | 7   |     |     |     |
| P4  | 0   | 1   | 0   | 1   | 0   |

3\. lépés: Mivel a 7. időlépésben vagyok, így meg kell néznem, hogy vannak-e olyan folyamatok, amelyek futásra készen állnak. Ilyen a P1 és a P3 is. Mivel a P1-nek a kisebb a CPU ideje, így őt fogom következőnek beütemezni. P1 indulási ideje meg fog egyezni az előző folyamat (P2) végzési idejével (7). P1 végzési ideje pedig az indulási idő és a CPU-idő összege lesz (7+4=11). Várakozás idő szempontjából az 5. időszeletben kellett volna indulnia, azonban csak a 7. időszeletben tudott, így a várakozási idő 2 lesz.

|     | Érkezik | CPU-idő | Indul | Vége | Vár |
| --- | --- | --- | --- | --- | --- |
| P1  | 5   | 4   | 7   | 11  | 2   |
| P2  | 2   | 5   | 2   | 7   | 0   |
| P3  | 4   | 7   |     |     |     |
| P4  | 0   | 1   | 0   | 1   | 0   |

4\. lépés: Végül az utolsó folyamatot (P3) is beütemezem. P3 indulási ideje meg fog egyezni az előző folyamat (P1) végzési idejével (11). P3 végzési ideje pedig az indulási idő és a CPU-idő összege lesz (11+7=18). Várakozás idő szempontjából az 4. időszeletben kellett volna indulnia, azonban csak a 11. időszeletben tudott, így a várakozási idő 7 lesz.

|     | Érkezik | CPU-idő | Indul | Vége | Vár |
| --- | --- | --- | --- | --- | --- |
| P1  | 5   | 4   | 7   | 11  | 2   |
| P2  | 2   | 5   | 2   | 7   | 0   |
| P3  | 4   | 7   | 11  | 18  | 7   |
| P4  | 0   | 1   | 0   | 1   | 0   |

5\. lépés Folyamatok ütemezésének meghatározása az indulási idők és a folyamatok megállásának és újraindulásának jelölésével.

| P4  | 🡪  | P2  | 🡪  | P2  | 🡪  | P2  | 🡪  | P1  | 🡪  | P3  | 🡪  | \-  | 🡪  | \-  |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |

Megjegyzés az algoritmus használatához: Ha egy döntés miatt egy folyamat nem folytatódhat tovább, akkor azt újra fel kell venni a folyamatok közé úgy, hogy a végzési idő lesz az új érkezési idő, a megmaradt CPU-idő pedig az új CPU-idő lesz.

**ZÁRTHELYI 2. ALGORITMUSOK**

**I. Tárkezelés**

_I/1. Legjobban megfelelő (Best Fit, BF)_

Egy rendszerbe korábban már a P1, P2 és P3 folyamatok betöltésre kerültek, amely eredményeként az aktuális memória kiosztása az alábbi:

Cím: 0000 1000 2000 2200 2400 3000 5000 \[Byte\]

|-------|-------|--------|-------|-------|-------|-------|

Proc: P1 - P3 - P2 - OS

Ha egy 900 Byte méretű P4 és egy 200 Byte méretű P5 folyamat érkezik, akkor a rendszer a best fit algoritmus használatával a P4-t a \_**\_** címre, a P5-t pedig a \_**\_** címre tölti be.

Az algoritmus alapja, hogy olyan memóriaterületet válasszunk ki egy folyamat számára, amely a legközelebb áll a folyamat méretéhez, de nem kisebb annál. Az ábrán látható, hogy a P1, P2, P3 folyamatnak korábban már sikerült helyet találnunk, így maradék üres helyekre kell beosztanunk a P4 (900 byte) és P5 (200 byte) folyamatot.

Az üres helyek a következők:

- 1000 és 2000 között
- 2200 és 2400 között
- 3000 és 5000 között

Ezek alapján látható, hogy P4-et az 1000-es címre, míg a P5-öt a 2200-as címre kell elhelyeznünk.

_I/2. Első megfelelő (First Fit, FF)_

Egy rendszerbe korábban már a P1, P2 és P3 folyamatok betöltésre kerültek, amely eredményeként az aktuális memória kiosztása az alábbi:

Cím: 0000 1000 2000 2200 2400 3000 5000 \[Byte\]

|-------|-------|--------|-------|-------|-------|-------|

Proc: P1 - P3 - P2 - OS

Ha egy 900 Byte méretű P4 és egy 400 Byte méretű P5 folyamat érkezik, akkor a rendszer a first fit algoritmus használatával a P4-et a \_**\_** címre, a P5-t pedig a \_**\_** címre tölti be.

Az algoritmus alapja, hogy a memória elejéről kiindulva az első megfelelő méretű memóriaterületet válasszuk ki az adott folyamat számára. Az ábrán látható, hogy a P1, P2, P3 folyamatnak korábban már sikerült helyet találnunk, így maradék üres helyekre kell beosztanunk a P4 (900 byte) és P5 (400 byte) folyamatot.

Az üres helyek a következők:

- 1000 és 2000 között
- 2200 és 2400 között
- 3000 és 5000 között

Ezek alapján látható, hogy P4-et az 1000-es címre, míg a P5-öt a 3000-as címre elhelyeznünk.

_I/3. Következő megfelelő (Next Fit, NF)_

Egy rendszerbe korábban már a P1, P2 és P3 folyamatok betöltésre kerültek, amely eredményeként az aktuális memória kiosztása az alábbi:

Cím: 0000 1000 2000 2200 2400 3000 4000 \[Byte\]

|-------|-------|--------|-------|-------|-------|-------|

Proc: P1 - P3 - P2 - OS

Ha egy 900 Byte méretű P4 és egy 200 Byte méretű P5 folyamat érkezik, akkor a rendszer a next fit algoritmus használatával a P4-et a \_**\_** címre, a P5-öt pedig a \_**\_** címre tölti be.

Az algoritmus alapja, hogy az első olyan memóriaterületet kell kiválasztanunk az adott folyamat számára, amely elegendő méretű, és a legutóbbi folyamat beillesztése után következik az aktuális pozícióban a memóriában. Ez azt jelenti, hogy az NF algoritmus nem a memóriakezdőponttól, hanem az utolsó beillesztett folyamat után folytatja a keresést. Ha nem talál, akkor kezdi előről a keresést.

Első lépésben a 900 byte méretű P4 folyamatnak kell memóriát foglalnunk. Az utolsó folyamat a P3, amely a 2200-ig foglalja a memóriát, ez a kiindulási alap. 2200 és 2400 között nem fér be. 2400 és 3000 között a memóriát a P2 folyamat foglalja. 3000 és 4000 között van szabad hely, így a P4-et a 3000-es címre helyezem. Következik a P5 folyamat 200 byte mérettel. Mivel a P4 folyamat után már nem fér be, valamint ezt követően az OS következik, így előről kell kezdem a keresést. 0000 és 1000 között a P1 folyamat szerepel, azonban 1000 és 2000 közé be tudom illeszteni a P5 folyamatot.

Kitekintés: Mikor növekedhet a tördelődés?

- Nem növekszik a külső tördelődés: Ha az új folyamatot közvetlenül az utolsó folyamat után lehet elhelyezni, és nem marad szabad terület az operációs rendszer és az utolsó folyamat között.
- Növekszik a külső tördelődés: Ha az új folyamatot nem lehet közvetlenül az utolsó folyamat után elhelyezni, és az új folyamat beillesztése új szabad területet eredményez az operációs rendszer és az utolsó folyamat között.
- Növekedhet a külső tördelődés: Ha az új folyamat beillesztésekor nem növekszik a külső tördelődés, de az új folyamat beillesztése után más folyamatok elmozdulhatnak a memóriában, ami újabb szabad területeket eredményez az operációs rendszer és az utolsó folyamat között, ezzel növelve a külső tördelődést.

_I/4. Legrosszabban illeszkedő (Worst Fit, WF)_

Egy rendszerbe korábban már a P1, P2 és P3 folyamatok betöltésre kerültek, amely eredményeként az aktuális memória kiosztása az alábbi:

Cím: 0000 1000 2000 2200 2400 3000 4500 \[Byte\]

|-------|-------|--------|-------|-------|-------|-------|

Proc: P1 - P3 - P2 - OS

Ha egy 900 Byte méretű P4 és egy 200 Byte méretű P5 folyamat érkezik, akkor a rendszer a worst fit algoritmus használatával a P4-et a \_**\_** címre, a P5-öt pedig a \_**\_** címre tölti be.

Az algoritmus alapja, hogy a legnagyobb elegendő méretű memóriaterületet válasszuk ki a folyamat számára. Az ábrán látható, hogy a P1, P2, P3 folyamatnak korábban már sikerült helyet találnunk, így maradék üres helyekre kell beosztanunk a P4 (900 byte) és P5 (200 byte) folyamatot.

Az üres helyek a következők:

- 1000 és 2000 között
- 2200 és 2400 között
- 3000 és 4500 között

Ezek alapján látható, hogy P4-et a 3000-es címre, míg a P5-öt az 1000-es címre kell elhelyeznünk.

**II. Virtuális tárkezelés**

_II/1. Legrégebben használt lap (Least Recently Used, LRU)_

A memóriában 1 folyamat fut, amelynek a virtuális memóriája 5 lapból áll. A végrehajtás során a lapokra az alábbi sorrendben hivatkozik: 1, 2, 3, 4, 1, 2, 5, 1, 2, 3, 4, 5. A folyamatok lapkerete 4.

Ha a rendszerben a LRU (legrégebben használt lap) lapcsere stratégiát alkalmazzuk, akkor a folyamat \_**\_** db laphibával fog lefutni.

Az algoritmus alapja, hogy lapcserekor azt a lapot vesszük ki a memóriából, amelyre a folyamatok leghosszabb ideje nem hivatkoztak.

1\. lépés: Kezdeti táblázat felírása a meglévő adatok alapján.

| Laphivatkozások | 1   | 2   | 3   | 4   | 1   | 2   | 5   | 1   | 2   | 3   | 4   | 5   |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Lapok a tárban | 1   | 1   | 1   | 1   | 1   | 1   | 1   | 1   | 1   | 1   | 1   | 5   |
|     | 2   | 2   | 2   | 2   | 2   | 2   | 2   | 2   | 2   | 2   | 2   |
|     |     | 3   | 3   | 3   | 3   | 5   | 5   | 5   | 5   | 4   | 4   |
|     |     |     | 4   | 4   | 4   | 4   | 4   | 4   | 3   | 3   | 3   |
| Laphibák | x   | x   | x   | x   |     |     | x   |     |     | x   | x   | x   |

2\. lépés: Táblázat kitöltése. Lapcsere az LRU algoritmus alapján:

- Az 1-es bent van a tárban? Nincs. Beírom, és jelzem a laphibát.
- A 2-es bent van a tárban? Nincs. Beírom, és jelzem a laphibát.
- A 3-as bent van a tárban? Nincs. Beírom, és jelzem a laphibát.
- A 4-es bent van a tárban? Nincs. Beírom, és jelzem a laphibát.
- Az 1-es bent van a tárban? Igen. Nincs laphiba.
- A 2-es bent van a tárban? Igen. Nincs laphiba.
- Az 5-ös bent van a tárban? Nincs. Cserélem a legrégebb óta hivatkozott lapra (3), majd jelzem a laphibát.
- Az 1-es bent van a tárban? Igen. Nincs laphiba.
- A 2-es bent van a tárban? Igen. Nincs laphiba.
- A 3-as bent van a tárban? Nincs. Cserélem a legrégebb óta hivatkozott lapra (4), majd jelzem a laphibát.
- A 4-es bent van a tárban? Nincs. Cserélem a legrégebb óta hivatkozott lapra (5), majd jelzem a laphibát.
- Az 5-ös bent van a tárban? Nincs. Cserélem a legrégebb óta hivatkozott lapra (1), majd jelzem a laphibát.

3\. lépés: Összeszámolom a laphibák számát, amely összesen 8 db.

_II/2. Második esély (Secound Chance, SC)_

A memóriában 1 folyamat fut, amelynek a virtuális memóriája 5 lapból áll. A végrehajtás során a lapokra az alábbi sorrendben hivatkozik: 1, 2, 3, 4, 3, 1, 5, 1, 2, 3, 1, 5. A folyamatok lapkerete 3. Ha a rendszerben a Second Chance (második esély) lapcsere stratégiát alkalmazzuk, akkor a folyamat...

1. 5 db laphibával fog lefutni.
2. 6 db laphibával fog lefutni.
3. 7 db laphibával fog lefutni.
4. 8 db laphibával fog lefutni.
5. 9 db laphibával fog lefutni.
6. 10 db laphibával fog lefutni.

Az algoritmus alapja, hogy lapcserekor az a lap kerül ki a memóriából, amelyik a legrégebb óta vár a sorára a FIFO sorrend szerint, és amelyiknek a jelölőbitje 0. A hivatkozásokat jelölő bittel jelöljük: ha egy lapra hivatkozás történt, annak a bitje 1-re áll. Ha a soron következő, legrégebben várakozó lap jelölőbitje 1, akkor második esélyt adunk neki: a bitjét 0-ra állítjuk, és tovább lépünk a következő lapra a FIFO sorrendben. A folyamat addig ismétlődik, amíg olyan lapot nem találunk, amelyiknek a jelölőbitje 0, ekkor ezt a lapot cseréljük ki.

1\. lépés: Kezdeti táblázat felírása a meglévő adatok alapján.

| Laphivatkozások | 1   | 2   | 3   | 4   | 3   | 1   | 5   | 1   | 2   | 3   | 1   | 5   |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Lapok a tárban | 1<sub>1</sub> | 1<sub>1</sub> | 1<sub>1</sub> | 4<sub>1</sub> | 4<sub>1</sub> | 4<sub>1</sub> | 4<sub>0</sub> | 4<sub>0</sub> | 2<sub>1</sub> | 2<sub>0</sub> | 2<sub>0</sub> | 5<sub>1</sub> |
|     | 2<sub>1</sub> | 2<sub>1</sub> | 2<sub>0</sub> | 2<sub>0</sub> | 1<sub>1</sub> | 1<sub>0</sub> | 1<sub>1</sub> | 1<sub>1</sub> | 3<sub>1</sub> | 3<sub>1</sub> | 3<sub>1</sub> |
|     |     | 3<sub>1</sub> | 3<sub>0</sub> | 3<sub>1</sub> | 3<sub>1</sub> | 5<sub>1</sub> | 5<sub>1</sub> | 5<sub>1</sub> | 5<sub>0</sub> | 1<sub>1</sub> | 1<sub>1</sub> |
| Laphibák | x   | x   | x   | x   |     | x   | x   |     | x   | x   | x   | x   |

2\. lépés: Táblázat kitöltése. Lapcsere az SC algoritmus alapján:

- A memória üres berakjuk az 1-est és beállítom neki az 1-es jelölőbitet. Végül jelzem a laphibát. FIFO sorrend: 1
- A memória üres berakjuk az 2-est és beállítom neki az 1-es jelölőbitet. Végül jelzem a laphibát. FIFO sorrend: 1->2
- A memória üres berakjuk az 3-ast és beállítom neki az 1-es jelölőbitet. Végül jelzem a laphibát. FIFO sorrend: 1->2->3
- A 4-es bent van a tárban? Nincs. Mivel nincs több lapkeret cserélnem kell. Először megnézem FIFO sorrend szerint, hogy melyik lap van legrégebb óta a tárban. Az 1-es. Mivel 1-es jelölőbitje van azt átállítom 0-ra. Megnézem, hogy mi a következő legrégebbi. A 2-es. Mivel 1-es jelölőbitje van azt átállítom 0-ra. Végül, megnézem, hogy mi a következő legrégebbi. A 3-as. Mivel 1-es jelölőbitje van azt átállítom 0-ra. Ezt követően visszatérek az elejére, és megnézem újra az 1-es lapot. Mivel a jelölőbitje már 0-a, így kidobjuk, és helyére a 4-es lapot tesszük, 1-es jelölőbittel. FIFO sorrend: 2->3->4
- A 3-es bent van a tárban? Igen. Mivel még nem hivatkoztunk rá, de most igen, így a jelölőbitet 1-esre állítom. Nincs laphiba. FIFO sorrend: 2->3->4
- Az 1-es bent van a tárban? Nincs, ezért cserélnem kell. Először a FIFO sorrend szerinti soron következő lapot vizsgálom, amely a 2-es. A 2-es lap jelölőbitje 0, így kicserélem rá az 1-es lapot. FIFO sorrend: 3->4->1
- Az 5-ös bent van a tárban? Nincs, ezért cserélnem kell. Először a FIFO sorrend szerinti soron következő lapot vizsgálom, amely a 3-as. Mivel a 3-as lap jelölőbitje 1, második esélyt adok neki: a bitjét 0-ra állítom, és tovább lépek a következő lapra, a 4-esre. A 4-es lap jelölőbitje 1, ezért második esélyt adok neki: a bitjét 0-ra állítom. A következő lap az 1-es, amelynek jelölőbitje szintén 1, így neki is adok egy második esély, és átállítom 0-ra a jelölőbitet. Ezt követően újra visszatérek a 3-ashoz, mivel a hivatkozásbitje 0-a, így kidobom és betöltöm a helyére a 5-öst. FIFO sorrend: 4->1->5
- Az 1-es bent van a tárban? Igen. A jelölőbitet átállítom 1-re. Nincs laphiba. FIFO sorrend: 4->1->5
- A 2-es bent van a tárban? Nincs, ezért cserélnem kell. Először a FIFO sorrend szerinti soron következő lapot vizsgálom, amely a 4-es. Mivel a 4-es jelölőbitje 0, így azt lecserélem. Helyére a 2-est teszem 1-es jelölőbittel. FIFO sorrend: 1->5->2
- A 3-as bent van a tárban? Nincs, ezért cserélnem kell. Először a FIFO sorrend szerinti soron következő lapot vizsgálom, amely a 1-es. Mivel a 1-es jelölőbitje 1, így azt lenullázom. Következő az 5-ös, amelyet szintén lenullázok. Következő a 2-es, amelyet újfent lenullázok. Visszatérek az 1-eshez, amelynek jelölőbitje 0-a, így kidobom és betöltöm a helyére a 3-ast. FIFO sorrend: 5->2->3
- Az 1-es bent van a tárban? Nincs, ezért cserélnem kell. Először a FIFO sorrend szerinti soron következő lapot vizsgálom, amely a 5-ös. Mivel az 5-ös lap jelölőbitje 0, ezért kidobom és betöltöm a helyére az 1-est. FIFO sorrend: 2-> 3-> 1
- Az 5-ös bent van a tárban? Nincs, ezért cserélnem kell. Először a FIFO sorrend szerinti soron következő lapot vizsgálom, amely a 2-es. Mivel az 2-es lap jelölőbitje 0, ezért kidobom és betöltöm a helyére az 5-öst. FIFO sorrend: 3-> 1-> 5

3\. lépés: Összeszámolom a laphibák számát, amely összesen 10 db.

**III. Háttértár**

_III/1. N-lépéses pásztázó (N-Step-SCAN, N-SCAN)_

Egy merevlemezen a cilinderek száma 0-99, a rendszerbe 8 kérés érkezik R= (1, 2, 3, 4, 5, 6, 7, 8), melyek beérkezési időpontja T= (0, 0, 0, 0, 0, 0, 0, 0), és az adatokat tartalmazó cilinderek száma:

C= (33, 27, 8, 47, 82,11, 91, 68). Adja meg a kiszolgálás sorrendjét, ha a háttértár a N-lépéses pásztázó (N-SCAN) algoritmust használja, a fej az egyik cilinderről a másikra 1 ms alatt mozog, és a 0. időpillanatban a 28. cilinder fölött növekvő irányba mozog és N = 3.

A kiszolgálás sorrendje:

|     | 🡪  |     | 🡪  |     | 🡪  |     | 🡪  |     | 🡪  |     | 🡪  |     | 🡪  |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |

Az algoritmus alapja, hogy az aktuális cilinderből kiindulva a megadott irányban N számú kérést teljesítünk majd irányt váltunk, ahol újabb N számú kérést teljesítünk. Ha az egyik irányban elfogyott az összes teljesíthető kérés, akkor a másik irány összes kérését teljesítjük.

Az útvonal következő:

- 28 -> 33 (R1)
- 33 -> 47 (R4)
- 47 -> 68 (R8)
- 68 -> 27 (R2)
- 27 -> 11 (R6)
- 11 -> 8 (R3)
- 8 -> 82 (R5)
- 82 -> 91 (R7)

A kiszolgálás sorrendje:

| R1  | 🡪  | R4  | 🡪  | R8  | 🡪  | R2  | 🡪  | R6  | 🡪  | R3  | 🡪  | R5  | 🡪  | R7  |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |

_III/2. Legrövidebb fejmozgási idő (Shortest seek time first, SSTF)_

Egy merevlemezen a cilinderek száma 0-99, a rendszerbe 8 kérés érkezik R= (1, 2, 3, 4, 5, 6, 7, 8), melyek beérkezési időpontja T= (0, 0, 0, 0, 0, 0, 0, 0), és az adatokat tartalmazó cilinderek száma: C= (33, 27, 8, 47, 82,11, 91, 68). Adja meg a kiszolgálás sorrendjét, ha a háttértár a legrövidebb fejmozgási idő (SSTF) algoritmus használja, a fej az egyik cilinderről a másikra 1 ms alatt mozog, és a 0. időpillanatban a 48. cilinder fölött csökkenő irányba mozog.

A kiszolgálás sorrendje:

|     | 🡪  |     | 🡪  |     | 🡪  |     | 🡪  |     | 🡪  |     | 🡪  |     | 🡪  |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |

Az algoritmus alapja, hogy a fej aktuális cilinderből kiindulva arra a cilinderre kell ugranunk, amelyet a legkisebb fejmozgással érhetünk el a mozgási iránynak megfelelően. Ha a fej mozgási irányában már nincsen közelebb cilinder, akkor a fejet irányt vált.

Az útvonal következő:

- 48 -> 47 (R4)
- 47 -> 33 (R1)
- 33 -> 27 (R2)
- 27 -> 11 (R6)
- 11 -> 8 (R3)
- 8 -> 68 (R8)
- 68 -> 82 (R5)
- 82 -> 91 (R7)

A kiszolgálás sorrendje:

| R4  | 🡪  | R1  | 🡪  | R2  | 🡪  | R6  | 🡪  | R3  | 🡪  | R8  | 🡪  | R5  | 🡪  | R7  |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
