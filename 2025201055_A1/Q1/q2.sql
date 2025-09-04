-- pass rate after grp by gender
SELECT
  'Gender' AS Dimension,
  Gender AS Category,
  Stage,
  AVG(CASE WHEN Status='Pass' THEN 1 ELSE 0 END) AS PassRate
FROM admissions
GROUP BY Gender, Stage

UNION ALL

-- pass rate by difn age grp
SELECT
  'AgeBand' AS Dimension,
  CASE
    WHEN Age BETWEEN 18 AND 20 THEN '18-20'
    WHEN Age BETWEEN 21 AND 23 THEN '21-23'
    WHEN Age BETWEEN 24 AND 25 THEN '24-25'
  END AS Category,
  Stage,
  AVG(CASE WHEN Status='Pass' THEN 1 ELSE 0 END) AS PassRate
FROM admissions
GROUP BY Category, Stage

UNION ALL

-- pass rate by  cty
SELECT
  'City' AS Dimension,
  City AS Category,
  Stage,
  AVG(CASE WHEN Status='Pass' THEN 1 ELSE 0 END) AS PassRate
FROM admissions
GROUP BY City, Stage;
