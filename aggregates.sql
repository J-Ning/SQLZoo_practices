
-- SECTION 5: SUM AND COUNT - SQLZoo Practice (Jenny Fu)

-- 1. Total population of the world
SELECT SUM(population) AS total_population
FROM world;

-- 2. List all unique continents
SELECT DISTINCT continent
FROM world;

-- 3. Total GDP of Africa
SELECT SUM(gdp) AS africa_gdp
FROM world
WHERE continent = 'Africa';

-- 4. Number of countries with area >= 1,000,000
SELECT COUNT(name) AS big_country_count
FROM world
WHERE area >= 1000000;

-- 5. Total population of Estonia, Latvia, and Lithuania
SELECT SUM(population) AS baltic_population
FROM world
WHERE name IN ('Estonia', 'Latvia', 'Lithuania');

-- 6. Number of countries per continent
SELECT continent, COUNT(name) AS country_count
FROM world
GROUP BY continent;

-- 7. Number of countries with population >= 10 million per continent
SELECT continent, COUNT(name) AS big_country_count
FROM world
WHERE population >= 10000000
GROUP BY continent;

-- 8. Continents with total population >= 100 million
SELECT continent
FROM world
GROUP BY continent
HAVING SUM(population) >= 100000000;
