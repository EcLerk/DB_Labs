INSERT INTO "user" (name, surname, password, email, issuperuser,
				   isstaff)
VALUES 	('admin', 'admin', 'adminPass', 'admin@mail.ru', true, false),
		('Виктория', 'Звягинцева', '1234', 'vika@gmail.com', false, false),
	    ('Евгений', 'Кахновский', 'password', 'kaxxa2927@gmail.com',false, false),
		('Владислав', 'Плиска', 'newPass', 'email@gmail.com' , false, true),
		('Анна', 'Жвакина', 'pass123', 'anna@gmail.com', false, true),
		('Игорь', 'Гламаздин', 'anotherPass', 'csharpovich@gmail.com', false, true),
		('Вячеслав', 'Проволоцкий', 'qwerty', 'v.provolotskiy@gmail.com', false, true);
				  
INSERT INTO "group" (number, specialityId)
VALUES 	(153501, 1),
		(153502, 2),
		(153503, 1);

INSERT INTO faculty (name)
VALUES ('КСиС'),
		('ФиТУ');

INSERT INTO speciality (name, facultyId)
VALUES 	('ИиТП', 1),
		('АСОИ', 2);
		
INSERT INTO student (enrollmentYear, graduationYear,
					userId, groupId)
VALUES (2021, 2025, 2, 3),
(2023, 2027, 3, 1);

INSERT INTO department (name)
VALUES ('Информатики'),
	('Высшей математики'),
	('Программного обеспечения информационных технологий');

INSERT INTO discipline (name)
VALUES ('МДиСУБД'),
	('СППР'),
	('СТРweb-пр'),
	('ВПО');

INSERT INTO professor (userId, departmentId, yearsOfExperience)
VALUES (4, 3, 3),
	(5, 1, 10),
	(6, 2, 21),
	(7, 1, 15);

INSERT INTO professor_discipline (professorId, disciplineId)
VALUES (1, 1),
	(2, 3),
	(3, 2),
	(4, 1);

INSERT INTO professor_group (professorid, groupid)
VALUES (1, 1),
	(1, 2),
	(2, 1),
	(3, 3),
	(3, 1),
	(4, 1),
	(4, 2),
	(4, 3);

INSERT INTO discipline_group (disciplineId, groupId)
VALUES (1, 1),
	(1, 2),
	(1, 3),
	(2, 2),
	(3, 1),
	(3, 2),
	(3, 3),
	(4, 3);

INSERT INTO grade (grade, studentId, disciplineId)
VALUES (10, 1, 1),
	(8, 1, 1),
	(9, 1, 1),
	(9, 1, 2),
	(7, 1, 3),
	(10, 1, 4),	
	(8, 2, 1),
	(8, 2, 2),
	(8, 2, 2),
	(10, 2, 2),
	(9, 2, 3),
	(10, 2, 4);

INSERT INTO "class" (classnumber, starttime, endtime)
VALUES (1, '9:00', '10:20'),
	(2, '10:35', '11:55'),
	(3, '12:25', '13:45'),
	(4, '14:00', '15:20'),
	(5, '15:50', '17:10'),
	(6, '17:25', '18:45'),
	(7, '19:00', '20:20'),
	(8, '20:40', '22:00');