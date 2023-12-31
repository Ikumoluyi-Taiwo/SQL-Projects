SELECT *
FROM CovidDeaths
WHERE continent is not null
ORDER BY 3, 4

--SELECT *
--FROM CovidVaccinations
--ORDER BY 3, 4

SELECT continent, date, total_cases, new_cases, total_deaths, population
FROM CovidDeaths
WHERE continent is not null
ORDER BY 1, 2

--Total Cases VS Total Deaths(likelihood of dying if contracted per country)

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases) * 100 as DeathPercentage
FROM CovidDeaths
--WHERE location like 'Nigeria'
WHERE continent is not null
ORDER BY 1, 2


--Total Cases Vs Population(Percentage of population infected with Covid per country)

SELECT location, date, population total_cases, (total_cases/population) * 100 as PercentPopulationInfected
FROM CovidDeaths
--WHERE location like 'Nigeria'
WHERE continent is not null
ORDER BY 1, 2

--Countries with highest infection rates vs population

SELECT location, population, MAX(total_cases) as HighestInfectionCount,
		MAX((total_cases/population)) * 100 as PercentPopulationInfected
FROM CovidDeaths
--WHERE location like 'Nigeria'
WHERE continent is not null
GROUP BY location, population
ORDER BY PercentPopulationInfected desc

--Death count per Country

SELECT location, MAX(CAST(total_deaths as int)) as TotalDeathCount
FROM CovidDeaths
--WHERE location like 'Nigeria'
WHERE continent is not null
GROUP BY location
ORDER BY TotalDeathCount desc

--DeathCount By Continent

SELECT continent, MAX(CAST(total_deaths as int)) as TotalDeathCount
FROM CovidDeaths
--WHERE location like 'Nigeria'
WHERE continent is not null
GROUP BY continent
ORDER BY TotalDeathCount desc

--Global Numbers

SELECT SUM(new_cases) as Total_Cases, SUM(CAST(new_deaths as int)) as Total_Deaths, 
		SUM(CAST(new_deaths as int)) * 100/SUM(new_cases) as DeathPercentage
FROM CovidDeaths
--WHERE location like 'Nigeria'
WHERE continent is not null
--GROUP BY date
ORDER BY 1, 2 

SELECT date, SUM(new_cases) as Total_Cases, SUM(CAST(new_deaths as int)) as Total_Deaths, 
		SUM(CAST(new_deaths as int)) * 100/SUM(new_cases) as DeathPercentage
FROM CovidDeaths
--WHERE location like 'Nigeria'
WHERE continent is not null
GROUP BY date
ORDER BY 1, 2 

--Total Population Vs Vaccination

SELECT Dea.continent, Dea.location, Dea.date, Dea.population, Vac.new_vaccinations, 
		SUM(CONVERT(int, Vac.new_vaccinations)) OVER (PARTITION BY Dea.location ORDER BY Dea.location, Dea.date ) as VaccinatedRunningTotal
FROM CovidDeaths as Dea
INNER JOIN CovidVaccinations as Vac
ON Dea.location = Vac.location
AND Dea.date = Vac.date
WHERE Dea.continent is not null
ORDER BY 2, 3

--Using CTE

WITH PopulationVsVaccine(continent, location, date, population, new_vaccinations, VaccinatedRunningTotal) AS 
	(SELECT Dea.continent, Dea.location, Dea.date, Dea.population, Vac.new_vaccinations, 
			SUM(CONVERT(int, Vac.new_vaccinations)) OVER (PARTITION BY Dea.location ORDER BY Dea.location, Dea.date ) as VaccinatedRunningTotal
	FROM CovidDeaths as Dea
	INNER JOIN CovidVaccinations as Vac
	ON Dea.location = Vac.location
	AND Dea.date = Vac.date
	WHERE Dea.continent is not null
	)
	SELECT *, (VaccinatedRunningTotal/population) * 100
	FROM PopulationVsVaccine


--Temp Table
DROP TABLE IF EXISTS #PopulationVsVaccine
CREATE TABLE #PopulationVsVaccine (
	Continent nvarchar(255),
	Location nvarchar (255),
	Date datetime,
	Population numeric,
	New_Vaccinations numeric,
	VaccinatedRunningTotal numeric)

	INSERT INTO #PopulationVsVaccine
	SELECT Dea.continent, Dea.location, Dea.date, Dea.population, Vac.new_vaccinations, 
			SUM(CONVERT(int, Vac.new_vaccinations)) OVER (PARTITION BY Dea.location ORDER BY Dea.location, Dea.date ) as VaccinatedRunningTotal
	FROM CovidDeaths as Dea
	INNER JOIN CovidVaccinations as Vac
	ON Dea.location = Vac.location
	AND Dea.date = Vac.date
	WHERE Dea.continent is not null
	
	SELECT *, (VaccinatedRunningTotal/population) * 100
	FROM #PopulationVsVaccine

--Creating View

CREATE VIEW PopulationVsVaccine AS
SELECT Dea.continent, Dea.location, Dea.date, Dea.population, Vac.new_vaccinations, 
			SUM(CONVERT(int, Vac.new_vaccinations)) OVER (PARTITION BY Dea.location ORDER BY Dea.location, Dea.date ) as VaccinatedRunningTotal
	FROM CovidDeaths as Dea
	INNER JOIN CovidVaccinations as Vac
	ON Dea.location = Vac.location
	AND Dea.date = Vac.date
	WHERE Dea.continent is not null

SELECT *
FROM PopulationVsVaccine



















