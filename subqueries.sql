
-- SECTION 1: SELECT BASICS - SQLZoo Practice (Jenny Fu)

-- 1. Population of Germany
SELECT population
FROM world
WHERE name = 'Germany';

-- 2. Population of Scandinavian countries
SELECT name, population
FROM world
WHERE name IN ('Sweden', 'Norway', 'Denmark');

-- 3. Countries with area between 200,000 and 250,000
SELECT name, area
FROM world
WHERE area BETWEEN 200000 AND 250000;

-- SECTION 2: SELECT FROM WORLD

-- 1. Name, continent, population of all countries
SELECT name, continent, population
FROM world;

-- 2. Countries with population >= 200 million
SELECT name
FROM world
WHERE population >= 200000000;

-- 3. Per capita GDP for countries with population >= 200 million
SELECT name, gdp/population AS per_capita_gdp
FROM world
WHERE population >= 200000000;

-- 4. Population in millions for South America
SELECT name, population/1000000 AS pop_millions
FROM world
WHERE continent = 'South America';

-- 5. Population of France, Germany, Italy
SELECT name, population
FROM world
WHERE name IN ('France', 'Germany', 'Italy');

-- 6. Countries with 'United' in name
SELECT name
FROM world
WHERE name LIKE '%United%';

-- 7. Countries big by area or population
SELECT name, population, area
FROM world
WHERE population > 250000000 OR area > 3000000;

-- 8. Big by area XOR population (not both)
SELECT name, population, area
FROM world
WHERE (area > 3000000 AND population <= 250000000)
   OR (population > 250000000 AND area <= 3000000);

-- 9. Rounded population (millions) and GDP (billions) for South America
SELECT name,
       ROUND(population/1000000, 2) AS pop_mil,
       ROUND(gdp/1000000000, 2) AS gdp_bil
FROM world
WHERE continent = 'South America';

-- 10. Trillion-dollar economies: per-capita GDP rounded to nearest $1000
SELECT name, ROUND(gdp/population, -3) AS per_capita_gdp
FROM world
WHERE gdp >= 1000000000000;

-- 11. Name and capital with same length
SELECT name, capital
FROM world
WHERE LENGTH(name) = LENGTH(capital);

-- 12. Name and capital start with same letter, not the same word
SELECT name, capital
FROM world
WHERE LEFT(name,1) = LEFT(capital,1)
  AND name <> capital;

-- 13. Countries with all vowels, no spaces
SELECT name
FROM world
WHERE name LIKE '%a%' AND name LIKE '%e%'
  AND name LIKE '%i%' AND name LIKE '%o%'
  AND name LIKE '%u%' AND name NOT LIKE '% %';

-- SECTION 3: SELECT FROM NOBEL

-- 1. Nobel prizes in 1950
SELECT yr, subject, winner
FROM nobel
WHERE yr = 1950;

-- 2. 1962 Literature prize winner
SELECT winner
FROM nobel
WHERE yr = 1962 AND subject = 'literature';

-- 3. Prize info for Albert Einstein
SELECT yr, subject
FROM nobel
WHERE winner = 'Albert Einstein';

-- 4. Peace prize winners since 2000
SELECT winner
FROM nobel
WHERE subject = 'peace' AND yr >= 2000;

-- 5. Literature prize winners (1980s)
SELECT yr, subject, winner
FROM nobel
WHERE subject = 'literature' AND yr BETWEEN 1980 AND 1989;

-- 6. Presidential Nobel prize winners
SELECT *
FROM nobel
WHERE winner IN ('Theodore Roosevelt', 'Thomas Woodrow Wilson', 'Jimmy Carter', 'Barack Obama');

-- 7. Winners named John
SELECT winner
FROM nobel
WHERE winner LIKE 'John%';

-- 8. Physics (1980) + Chemistry (1984)
SELECT yr, subject, winner
FROM nobel
WHERE (subject = 'physics' AND yr = 1980)
   OR (subject = 'chemistry' AND yr = 1984);

-- 9. 1980 winners excluding chemistry and medicine
SELECT yr, subject, winner
FROM nobel
WHERE yr = 1980 AND subject NOT IN ('chemistry', 'medicine');

-- 10. Early medicine (<1910) or late literature (>=2004)
SELECT yr, subject, winner
FROM nobel
WHERE (subject = 'Medicine' AND yr < 1910)
   OR (subject = 'literature' AND yr >= 2004);

-- 11. Prize for PETER GRÜNBERG
SELECT *
FROM nobel
WHERE winner = 'PETER GRÜNBERG';

-- 12. Prize for EUGENE O'NEILL
SELECT *
FROM nobel
WHERE winner = "EUGENE O'NEILL";

-- 13. Knights of the realm
SELECT winner, yr, subject
FROM nobel
WHERE winner LIKE 'Sir%'
ORDER BY yr DESC, winner;

-- 14. Chemistry and Physics last
SELECT winner, subject
FROM nobel
WHERE yr = 1984
ORDER BY subject IN ('physics','chemistry'), subject, winner;

-- SECTION 4: SELECT WITHIN SELECT

-- 1. Countries with population > Russia
SELECT name
FROM world
WHERE population > (SELECT population FROM world WHERE name = 'Russia');

-- 2. Europe countries with per capita GDP > UK
SELECT name
FROM world
WHERE continent = 'Europe'
  AND gdp/population > (SELECT gdp/population FROM world WHERE name = 'United Kingdom');

-- 3. Countries in continents with Argentina or Australia
SELECT name, continent
FROM world
WHERE continent IN (
  SELECT continent
  FROM world
  WHERE name IN ('Argentina', 'Australia')
)
ORDER BY name;

-- 4. Countries with population between UK and Germany
SELECT name, population
FROM world
WHERE population > (SELECT population FROM world WHERE name = 'United Kingdom')
  AND population < (SELECT population FROM world WHERE name = 'Germany');

-- 5. Population percentage of Germany
SELECT name,
       CONCAT(ROUND(population / (SELECT population FROM world WHERE name = 'Germany') * 100, 0), '%') AS percent_of_germany
FROM world
WHERE continent = 'Europe';

-- 6. Countries with GDP > every European country
SELECT name
FROM world
WHERE gdp > ALL (
  SELECT gdp
  FROM world
  WHERE continent = 'Europe' AND gdp > 0
);

-- 7. Largest country (by area) in each continent
SELECT continent, name, area
FROM world x
WHERE area >= ALL (
  SELECT area
  FROM world y
  WHERE y.continent = x.continent AND area > 0
);

-- 8. First country alphabetically per continent
SELECT continent, name
FROM world x
WHERE name <= ALL (
  SELECT name
  FROM world y
  WHERE x.continent = y.continent
);

-- 9. Countries in continents where all countries have population <= 25 million
SELECT name, continent, population
FROM world
WHERE continent IN (
  SELECT continent
  FROM world
  GROUP BY continent
  HAVING MAX(population) <= 25000000
);

-- 10. Countries more than 3× as populous as all neighbors in same continent
SELECT name, continent
FROM world x
WHERE continent NOT IN (
  SELECT continent
  FROM world y
  WHERE x.continent = y.continent
    AND x.population < 3 * y.population
    AND x.name <> y.name
);
