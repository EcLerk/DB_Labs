INSERT INTO "user" (name, surname, password, email, issuperuser,
				   isstaff)
VALUES 	('admin', 'admin', 'adminPass', 'admin@mail.ru', true, false),
		('Виктория', 'Звягинцева', '1234', 'vika@gmail.com', false, false),
	    ('Евгений', 'Кахновский', 'password', 'kaxxa2927@gmail.com',false, false),
		('Владислав', 'Плиска', 'newPass', 'email@gmail.com' , false, true),
		('Анна', 'Жвакина', 'pass123', 'anna@gmail.com', false, true),
		('Игорь', 'Гламаздин', 'anotherPass', 'csharpovich@gmail.com', false, true),
		('Вячеслав', 'Проволоцкий', 'qwerty', 'v.provolotskiy@gmail.com', false, true);
				
INSERT INTO "group" (number)
VALUES 	(153501),
		(153502),
		(153503);

INSERT INTO faculty (name)
VALUES ('КСиС'),
		('ФиТУ');

INSERT INTO speciality (name, facultyId)
VALUES 	('ИиТП', 1),
		('АСОИ', 2);