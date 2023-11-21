--Вычисление среднего балла студента
CREATE OR REPLACE FUNCTION calculate_avg_grade()
RETURNS TRIGGER AS
$$
BEGIN
	UPDATE student
	SET avgGrade =
	(
		SELECT AVG(grade)
		FROM grade
		WHERE studentId = NEW.studentId
	)
	WHERE studentId = NEW.studentId;
	
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_avg_grade
AFTER INSERT OR UPDATE OR DELETE ON grade
FOR EACH ROW
EXECUTE FUNCTION calculate_avg_grade();

--логгирование регистрации пользователей
CREATE OR REPLACE FUNCTION log_user_registration()
RETURNS TRIGGER AS 
$$
BEGIN
    INSERT INTO action (action_time, user_id, action_type_id)
    VALUES (CURRENT_TIMESTAMP, NEW.id, (SELECT id FROM action_type WHERE name = 'Registration'));
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER user_registration_trigger
AFTER INSERT ON "user"
FOR EACH ROW
EXECUTE FUNCTION log_user_registration();




CREATE OR REPLACE PROCEDURE log_action (user_id INT,action_type_id INT)
LANGUAGE 'plpgsql' AS
$$
BEGIN
	INSERT INTO "action" (action_time, user_id, action_type_id)
	VALUES (CURRENT_TIMESTAMP, user_id, action_type_id);
END;
$$

CREATE OR REPLACE FUNCTION log_student_deletion()
RETURNS TRIGGER AS $$
BEGIN
	--logging StudentDeletion
   	CALL log_action(OLD.user_id, 4); 
   
    -- Удаляем пользователя
    DELETE FROM "user" WHERE id = OLD.userId;
    
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER log_student_deletion_trigger
AFTER DELETE ON student
FOR EACH ROW
EXECUTE FUNCTION log_student_deletion();


CREATE OR REPLACE FUNCTION log_professor_deletion()
RETURNS TRIGGER AS $$
BEGIN
	--logging StudentDeletion
   	CALL log_action(OLD.user_id, 5); 
   
    -- Удаляем пользователя
    DELETE FROM "user" WHERE id = OLD.userId;
    
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER log_professor_deletion_trigger
AFTER DELETE ON professor
FOR EACH ROW
EXECUTE FUNCTION log_professor_deletion();

CREATE OR REPLACE FUNCTION users_forbidden_insert()
RETURNS TRIGGER AS
$$
BEGIN

    IF NEW.isstaff = true AND NEW.issuperuser = true THEN
        RAISE EXCEPTION 'Insertion is not allowed';
    END IF;

    RETURN NEW;

END;
$$
LANGUAGE 'plpgsql';

CREATE TRIGGER users_forbidden_insert_trigger
BEFORE INSERT
ON "user"
FOR EACH ROW
EXECUTE PROCEDURE users_forbidden_insert();

--Добавление строки в таблицу студентов
CREATE OR REPLACE PROCEDURE add_new_student(
    enrollment_year INT,
    graduation_year INT,
    user_name VARCHAR(30),
    user_surname VARCHAR(30),
    user_password VARCHAR(45),
    user_email VARCHAR(45),
    is_superuser BOOLEAN,
    is_staff BOOLEAN,
    group_number INT
)
AS $$
DECLARE
    user_id INT;
BEGIN
    -- Добавление пользователя
    INSERT INTO "user" (name, surname, password, email, issuperuser, isstaff)
    VALUES (user_name, user_surname, user_password, user_email, is_superuser, is_staff)
    RETURNING id INTO user_id;
    
    -- Добавление студента
    INSERT INTO student (enrollmentYear, graduationYear, userId, groupId)
    VALUES (enrollment_year, graduation_year, user_id, group_number);
END;
$$ LANGUAGE plpgsql;

call add_new_student(2021, 2025, 'Лера', 'Качановская', '12345', 'lerakachanovskaya@gmail.com', false, false, 3);

--Добавление оценки студенту
CREATE OR REPLACE PROCEDURE add_grade_to_student(
    IN student_id INT,
    IN discipline_id INT,
    IN grade_value INT
)
AS $$
BEGIN
    INSERT INTO grade (grade, studentId, disciplineId)
    VALUES (grade_value, student_id, discipline_id);
END;
$$ LANGUAGE plpgsql;