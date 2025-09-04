DELIMITER $$

CREATE PROCEDURE GetStudentPerformance(IN p_StudentID VARCHAR(20))
BEGIN
    -- his/her own performance
    SELECT
        StudentID,
        CONCAT(FirstName, ' ', LastName) AS StudentName,
        Gender, Age, City,
        Stage,
        Status
    FROM admissions
    WHERE StudentID = p_StudentID;

    -- his/her peers performance with same(gender, city, ageband)
    SELECT
        Stage,
        AVG(CASE WHEN Status='Pass' THEN 1 ELSE 0 END)*100 AS PeerPassRatePercent
    FROM admissions
    WHERE Gender = (SELECT Gender FROM admissions WHERE StudentID = p_StudentID LIMIT 1)
      AND City   = (SELECT City FROM admissions WHERE StudentID = p_StudentID LIMIT 1)
      AND (
        (Age BETWEEN 18 AND 20 AND (SELECT Age FROM admissions WHERE StudentID = p_StudentID LIMIT 1) BETWEEN 18 AND 20) OR
        (Age BETWEEN 21 AND 23 AND (SELECT Age FROM admissions WHERE StudentID = p_StudentID LIMIT 1) BETWEEN 21 AND 23) OR
        (Age BETWEEN 24 AND 25 AND (SELECT Age FROM admissions WHERE StudentID = p_StudentID LIMIT 1) BETWEEN 24 AND 25)
      )
    GROUP BY Stage;
END$$

DELIMITER ;

-- --example
-- CALL GetStudentPerformance('s1'); where s1 is a student name

 
