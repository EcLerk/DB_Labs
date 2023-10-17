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