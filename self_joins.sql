
-- SECTION 9: SELF JOIN - SQLZoo Practice (Jenny Fu)

-- 1. Count how many stops are in the database
SELECT COUNT(id)
FROM stops;

-- 2. Find the id value for the stop 'Craiglockhart'
SELECT id
FROM stops
WHERE name = 'Craiglockhart';

-- 3. Get the id and name for stops on the '4' 'LRT' service
SELECT id, name
FROM stops
JOIN route ON stop = id
WHERE company = 'LRT' AND num = '4';

-- 4. Find routes that visit both 'London Road' (149) and 'Craiglockhart' (53)
SELECT company, num, COUNT(*)
FROM route
WHERE stop IN (149, 53)
GROUP BY company, num
HAVING COUNT(*) = 2;

-- 5. Find services from 'Craiglockhart' to 'London Road'
SELECT a.company, a.num, a.stop, b.stop
FROM route a
JOIN route b ON a.company = b.company AND a.num = b.num
WHERE a.stop = 53
  AND b.stop = (SELECT id FROM stops WHERE name = 'London Road');

-- 6. Same as above but show names of stops instead of ids
SELECT a.company, a.num, stopa.name, stopb.name
FROM route a
JOIN route b ON a.company = b.company AND a.num = b.num
JOIN stops stopa ON a.stop = stopa.id
JOIN stops stopb ON b.stop = stopb.id
WHERE stopa.name = 'Craiglockhart'
  AND stopb.name = 'London Road';

-- 7. List services connecting stops 115 ('Haymarket') and 137 ('Leith')
SELECT DISTINCT a.company, a.num
FROM route a
JOIN route b ON a.company = b.company AND a.num = b.num
WHERE a.stop = 115 AND b.stop = 137;

-- 8. List services connecting 'Craiglockhart' and 'Tollcross'
SELECT DISTINCT a.company, a.num
FROM route a
JOIN route b ON a.company = b.company AND a.num = b.num
JOIN stops c ON a.stop = c.id
JOIN stops d ON b.stop = d.id
WHERE c.name = 'Craiglockhart' AND d.name = 'Tollcross';

-- 9. List stops reachable from 'Craiglockhart' using one bus (LRT only)
SELECT DISTINCT d.name, a.company, a.num
FROM route a
JOIN route b ON a.company = b.company AND a.num = b.num
JOIN stops c ON a.stop = c.id
JOIN stops d ON b.stop = d.id
WHERE a.company = 'LRT' AND c.name = 'Craiglockhart';

-- 10. Routes using two buses to travel from 'Craiglockhart' to 'Lochend'
SELECT x.num, x.company, x.name, y.num, y.company
FROM (
  SELECT DISTINCT stopb.name, b.company, b.num
  FROM route a
  JOIN route b ON a.company = b.company AND a.num = b.num
  JOIN stops stopa ON a.stop = stopa.id
  JOIN stops stopb ON b.stop = stopb.id
  WHERE stopa.name = 'Craiglockhart'
) x
JOIN (
  SELECT DISTINCT stopc.name, c.company, c.num
  FROM route c
  JOIN route d ON c.company = d.company AND c.num = d.num
  JOIN stops stopc ON c.stop = stopc.id
  JOIN stops stopd ON d.stop = stopd.id
  WHERE stopd.name = 'Lochend'
) y ON x.name = y.name
ORDER BY x.num, x.name, y.num;
