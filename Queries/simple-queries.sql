SELECT * FROM "user"

SELECT name, surname FROM "user"

SELECT MAX(grade) FROM grade

SELECT MIN(grade) FROM grade

SELECT building, COUNT(number) AS "classrooms count"
FROM classroom
GROUP BY building