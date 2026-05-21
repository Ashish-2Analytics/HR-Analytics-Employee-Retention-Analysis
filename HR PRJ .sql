SELECT * FROM HR_1;
SELECT * FROM HR_2;

--- Total Employees

select count(distinct(employeeid)) as Total_employees 
from hr_2;

--- Employees by gender

select gender,count(distinct(EmployeeNumber)) as Employee_count 
from hr_1 
group by gender;


--- Attrition count

select count(attrition) as Attrition_count 
from HR_1
where Attrition=1;


--- Attrition rate

 
SELECT FORMAT(AVG(CAST(Attrition AS FLOAT)) * 100, 'N2') AS Attrition_rate
FROM dbo.HR_1;


--- Gender wise attrition rate
SELECT a.Gender,
       FORMAT(AVG(a.attrition_yes) * 100, 'N2') AS Attrition_rate
FROM (
    SELECT Gender,
           CASE WHEN Attrition = 1 THEN 1.0 ELSE 0.0 END AS attrition_yes
    FROM dbo.HR_1
) AS a
GROUP BY a.Gender
ORDER BY AVG(a.attrition_yes) DESC;



--- Department wise attrition rate

SELECT Department,
       ROUND(AVG(CAST(Attrition AS FLOAT)) * 100, 2) AS Attrition_Rate
FROM dbo.HR_1
GROUP BY Department
ORDER BY Attrition_Rate DESC;


--- Average Hourly rate of Male Research Scientist
SELECT JobRole,
       Gender,
       FORMAT(AVG(CAST(HourlyRate AS FLOAT)), 'N2') AS Hourly_Rate
FROM dbo.HR_1
WHERE LOWER(JobRole) = 'research scientist'
  AND LOWER(Gender) = 'male'
GROUP BY JobRole, Gender;
 
 
 
 --- Attrition rate Vs Monthly income status
 SELECT
    a.Department,
    FORMAT(AVG(a.attrition_yes) * 100, 'N2') AS Attrition_Rate,
    FORMAT(AVG(b.MonthlyIncome), 'N2') AS Avg_MonthlyIncome
FROM (
    SELECT
        Department,
        EmployeeNumber,
        CASE WHEN Attrition = 1 THEN 1.0 ELSE 0.0 END AS attrition_yes
    FROM dbo.HR_1
) AS a
INNER JOIN dbo.HR_2 AS b
    ON a.EmployeeNumber = b.EmployeeID
GROUP BY a.Department
ORDER BY AVG(a.attrition_yes) DESC;
 
 --- Average working years for each Department
 SELECT hr1.Department,
       ROUND(AVG(CAST(hr2.TotalWorkingYears AS FLOAT)), 0) AS Avg_workingyears
FROM dbo.HR_1 AS hr1
INNER JOIN dbo.HR_2 AS hr2
    ON hr1.EmployeeNumber = hr2.EmployeeID
GROUP BY hr1.Department
ORDER BY Avg_workingyears DESC;
 
 --- Job Role Vs Work life balance
 
 select jobrole,avg(worklifebalance) as Avg_worklifebalance
 from
 hr_1  join hr_2 on hr_1.EmployeeNumber=hr_2.employeeid
 group by jobrole;
 
 --- Average salary of each job role 
SELECT hr1.JobRole,
       FORMAT(AVG(CAST(hr2.MonthlyIncome AS FLOAT)), 'N2') AS Avg_monthlyincome
FROM dbo.HR_1 AS hr1
JOIN dbo.HR_2 AS hr2
  ON hr1.EmployeeNumber = hr2.EmployeeID
GROUP BY hr1.JobRole
ORDER BY AVG(CAST(hr2.MonthlyIncome AS FLOAT)) DESC;
 
 --- Attrition count by Marital status
 
 select Maritalstatus,count(attrition) as Attrition_count 
 from hr_1 where attrition='yes'
 group by MaritalStatus;
 
 
 --- Average job satisfaction by department
 
SELECT Department,
       ROUND(AVG(CAST(JobSatisfaction AS FLOAT)), 2) AS Job_satisfaction
FROM dbo.HR_1
GROUP BY Department
ORDER BY Job_satisfaction DESC;
 --- Performance rating by Department
SELECT hr1.Department,
       FORMAT(AVG(CAST(hr2.PerformanceRating AS FLOAT)), 'N1') AS Avg_performancerating
FROM dbo.HR_1 AS hr1
JOIN dbo.HR_2 AS hr2
  ON hr1.EmployeeNumber = hr2.EmployeeID
GROUP BY hr1.Department
ORDER BY AVG(CAST(hr2.PerformanceRating AS FLOAT)) DESC;

 
 
 
 
 
 
 
 

