select * from project..data

-- total episodes

select max([Ep# No#]) from project..data
select count(distinct [Ep# No#]) from project..data

-- pitches 

select count(distinct brand) from project..data

--pitches converted

select cast(sum(a.converted_not_converted) as float) /cast(count(*) as float) from (
select ([Amount Invested lakhs]) , case when ([Amount Invested lakhs]>0) then 1 else 0 end as converted_not_converted from project..data) a

-- total male[shark tank project]
select sum(male) from project..data

-- total female

select sum(female) from project..data

--gender ratio

select sum(female)/sum(male) from project..data

-- total invested amount

select sum([Amount Invested lakhs]) from project..data

-- avg equity taken

select avg(a.[Equity Taken %]) from
(select * from project..data where [Equity Taken %]>0) a

--highest deal taken

select max([Amount Invested lakhs]) from project..data 

--higheest equity taken

select max([Equity Taken %]) from project..data

-- startups having at least women

select sum(a.female_count) startups having at least women from (
select female,case when female>0 then 1 else 0 end as female_count from project..data) a

-- pitches converted having atleast a women

select * from project..data


select sum(b.female_count) from(

select case when a.female>0 then 1 else 0 end as female_count ,a.*from (
(select * from project..data where deal!='No Deal')) a)b

-- avg team members

select avg([Team members]) from project..data

-- amount invested per deal

select avg(a.[Amount Invested lakhs]) amount_invested_per_deal from
(select * from project..data where deal!='No Deal') a

-- avg age group of contestants

select [Avg age],count([Avg age]) cnt from project..data group by [Avg age] order by cnt desc

-- location group of contestants

select location,count(location) cnt from project..data group by location order by cnt desc

-- sector group of contestants

select sector,count(sector) cnt from project..data group by sector order by cnt desc


--partner deals

select partners,count(partners) cnt from project..data  where partners!='-' group by partners order by cnt desc

-- making the matrix


select * from project..data

select 'Ashnner' as keyy,count([Ashneer Amount Invested]) from project..data where [Ashneer Amount Invested] is not null


select 'Ashnner' as keyy,count([Ashneer Amount Invested]) from project..data where [Ashneer Amount Invested] is not null AND [Ashneer Amount Invested]!=0

SELECT 'Ashneer' as keyy,SUM(C.[Ashneer Amount Invested]) Sum,AVG(C.[Ashneer Amount Invested]) Avg 
FROM (SELECT * FROM PROJECT..DATA  WHERE [Ashneer Amount Invested]!=0 AND [Ashneer Amount Invested] IS NOT NULL) C


select m.keyy,m.total_deals_present,m.total_deals,n.total_amount_invested,n.avg_equity_taken from
(select a.keyy,a.total_deals_present,b.total_deals from(
select 'Ashneer' as keyy,count([Ashneer Amount Invested]) total_deals_present from project..data where [Ashneer Amount Invested] is not null) a
inner join (
select 'Ashneer' as keyy,count([Ashneer Amount Invested]) total_deals from project..data 
where [Ashneer Amount Invested] is not null AND [Ashneer Amount Invested]!=0) b 
on a.keyy=b.keyy) m
inner join 
(SELECT 'Ashneer' as keyy,SUM(C.[Ashneer Amount Invested]) total_amount_invested,
AVG(C.]ASHNEE REQUITY TAKENP]) avg_equity_taken
FROM (SELECT * FROM PROJECT..DATA  WHERE ASHNEEREQUITYTAKENP!=0 AND ASHNEEREQUITYTAKENP IS NOT NULL) C) n
on m.keyy=n.keyy



-- which is the startup in which the highest amount has been invested in each domain/sector

select c.* from 
(select Brand,Sector,[Amount Invested lakhs],rank() over(partition by sector order by [Amount Invested lakhs] desc) Rank 

from project..data) c

where c.Rank=1 and sector is not null