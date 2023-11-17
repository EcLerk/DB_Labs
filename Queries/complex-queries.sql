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
