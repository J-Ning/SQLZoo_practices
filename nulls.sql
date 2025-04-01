
-- SECTION 8: USING NULL - SQLZoo Practice (Jenny Fu)

-- 1. List the teachers who have NULL for their department
SELECT name
FROM teacher
WHERE dept IS NULL;

-- 2. INNER JOIN (excludes teachers without departments and departments without teachers)
SELECT teacher.name, dept.name
FROM teacher
INNER JOIN dept ON teacher.dept = dept.id;

-- 3. LEFT JOIN (includes all teachers, even if they have no department)
SELECT teacher.name, dept.name
FROM teacher
LEFT JOIN dept ON teacher.dept = dept.id;

-- 4. LEFT JOIN reversed (includes all departments, even if they have no teachers)
SELECT teacher.name, dept.name
FROM dept
LEFT JOIN teacher ON teacher.dept = dept.id;

-- 5. Show teacher name and mobile number or a default value if missing
SELECT name, COALESCE(mobile, '07986 444 2266') AS mobile
FROM teacher;

-- 6. Show teacher name and department name, or 'None' if no department
SELECT teacher.name, COALESCE(dept.name, 'None') AS department
FROM teacher
LEFT JOIN dept ON teacher.dept = dept.id;

-- 7. Count total number of teachers and how many have mobile numbers
SELECT COUNT(name) AS total_teachers, COUNT(mobile) AS with_mobile
FROM teacher;

-- 8. Show department names and number of staff (RIGHT JOIN ensures all departments shown)
SELECT dept.name, COUNT(teacher.name) AS staff_count
FROM teacher
RIGHT JOIN dept ON teacher.dept = dept.id
GROUP BY dept.name;

-- 9. Use CASE to label teachers as 'Sci' (dept 1 or 2) or 'Art' otherwise
SELECT name,
  CASE
    WHEN dept IN (1, 2) THEN 'Sci'
    ELSE 'Art'
  END AS subject
FROM teacher;

-- 10. Use CASE to label teachers as 'Sci' (dept 1 or 2), 'Art' (dept 3), or 'None'
SELECT name,
  CASE
    WHEN dept IN (1, 2) THEN 'Sci'
    WHEN dept = 3 THEN 'Art'
    ELSE 'None'
  END AS subject
FROM teacher;
