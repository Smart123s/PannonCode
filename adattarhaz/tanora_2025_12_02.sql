use test;

--feladat 1
select * into FactSurveyResponse from AdventureWorksDW2019..FactSurveyResponse;
select * into DimCustomer from AdventureWorksDW2019..DimCustomer;
select * into DimDate from AdventureWorksDW2019..DimDate;
go

-- primary kulcsok
alter table FactSurveyResponse add constraint pk1 primary key (surveyresponsekey)
alter table DimDate add constraint pk2 primary key (datekey)
alter table DimCustomer add constraint pk3 primary key (customerkey)
go

-- kulso kulcsok
alter table FactSurveyResponse add constraint fk1 foreign key (datekey)
	references DimDate (datekey);
alter table FactSurveyResponse add constraint fk2 foreign key (customerkey)
	references DimCustomer (customerkey);

-- uj szamitott mezo hozzaadasa
alter table DimCustomer add gyerek_szam as case when totalchildren >1 then 'yes' else 'no' end;

-- 2. feladat
-- bongeszes eredmenyek
-- legnagyobb forgalmú hónapban
-- 2012 Március

-- ekkor melyik termék alcsoport volt a legnépszerűbb?
-- Clothing->Shorts

-- Ezt szűrőnek beállítva derítsük ki, hogy milyen nemű és foglalkozású
-- kedves vásárlóink érdeklődtek iránta a legjobban!
-- Female - professional

