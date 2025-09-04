WITH StageLag AS (
    SELECT
        StudentID,
        Stage,
        ExamDateTime,
        LAG(ExamDateTime) OVER (
            PARTITION BY StudentID
            ORDER BY ExamDateTime
        ) AS PreviousExamDateTime
    FROM admissions
)
SELECT
    Stage,
    COUNT(DISTINCT StudentID) AS StudentCount,
    AVG(DATEDIFF(ExamDateTime, PreviousExamDateTime)) AS AvgTurnaroundDays
FROM StageLag
GROUP BY Stage
ORDER BY Stage;
