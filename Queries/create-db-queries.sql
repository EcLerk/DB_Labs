CREATE DATABASE university_db;

CREATE TABLE "user"(
	id SERIAL PRIMARY KEY,
 	name VARCHAR(30) NOT NULL,
 	surname VARCHAR(30) NOT NULL,
	password VARCHAR(45) NOT NULL,
 	email VARCHAR(45) UNIQUE NOT NULL,
 	isSuperUser BOOL DEFAULT false,
 	isStaff BOOL DEFAULT false,
 
 	CONSTRAINT valid_email CHECK (email ~* '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'),
 	CONSTRAINT valid_user CHECK (length(name) > 0 AND length(surname)>0),
 	CONSTRAINT valid_password CHECK (length(password)>3)
);

CREATE TABLE department
(
	id SERIAL PRIMARY KEY,
	name TEXT NOT NULL,
	
	CONSTRAINT validate_department_name CHECK (length(name)>0)
);

CREATE TABLE professor
(
	id SERIAL PRIMARY KEY,
	specialization VARCHAR(45) NOT NULL,
	userId INT NOT NULL,
	departmentId INT,
	
	FOREIGN KEY (userId) REFERENCES "user" (id) ON DELETE CASCADE,
	FOREIGN KEY (departmentId) REFERENCES department (id) ON DELETE SET NULL
);

CREATE TABLE discipline
(
	id SERIAL PRIMARY KEY,
	name VARCHAR(45) NOT NULL,
	
	CHECK (length(name) > 0)
);

CREATE TABLE professor_discipline
(
	id SERIAL PRIMARY KEY,
	professorId INT NOT NULL,
	disciplineId INT NOT NULL,
	
	FOREIGN KEY (professorId) REFERENCES professor (id) ON DELETE CASCADE,
	FOREIGN KEY (disciplineId) REFERENCES discipline (id) ON DELETE CASCADE
);

CREATE TABLE faculty
(
	id SERIAL PRIMARY KEY,
	name VARCHAR(45) NOT NULL,
	
	CHECK (length(name) > 0)
);

CREATE TABLE speciality
(
	id SERIAL PRIMARY KEY,
	name VARCHAR(45) NOT NULL,
	facultyId INT NOT NULL,
	
	FOREIGN KEY (facultyId) REFERENCES faculty (id) ON DELETE RESTRICT,
	CHECK (length(name) > 0)
);

CREATE TABLE "group"
(
	id SERIAL PRIMARY KEY,
	number INT NOT NULL,
	specialityId INT,
	
	FOREIGN KEY (specialityId) REFERENCES speciality (id),
	CHECK (number >= 0)
);

CREATE TABLE professor_group
(
	id SERIAL PRIMARY KEY,
	professorId INT NOT NULL,
	groupId INT NOT NULL,
	
	FOREIGN KEY (professorId) REFERENCES professor (id) ON DELETE CASCADE,
	FOREIGN KEY (groupId) REFERENCES "group" (id) ON DELETE CASCADE
);

CREATE TABLE discipline_group
(
	id SERIAL PRIMARY KEY,
	disciplineId INT NOT NULL,
	groupId INT NOT NULL,
	
	FOREIGN KEY (disciplineId) REFERENCES professor (id) ON DELETE CASCADE,
	FOREIGN KEY (groupId) REFERENCES "group" (id) ON DELETE CASCADE
);

CREATE TABLE student
(
	id SERIAL PRIMARY KEY,
	enrollmentYear INT NOT NULL,
	graduationYear INT NOT NULL,
	userId INT NOT NULL,
	groupId INT NOT NULL,
	
	FOREIGN KEY (userId) REFERENCES "user" (id) ON DELETE CASCADE,
	FOREIGN KEY (groupId) REFERENCES "group" (id) ON DELETE RESTRICT
);

CREATE TABLE grade
(
	id SERIAL PRIMARY KEY,
	grade SMALLINT NOT NULL,
	studentId INT NOT NULL,
	disciplineId INT NOT NULL,
	
	CHECK (grade BETWEEN 1 AND 10),
	FOREIGN KEY (studentId) REFERENCES student (id) ON DELETE CASCADE,
	FOREIGN KEY (disciplineId) REFERENCES speciality (id) ON DELETE CASCADE
);

CREATE TABLE dayOfWeek
(
	id SERIAL PRIMARY KEY,
	name VARCHAR(15) NOT NULL,
	
	CHECK (length(name) > 0)
);

CREATE TABLE classType
(
	id SERIAL PRIMARY KEY,
	type VARCHAR(45) NOT NULL,
	
	CHECK (length(type) > 0)
);

CREATE TABLE classroom
(
	id SERIAL PRIMARY KEY,
	number INT NOT NULL,
	building INT NOT NULL,
	
	CHECK(number >= 0),
	CHECK(building >= 0)
);

CREATE TABLE "class"
(
	id SERIAL PRIMARY KEY,
	classNumber SMALLINT NOT NULL,
	startTime TIME NOT NULL,
	endTime TIME NOT NULL,
	
	CHECK(classNumber > 0)
);

CREATE TABLE timetable
(
	id SERIAL PRIMARY KEY,
	dayOfWeekId INT NOT NULL,
	classTypeId INT NOT NULL,
	disciplineId INT NOT NULL,
	groupId INT NOT NULL,
	classroomId INT NOT NULL,
	classId INT NOT NULL,
	professorId INT NOT NULL
);