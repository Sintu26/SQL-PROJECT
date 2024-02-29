use [project celcius]

select * from dbo.Data1$
select * from dbo.Sheet1$

-- no of rowas in datasets
select count (*) from [project celcius]..Data1$
select count (*) from [project celcius]..Sheet1$
--or
select count (*) from dbo.Data1$
select count (*) from dbo.Sheet1$

-- dataset for bihar & jharkhand
select * from dbo.Data1$ where state in ('bihar' , 'jharkhand') order by State

--population of india
select sum(Population) as Population from dbo.Sheet1$

-- Avg growth
select avg(growth)*100 as avg_growth from dbo.Data1$

-- Avg Growth of state
select state,avg(growth)*100 as avg_growth from dbo.Data1$ group by State

-- Avg Sex ratio
select state,round(avg(Sex_Ratio),0) as avg_sexratio from dbo.Data1$ group by State 
order by avg_sexratio desc

--Avg litrecy rate 
select state,round(avg(Literacy),0) as avg_literacy from dbo.Data1$  
group by State having round(avg(Literacy),0)>90;

--- top 3 sate showing highest growth ratio
select top 3
state,avg(growth)*100 as avg_growth from dbo.Data1$ group by State order by avg_growth desc

-- bottom 3 state showing low sex ratio
select top 3
state,round(avg(Sex_Ratio),0) as avg_sexratio from dbo.Data1$ group by State 
order by avg_sexratio

--- joining both table to find sex_ratio and population
select a.District ,a.State,a.Sex_Ratio,b.Population from dbo.Data1$ a join dbo.Sheet1$ b on a.District=b.District

--Ques--find male female population
---female/males = sex_ratio----1
--females+males = population----2
--females = polulation - males ---3
--population-males = (sex_ratio)*males (by eq 1)
--population = (sex_ratio)*males+males or males(sex_ratio+1)
-- males=population/(sex_ratio+1)
--similarly
--female = population - population/(sex_ratio)+1
--or females = population (1-1/sex_ratio+1) or (population*sex_ratio)/(sex_ration+1)
select d.state,sum(d.males) as total_males,sum(d.females) as total_female from
(select c.district,c.state,round(c.population/(c.sex_ratio+1),0) males , round((c.population*c.sex_ratio)/(c.sex_ratio+1),0) females from
(select a.District ,a.State,a.Sex_Ratio/1000 sex_ratio,b.Population from dbo.Data1$ a join dbo.Sheet1$ b on a.District=b.District)c)d
group by d.state