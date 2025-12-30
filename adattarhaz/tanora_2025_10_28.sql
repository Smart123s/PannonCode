/*
PIVOT ÉS UNPIVOT (ismétlés)
================
*/
--PIVOT
go
drop table csapat
CREATE TABLE [dbo].[csapat] (
    [csapat_id] [int] NOT NULL primary key,
    [csapat_nev] [nvarchar] (50) NOT NULL
)
go
drop table gyumolcs
CREATE TABLE [dbo].[gyumolcs] (
    [gyumolcs_id] [int] NOT NULL primary key,
    [gyumolcs_nev] [nvarchar] (50) NOT NULL
)
go
drop table nap
CREATE TABLE [dbo].[nap] (
    [nap_id] [int] NOT NULL primary key,
    [nap_nev] [nvarchar] (50) NOT NULL
)
go
drop table eredm
CREATE TABLE [dbo].[eredm] (
	eredm_id int identity (1,1) primary key,
    [csapat_id] [int] NOT NULL references csapat (csapat_id),
    [nap_id] [int] NOT NULL  references nap (nap_id),
	gyumolcs_id int not null  references gyumolcs (gyumolcs_id),
    [leadott_lada] [int] NOT NULL
)
go
insert csapat (csapat_id, csapat_nev) values (1, 'Szorgos'),(2, 'Lusta')
insert gyumolcs (gyumolcs_id, gyumolcs_nev) values (1, 'alma'),(2, 'szilva')
insert nap (nap_id, nap_nev) values (1, 'hétfő'),(2, 'kedd'),(3, 'szerda')
insert eredm (csapat_id, nap_id, gyumolcs_id, leadott_lada) values
	(1,1,1,50), (1,2,1,60), (1,3,1,70), (1,1,2,100), (1,2,2,120), (1,3,2,140),
	(2,1,1,5), (2,2,1,6), (2,3,1,7), (2,1,2,10), (2,2,2,12), (2,3,2,14)
select * from eredm
--kérdés pl. a csapatok teljesítménye naponta
select cs.csapat_nev, n.nap_nev, sum(leadott_lada) as teljesítmény
from eredm e inner join csapat cs on cs.csapat_id=e.csapat_id
inner join nap n on n.nap_id=e.nap_id
inner join gyumolcs gy on gy.gyumolcs_id=e.gyumolcs_id --elhagyható
group by cs.csapat_id, cs.csapat_nev, n.nap_id, n.nap_nev
order by cs.csapat_nev, n.nap_nev

--csapatok teljesítménye gyümölcsönként
select cs.csapat_nev, gy.gyumolcs_nev, sum(leadott_lada) as teljesítmény
from eredm e inner join csapat cs on cs.csapat_id=e.csapat_id
inner join nap n on n.nap_id=e.nap_id --elhagyható
inner join gyumolcs gy on gy.gyumolcs_id=e.gyumolcs_id 
group by cs.csapat_id, cs.csapat_nev, gy.gyumolcs_id, gy.gyumolcs_nev
order by cs.csapat_nev, gy.gyumolcs_nev

--ládaszám gyümölcsönként
select gy.gyumolcs_nev, sum(leadott_lada) as teljesítmény
from eredm e 
inner join csapat cs on cs.csapat_id=e.csapat_id --elhagyható
inner join nap n on n.nap_id=e.nap_id --elhagyható
inner join gyumolcs gy on gy.gyumolcs_id=e.gyumolcs_id
group by gy.gyumolcs_id, gy.gyumolcs_nev
order by gy.gyumolcs_nev

--Tf. a nevek egyediek (unique) vagy azzá tehetők
--ekkor a PIVOT denormalizált kiinduló táblája:
select e.eredm_id, cs.csapat_nev, n.nap_nev, gy.gyumolcs_nev, leadott_lada
into eredm_pivot
from eredm e 
inner join csapat cs on cs.csapat_id=e.csapat_id 
inner join nap n on n.nap_id=e.nap_id
inner join gyumolcs gy on gy.gyumolcs_id=e.gyumolcs_id
go
select * from eredm_pivot where csapat_nev='lusta'
--csapatok teljesítménye gyümölcsönként: sorokban a csapatok, oszlopokban a gyümölcsök
select csapat_nev, pt.alma, pt.szilva
from (select csapat_nev, gyumolcs_nev, sum(leadott_lada) as leadott_lada 
		from eredm_pivot group by csapat_nev, gyumolcs_nev) as forras 
	pivot (sum(leadott_lada) for gyumolcs_nev in ([alma], [szilva])) as pt

--sorokban a gyümölcsök, oszlopokban a csapatok
select gyumolcs_nev, pt.Lusta, pt.Szorgos
from (select csapat_nev, gyumolcs_nev, sum(leadott_lada) as leadott_lada 
		from eredm_pivot group by csapat_nev, gyumolcs_nev) as forras 
	pivot (sum(leadott_lada) for csapat_nev in ([Lusta], [Szorgos])) as pt
