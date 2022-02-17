Use COVID19
--1. Population Infected by Continent
SELECT  location,population,max(total_cases) as Total_cases,
		cast((max(total_cases)/population)*100 as decimal(10,2)) as Population_Infected
FROM ['Covid-Deaths']
where continent is null and location <> 'International'
Group by location,population
order by Total_cases desc;
--2. Total Deaths by Continent
SELECT  location,population,max(cast(total_deaths as int)) as Total_Deaths,
		cast((max(cast(total_deaths as int))/max(total_cases))*100 as decimal(10,2)) as Death_Percentage
FROM ['Covid-Deaths']
where continent is null and location <> 'International'
Group by location,population
order by Total_Deaths desc;
--3. Top 10 countries Infected by Pandemic
SELECT   location, population ,Max(total_cases) as Total_cases,
		cast((max(total_cases)/population)*100 as decimal(10,2)) as Population_Infected 
FROM ['Covid-Deaths']
where continent is not null
Group by location,population
order by Total_cases desc
--4. Top 10 countries by Total deaths
SELECT  top 10 location, population ,Max(cast(total_deaths as int)) as Total_deaths,
		cast(Max(cast(total_deaths as int))/Max(total_cases)*100 as decimal(10,2)) as Death_Percentage
FROM ['Covid-Deaths']
where continent is not null
Group by location,population
order by Total_deaths desc;
--4. Daily Population Affected in Pakistan by Covid-19
SELECT location,date,total_cases,cast(total_cases/population*100 as decimal(10,2)) as '% of Population Infected'
From ['Covid-Deaths']
WHERE location='Pakistan'
ORDER BY date
--5. Daily Deaths in Pakistan by Covid-19
SELECT location,date,total_deaths,total_deaths/total_cases*100 as Death_Chances
From ['Covid-Deaths']
WHERE location='Pakistan'
ORDER BY date
--6. Average Cases and Deaths by Location
SELECT location,Sum(CONVERT(int,new_cases))/COUNT(date) as 'Average Cases per Day',Sum(CONVERT(int,new_deaths))/COUNT(date) as 'Average Deaths Per Day'
From ['Covid-Deaths']
WHERE continent is not null 
GROUP BY location,population
ORDER by [Average Cases per Day] desc
--7. Average Cases and Deaths by Continent
SELECT location,Sum(CONVERT(int,new_cases))/COUNT(date) as 'Average Cases per Day',Sum(CONVERT(int,new_deaths))/COUNT(date) as 'Average Deaths per Day'
From ['Covid-Deaths']
WHERE continent is null 
GROUP BY location
ORDER by [Average Cases per Day] desc
--8. Average No. of Icu and Hopital Patients per day
SELECT location,Sum(CONVERT(int,hosp_patients))/COUNT(date) as 'Average Hospital Patients per Day',Sum(CONVERT(int,icu_patients))/COUNT(date) as 'Average ICU patients per Day'
From ['Covid-Deaths']
GROUP BY location
ORDER by [Average Hospital Patients per Day] desc
--9. Total Tests Taken by country
SELECT location,Max(Convert(int,total_tests)) as 'Total_Tests'
From ['Covid-Vaccines']
group by location,continent
order by Total_Tests desc
--10. Total test vs total cases by country
SELECT dea.location,MAX(Convert(int,total_tests)) as 'Total Tests',MAX(Convert(int,total_cases)) as 'Total Cases',
		MAX(Convert(int,total_tests))/MAX(Convert(int,total_cases)) as 'Positive Rate'
FROM ['Covid-Deaths'] dea
JOIN ['Covid-Vaccines'] vac
	ON dea.location=vac.location
		and dea.date=vac.date
Where dea.continent is not null
GROUP BY dea.location,population
ORDER by [Total Tests] desc
--11. People Vaccinated by Country
SELECT dea.location,population,MAX(Convert(int,total_vaccinations)) as 'Total Vaccinations',
		MAX(Convert(int,people_fully_vaccinated)) as 'People Fully Vaccinated',
		(MAX(Convert(int,people_fully_vaccinated))/dea.population)*100 as '% of People Vaccinated '
FROM ['Covid-Deaths'] dea
JOIN ['Covid-Vaccines'] vac
	ON dea.location=vac.location
		and dea.date=vac.date
Where dea.continent is not null 
GROUP BY dea.location,population
ORDER by [% of People Vaccinated ] desc

