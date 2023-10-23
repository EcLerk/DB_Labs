SELECT * FROM "user";

SELECT name, surname FROM "user";

SELECT MAX(grade) FROM grade;

SELECT MIN(grade) FROM grade;

SELECT building, COUNT(number) AS "classrooms count"
FROM classroom
GROUP BY building;

SELECT * FROM discipline
ORDER BY name;

SELECT * FROM "user"
ORDER BY surname
LIMIT 5 OFFSET 2;

SELECT * FROM classroom
WHERE number BETWEEN 200 AND 300;

SELECT * FROM "user"
WHERE email NOT LIKE '%mail.ru';

SELECT studentId, AVG(grade)
FROM grade
GROUP BY studentId
HAVING AVG(grade) > 8
ORDER BY studentId;

SELECT DISTINCT grade FROM grade
ORDER BY grade DESC;


