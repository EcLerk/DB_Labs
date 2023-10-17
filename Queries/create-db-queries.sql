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
	name VARCHAR(45) NOT NULL,
	
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

CREATE TABLE "group"
(
	id SERIAL PRIMARY KEY,
	number INT NOT NULL,
	
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
