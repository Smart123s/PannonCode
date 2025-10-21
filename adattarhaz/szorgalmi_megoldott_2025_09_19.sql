/*nem sikerült normalisan kimasolni a  kiindulo allpotot a pdf-bol, szoval futattam rajta egy auto formattert */
--kiinduló állapot:
use test -- minden tala torlese a script futtatasa elott
DROP TABLE IF EXISTS teny_kurzus_eredmeny;
DROP TABLE IF EXISTS dim_hallgato;
DROP TABLE IF EXISTS dim_kurzus;
DROP TABLE IF EXISTS dim_szemeszter;
go --csillag-szerkezet
    /* nem fut le, ha a kiindulasi tablakat, es a hozzajuk tartozo inserteket nem kommentelem ki */
    /*
     create table dim_hallgato (
     hallgato_id int primary key,
     neptun_kod char(6),
     hallgato_nev nvarchar(200),
     szak_nev varchar(100)
     )
     */
    create table dim_kurzus (
        kurzus_id int primary key,
        kurzus_nev nvarchar(200)
    ) create table dim_szemeszter (
        szemeszter_id int primary key,
        szemeszter_kod varchar(200)
    )
    /*
     create table teny_kurzus_eredmeny (
     hallgato_id int not null references dim_hallgato(hallgato_id),
     kurzus_id int not null references dim_kurzus(kurzus_id),
     szemeszter_id int not null references dim_szemeszter(szemeszter_id),
     eredmeny smallint,
     felvetelek_szama smallint,
     constraint p1 primary key (hallgato_id, kurzus_id, szemeszter_id)
     )
     */
go --néhány demo rekord
    --delete dim_szemeszter
insert dim_szemeszter (szemeszter_id, szemeszter_kod)
values (1, '2018_1'),
    (2, '2018_2'),
    (3, '2019_1') --a kód alapján időben sorba rendezhető
insert dim_kurzus (kurzus_id, kurzus_nev)
values (100, 'Adattárházak'),
    (101, 'Zongora'),
    (103, 'Filozófia')

    /*
     insert dim_hallgato (hallgato_id, neptun_kod, hallgato_nev, szak_nev)
     values (10, 'djkre4', 'Magas Dávid', 'mérnök info.'),
     (11, 'ds41e4', 'Szép Nóra', 'gazd.
     info.')
     
     insert teny_kurzus_eredmeny (
     hallgato_id,
     kurzus_id,
     szemeszter_id,
     eredmeny,
     felvetelek_szama
     )
     values (10, 100, 1, 50, 1),
     (10, 101, 2, 70, 1),
     (10, 100, 3, 50, 2),
     (11, 100, 1, 70, 1),
     (11, 101, 2, 80, 1)
     select h.szak_nev,
     avg(t.eredmeny) eredm_avg
     from teny_kurzus_eredmeny t
     inner join dim_hallgato h on t.hallgato_id = h.hallgato_id
     group by h.szak_nev
     */
    /*
     Az SCD2 megoldásban a dim_hallgato tábla külön mezőkben tárolja, hogy a szak melyik
     szemesztertől melyik szemeszterig érvényes. Ehhez hivatkozzon a dim_szemeszter táblára.
     */




/* A MEGOLDAS INNENTOL KEZDODIK */
/* a jegyzetben kisbetukkel voltak az sql utasiatasok, azokat nem irtam at, de az ujakat en nagybetuvel irtam */

/*1. jelenlegi teny_kurzus_eredmeny, dim_hallgato táblák megszüntetése (DROP)*/
DROP TABLE IF EXISTS teny_kurzus_eredmeny;
DROP TABLE IF EXISTS dim_hallgato;

/*2. az új dim_hallgató tábla létrehozása a kiegészítő kulccsal és az új SCD2 mezőkkel*/
create table dim_hallgato (
    hallgato_dw_id INT PRIMARY KEY IDENTITY(1, 1),
    hallgato_id INT NOT NULL,
    neptun_kod char(6),
    hallgato_nev nvarchar(200),
    szak_nev varchar(100),
    szemeszter_valid_from INT NOT NULL REFERENCES dim_szemeszter(szemeszter_id),
    szemeszter_valid_to INT REFERENCES dim_szemeszter(szemeszter_id),
);

/*3. hallgató adatok feltöltése (INSERT)--ehhez tegyük fel, hogy Magas Dávid 2018 ősze után jött át a 'mérnök info.' szakra a 'prog. info.' szakról.*/
insert dim_hallgato (hallgato_id, neptun_kod, hallgato_nev, szak_nev, szemeszter_valid_from, szemeszter_valid_to)
values 
    (10, 'djkre4', 'Magas Dávid', 'prog. info.', 1, 2),
    (10, 'djkre4', 'Magas Dávid', 'mérnök info.', 3, NULL),
    (11, 'ds41e4', 'Szép Nóra',   'gazd. info.',  1, NULL);

/*4. új ténytábla létrehozása, mely már a kiegészítő kulcsra hivatkozik*/
create table teny_kurzus_eredmeny (
    hallgato_dw_id int not null references dim_hallgato(hallgato_dw_id),
	hallgato_id int not null,
    kurzus_id int not null references dim_kurzus(kurzus_id),
    szemeszter_id int not null references dim_szemeszter(szemeszter_id),
    eredmeny smallint,
    felvetelek_szama smallint,
    constraint p1 primary key (hallgato_dw_id, kurzus_id, szemeszter_id)
);

/*5. tény-adatok beírása (INSERT). Ezek nem változtak!*/
INSERT INTO teny_kurzus_eredmeny (
        hallgato_dw_id,
		hallgato_id,
        kurzus_id,
        szemeszter_id,
        eredmeny,
        felvetelek_szama
    )
SELECT h.hallgato_dw_id,
	t.hallgato_id,
    t.kurzus_id,
    t.szemeszter_id,
    t.eredmeny,
    t.felvetelek_szama
FROM (
        VALUES (10, 100, 1, 50, 1),
            (10, 101, 2, 70, 1),
            (10, 100, 3, 50, 2),
            (11, 100, 1, 70, 1),
            (11, 101, 2, 80, 1)
    ) AS t(
        hallgato_id,
        kurzus_id,
        szemeszter_id,
        eredmeny,
        felvetelek_szama
    )
    JOIN dim_hallgato h ON t.hallgato_id = h.hallgato_id
    AND t.szemeszter_id >= h.szemeszter_valid_from
    AND (
        t.szemeszter_id <= h.szemeszter_valid_to
        OR h.szemeszter_valid_to IS NULL
    );

/*6. a szakonkénti eredményt helyesen visszaadó SELECT megírása*/
SELECT h.szak_nev,
    AVG(t.eredmeny) AS eredm_avg
FROM teny_kurzus_eredmeny t
    INNER JOIN dim_hallgato h ON t.hallgato_dw_id = h.hallgato_dw_id
GROUP BY h.szak_nev;
