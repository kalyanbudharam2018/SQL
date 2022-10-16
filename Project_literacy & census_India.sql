select * from project1.dbo.Literacy_india
select * from project1.dbo.India_Census

-- number of rows into our dataset
select count(*) from project1..literacy_india
select count(*) from project1..India_Census

-- dataset for jarkhand and bihar
select * from project1..Literacy_india where State in ('Maharashtra', 'Andhra Pradesh');

select sum(Population) Population from project1..India_Census

-- average growth of India
select avg(growth)*100 Avg_growth from project1..Literacy_india

-- average growth of all states
select State, avg(growth)*100 Avg_growth from project1..Literacy_india group by State;

-- average sex ratio
select State, round(avg(Sex_Ratio),0) Avg_sex_ratio from project1..Literacy_india group by State;

-- average sex ratio by desc order
select State, round(avg(Sex_Ratio),0) Avg_sex_ratio from project1..Literacy_india group by State order by Avg_sex_ratio desc;

-- avg literacy rate
select State, round(avg(Literacy),0) Avg_literacy from project1..Literacy_india group by State order by Avg_literacy desc;

select State, round(avg(Literacy),0) Avg_literacy from project1..Literacy_india 
group by State having round(avg(Literacy),0)>90 order by Avg_literacy desc;


-- top 3 states of high growth 
select top 3 State, round(avg(Growth),4)*100 Avg_growth from project1..Literacy_india group by State order by Avg_growth desc;

-- bottom 3 states of sex ratio
select top 3 State, round(avg(Sex_Ratio),6) Avg_sexratio from project1..Literacy_india group by State order by Avg_sexratio asc;



-- top & bottom 3 staes in literacy with temporary table
drop table #topstates;
create table #topstates
( state varchar(255),
topstates float
)

insert into #topstates
select state, ROUND(avg	(literacy),0) avg_literacy_ratio from project1..Literacy_india
group by state order by avg_literacy_ratio desc;

select * from #topstates order by #topstates.topstates desc;
select top 3 * from #topstates order by #topstates.topstates desc;
select top 3 * from #topstates order by #topstates.topstates asc;

-- union operator
select * from (
select top 3 * from #topstates order by #topstates.topstates desc) a
union
select * from (
select top 3 * from #topstates order by #topstates.topstates asc) b


-- states starting with letter a
select distinct state from project1..Literacy_india where lower(state) like 'a%';
-- or 
select distinct state from project1..Literacy_india where state like 'a%';

select distinct state from project1..Literacy_india where state like 'a%' or state like 'm%';

-- states starting with letter a or/and end with letter d type
select distinct state from project1..Literacy_india where lower(state) like 'a%' or lower(state) like '%d';
select distinct state from project1..Literacy_india where lower(state) like 'a%' and lower(state) like '%h';



select * from project1.dbo.Literacy_india
select * from project1.dbo.India_Census
--joining both data tables

select a.district, a.state, a.sex_ratio, b.population from project1..Literacy_india a
inner join
project1..India_Census b on a.district=b.district


-- cal males and females from sex ratio and population
select d.state, sum(d.males) Males, sum(d.females) Females from
(select c.district, c.state, ROUND(c.population/(c.sex_ratio+1),0) Males, ROUND((c.population*sex_ratio)/(c.sex_ratio+1),0) Females from
(select a.district, a.state, a.sex_ratio/1000 sex_ratio, b.population from project1..Literacy_india a 
inner join 
project1..India_Census b on a.District=b.District) c) d
group by d.state;


-- total literacy rate
select a.district, a.state, a.Literacy, sex_ratio, b.population from project1..Literacy_india a 
inner join 
project1..India_Census b on a.District=b.District




