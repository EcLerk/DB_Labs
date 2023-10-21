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

INSERT INTO classroom (number, building)
VALUES (101, 1),
	(102, 1),
	(103, 1),
	(104, 1),
	(105, 1),
	(106, 1),
	(107, 1),
	(108, 1),
	(109, 1),
	(110, 1),
	(201, 1),
	(202, 1),
	(203, 1),
	(204, 1),
	(205, 1),
	(206, 1),
	(207, 1),
	(208, 1),
	(209, 1),
	(210, 1),
	(101, 2),
	(102, 2),
	(103, 2),
	(104, 2),
	(105, 2),
	(106, 2),
	(107, 2),
	(108, 2),
	(109, 2),
	(110, 2),
	(201, 2),
	(202, 2),
	(203, 2),
	(204, 2),
	(205, 2),
	(206, 2),
	(207, 2),
	(208, 2),
	(209, 2),
	(210, 2),
	(101, 3),
	(102, 3),
	(103, 3),
	(104, 3),
	(105, 3),
	(106, 3),
	(107, 3),
	(108, 3),
	(109, 3),
	(110, 3),
	(201, 3),
	(202, 3),
	(203, 3),
	(204, 3),
	(205, 3),
	(206, 3),
	(207, 3),
	(208, 3),
	(209, 3),
	(210, 3);

INSERT INTO dayOfWeek (name)
VALUES ('Понедельник'),
	('Вторник'),
	('Среда'),
	('Четверг'),
	('Пятница'),
	('Суббота');

INSERT INTO classtype (type)
VALUES ('ЛК'),
	('ЛР'),
	('ПЗ');