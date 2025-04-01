
-- SECTION 6 & 7: JOIN & MORE JOIN - SQLZoo Practice (Jenny Fu)

-- 1. List the films where the year is 1962
SELECT id, title
FROM movie
WHERE yr = 1962;

-- 2. Year of 'Citizen Kane'
SELECT yr
FROM movie
WHERE title = 'Citizen Kane';

-- 3. All 'Star Trek' movies with id, title, year
SELECT id, title, yr
FROM movie
WHERE title LIKE '%Star Trek%'
ORDER BY yr;

-- 4. Actor ID for 'Glenn Close'
SELECT id
FROM actor
WHERE name = 'Glenn Close';

-- 5. Movie ID for 'Casablanca'
SELECT id
FROM movie
WHERE title = 'Casablanca';

-- 6. Cast list for 'Casablanca' (movieid = 11768)
SELECT name AS cast
FROM actor
JOIN casting ON actorid = actor.id
WHERE movieid = 11768;

-- 7. Cast list for 'Alien'
SELECT name AS cast
FROM actor
JOIN casting ON actorid = actor.id
JOIN movie ON movieid = movie.id
WHERE movie.title = 'Alien';

-- 8. Films featuring 'Harrison Ford'
SELECT title
FROM casting
JOIN movie ON movieid = movie.id
JOIN actor ON actorid = actor.id
WHERE actor.name = 'Harrison Ford';

-- 9. Films with 'Harrison Ford' not in starring role
SELECT title
FROM casting
JOIN movie ON movieid = movie.id
JOIN actor ON actorid = actor.id
WHERE actor.name = 'Harrison Ford' AND ord != 1;

-- 10. Leading actors in 1962 films
SELECT title, name AS leading_star
FROM casting
JOIN movie ON movieid = movie.id
JOIN actor ON actorid = actor.id
WHERE yr = 1962 AND ord = 1;

-- 11. Years when 'Rock Hudson' made more than 2 films
SELECT yr, COUNT(title) AS movie_count
FROM movie
JOIN casting ON movie.id = movieid
JOIN actor ON actorid = actor.id
WHERE name = 'Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2;

-- 12. Lead actor in movies with 'Julie Andrews'
SELECT title, name
FROM movie
JOIN casting ON movie.id = movieid
JOIN actor ON actorid = actor.id
WHERE movieid IN (
  SELECT movieid
  FROM casting
  JOIN actor ON actorid = actor.id
  WHERE actorid = (SELECT id FROM actor WHERE name = 'Julie Andrews')
)
AND ord = 1;

-- 13. Actors with at least 15 starring roles
SELECT name
FROM casting
JOIN actor ON actorid = actor.id
WHERE ord = 1
GROUP BY name
HAVING COUNT(name) >= 15
ORDER BY name;

-- 14. Films from 1978 ordered by cast size, then title
SELECT title, COUNT(actorid) AS cast_size
FROM movie
JOIN casting ON movieid = movie.id
WHERE yr = 1978
GROUP BY title
ORDER BY cast_size DESC, title;

-- 15. People who worked with 'Art Garfunkel'
SELECT name
FROM casting
JOIN actor ON actorid = actor.id
WHERE movieid IN (
  SELECT movieid
  FROM casting
  JOIN actor ON actorid = actor.id
  WHERE name = 'Art Garfunkel'
)
AND name != 'Art Garfunkel';
