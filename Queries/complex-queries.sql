SELECT name FROM "user" WHERE issuperuser = true AND isstaff = false;

SELECT "user".name, professor.yearsOfExperience
FROM professor
JOIN department ON professor.departmentId = department.id
JOIN "user" ON professor.userId = "user".id
WHERE department.name = 'Информатики' AND professor.yearsOfExperience = 10;

SELECT "user".name, "group".number
FROM student
JOIN "user" ON student.userId = "user".id
JOIN "group" ON student.groupId = "group".id;

SELECT "group".number, "user".name
FROM "group"
LEFT JOIN student ON "group".id = student.groupId
LEFT JOIN "user" ON "user".id = student.userId

SELECT u.name, g.number
FROM student st
LEFT JOIN "user" u ON st.userId = u.id
LEFT JOIN "group" g ON st.groupId = g.id;

SELECT  student.name, student.surname
FROM "user" u1 
JOIN student ON u1.Id = student.userId
JOIN "group" ON "group".Id = student.groupId
JOIN professor_group ON "group".Id = professor_group.groupId
JOIN professor ON professor_group.professorId = professor.id
JOIN "user" u2 ON u2.Id = professor.userId
WHERE u2.surname = 'Жвакина'

EXPLAIN SELECT * FROM timetable;

SELECT *, row_number() OVER () as num FROM timetable;

SELECT grade, studentId FROM grade 
WHERE grade > (SELECT AVG(grade) FROM grade)

--выбрать студентов, у которых есть оценки по бд
SELECT u.name AS "name"
FROM "user" u
JOIN student st ON u.id = st.userId
WHERE EXISTS (
    SELECT 1
    FROM grade g
    JOIN discipline d ON g.disciplineId = d.id
    WHERE st.id = g.studentId
      AND d.name = 'МДиСУБД'
);

SELECT
    "user".name AS student_name,
    grade.grade,
    CASE
        WHEN grade.grade >= 9 THEN 'Отлично'
        WHEN grade.grade >= 7 THEN 'Хорошо'
        WHEN grade.grade >= 5 THEN 'Удовлетворительно'
        ELSE 'Неудовлетворительно'
    END AS grade_category
FROM
    "user"
JOIN student ON "user".id = student.userId
JOIN grade ON student.id = grade.studentId
JOIN discipline ON grade.disciplineId = discipline.id
WHERE
    discipline.name = 'МДиСУБД';

SELECT
    "user".name AS professor_name,
    discipline.name AS discipline_name,
    COUNT(*) AS discipline_count
FROM
    "user"
JOIN professor ON "user".id = professor.userId
JOIN professor_discipline ON professor.id = professor_discipline.professorId
JOIN discipline ON professor_discipline.disciplineId = discipline.id
GROUP BY
    "user".name,
    discipline.name;

SELECT
    "user".name AS professor_name,
    discipline.name AS discipline_name,
 	
FROM "user"
JOIN professor ON professor.userId = "user".Id
JOIN professor_discipline ON professor.Id = professor_discipline.professorId
JOIN discipline ON professor_discipline.disciplineId = discipline.Id
JOIN discipline_group ON discipline_group.disciplineId = discipline.Id
GROUP BY "user".name, discipline.name, discipline_group.disciplineId



SELECT
    discipline.name AS discipline_name,
    COALESCE("user".name, 'Без преподавателя') AS professor_name,
    COUNT(DISTINCT "group".id) AS group_count
FROM
    discipline
JOIN discipline_group ON discipline.id = discipline_group.disciplineId
JOIN "group" ON discipline_group.groupId = "group".id
LEFT JOIN professor_discipline ON discipline.id = professor_discipline.disciplineId
LEFT JOIN professor ON professor_discipline.professorId = professor.id
LEFT JOIN "user" ON professor.userId = "user".id
GROUP BY
    discipline.name,
    "user".name;

