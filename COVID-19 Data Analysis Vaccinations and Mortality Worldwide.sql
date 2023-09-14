select * 
from dbo.Sample 
where continent is not null 
order by 3,4

--slect data that we are going to be using

select location, date, total_cases, new_cases, total_deaths, population
from dbo.Sample
where continent is not null
order by 1,2

--looking at total cases vs total deaths

select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as deathpercentage
from dbo.sample
where continent is not null
order by 1,2

-- this is where states only in location
select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as deathpercentage
from dbo.sample 
where location like '%states%' and where continent is not null
order by 1,2

--looking at total cases vs population
--shows what percentage of population got covid in states

select location, date, total_cases, population, (total_cases/population)*100 as got_covid_percentage
from dbo.sample 
where location like '%states%' and where continent is not null
order by 1,2

--shows what percentage of population got covid in world
select location, date, total_cases, population, (total_cases/population)*100 as got_covid_percentage
from dbo.sample 
where continent is not null
order by 1,2

--looking at countries with highest infection rate compared to population

select location, population,max(total_cases) as highest_infectioncount,
max((total_cases/population))*100 as percentage_of_population_infected
from dbo.sample 
where continent is not null
group by location,population
order by percentage_of_population_infected desc

--showing countries with highest death count per population with all

select location, population,max(total_deaths) as totaldeathcount
from dbo.sample 
group by location,population
order by totaldeathcount desc

--showing countries with highest death count per population

select location, max(cast(total_deaths as int)) as totaldeathcount
from dbo.sample 
where continent is not null
group by location
order by totaldeathcount desc

--showing Coutinents with highest death count per population

select continent, max(cast(total_deaths as int)) as totaldeathcount
from dbo.sample 
where continent is not null
group by continent
order by totaldeathcount desc

select location, max(cast(total_deaths as int)) as totaldeathcount
from dbo.sample 
where continent is null
group by location
order by totaldeathcount desc

-- global number 

select date, sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths,
sum(cast(new_deaths as int))/sum(new_cases)*100 as deathpercentage
from dbo.Sample
where continent is not null
group by date
order by 1,2

--only total of all cases

select  sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths,
sum(cast(new_deaths as int))/sum(new_cases)*100 as deathpercentage
from dbo.Sample
where continent is not null
order by 1,2


--Looking at total population vs vaccinations

select * 
from dbo.Sample as dea 
join dbo.vac as vac
  on dea.location = vac.location
  and dea.date = vac.date


select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
from dbo.Sample as dea 
join dbo.vac as vac
  on dea.location = vac.location
  and dea.date = vac.date
  where dea.continent is not null
  order by 2,3


  --shows how many people vaccinated in day

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(convert(int,vac.new_vaccinations)) over (partition by dea.location
order by dea.location,dea.date) as rolling_people_vaccinated
from dbo.Sample as dea 
join dbo.vac as vac
  on dea.location = vac.location
  and dea.date = vac.date
  where dea.continent is not null
  order by 2,3
   




