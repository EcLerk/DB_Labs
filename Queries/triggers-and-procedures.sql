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