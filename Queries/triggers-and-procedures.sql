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
