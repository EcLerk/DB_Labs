INSERT INTO "user" (name, surname, password, email, issuperuser,
				   isstaff)
VALUES 	('admin', 'admin', 'adminPass', 'admin@mail.ru', true, false),
		('��������', '����������', '1234', 'vika@gmail.com', false, false),
	    ('�������', '����������', 'password', 'kaxxa2927@gmail.com',false, false),
		('���������', '������', 'newPass', 'email@gmail.com' , false, true),
		('����', '�������', 'pass123', 'anna@gmail.com', false, true),
		('�����', '���������', 'anotherPass', 'csharpovich@gmail.com', false, true),
		('��������', '�����������', 'qwerty', 'v.provolotskiy@gmail.com', false, true);
				
INSERT INTO "group" (number)
VALUES 	(153501),
		(153502),
		(153503);

INSERT INTO faculty (name)
VALUES ('����'),
		('����');

INSERT INTO speciality (name, facultyId)
VALUES 	('����', 1),
		('����', 2);