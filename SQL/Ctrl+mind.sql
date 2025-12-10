-- 0?? ??? ?? ????? ?????? ????? ???????
DROP TABLE IF EXISTS Fact_Survey;
DROP TABLE IF EXISTS Dim_Employee;
DROP TABLE IF EXISTS Dim_Company;
DROP TABLE IF EXISTS Dim_Location;
DROP TABLE IF EXISTS Dim_MentalHealth;
DROP TABLE IF EXISTS dbo.MentalHealthSurvey;

-- 1?? ????? ???? ??????? ??????
CREATE TABLE dbo.MentalHealthSurvey (
    Employee_ID NVARCHAR(50) NULL,
    Network_ID NVARCHAR(50) NULL,
    Duration_minutes NVARCHAR(50) NULL,
    Survey_Year NVARCHAR(50) NULL,
    US_State_live NVARCHAR(50) NULL,
    US_State_work NVARCHAR(50) NULL,
    Country_Live NVARCHAR(50) NULL,
    Country_Work NVARCHAR(50) NULL,
    Are_You_Freelancer NVARCHAR(10) NULL,
    Tech_Company NVARCHAR(10) NULL,
    Age NVARCHAR(50) NULL,
    Race NVARCHAR(50) NULL,
    Tech_Employee NVARCHAR(10) NULL,
    Gender NVARCHAR(20) NULL,
    Company_Employees NVARCHAR(50) NULL,
    Residence_far_from_Work NVARCHAR(10) NULL,
    Is_Expatriate NVARCHAR(10) NULL,
    Tech_Worker_in_Tech_Company NVARCHAR(10) NULL,
    Company_Size_Category NVARCHAR(50) NULL,
    Current_MH_Disorder NVARCHAR(10) NULL,
    Ever_Diagnosed_MH NVARCHAR(10) NULL,
    Family_History_MH NVARCHAR(50) NULL,
    Sought_Treatment_MH NVARCHAR(10) NULL,
    Previous_Employers NVARCHAR(10) NULL,
    Previous_Employer_MH_Benefits NVARCHAR(10) NULL,
    Discussed_MH_with_Previous_Employer NVARCHAR(10) NULL,
    Previous_Employer_Formal_MH NVARCHAR(10) NULL,
    Comfort_Talking_Previous_Employer NVARCHAR(50) NULL,
    Anonymity_Protected_Previous NVARCHAR(10) NULL,
    Previous_MH_Importance NVARCHAR(50) NULL,
    Previous_PH_Importance NVARCHAR(50) NULL,
    Overall_MH_Importance_Score NVARCHAR(50) NULL,
    Overall_PH_Importance_Score NVARCHAR(50) NULL,
    Employer_Provide_MH_Benefits NVARCHAR(50) NULL,
    Aware_of_MH_Options NVARCHAR(10) NULL,
    Employer_Formal_MH_Discussion NVARCHAR(50) NULL,
    Employer_MH_Importance NVARCHAR(50) NULL,
    Employer_PH_Importance NVARCHAR(50) NULL,
    Anonymity_Protected_Employer NVARCHAR(255) NULL,
    Employer_MH_Benefits_Score NVARCHAR(50) NULL,
    Willing_to_Talk_Extensively NVARCHAR(10) NULL,
    Bring_up_MH_in_Interview NVARCHAR(10) NULL,
    Bring_up_PH_in_Interview NVARCHAR(10) NULL,
    Comfort_Talking_Coworkers NVARCHAR(50) NULL,
    Willing_to_Share_Friends_Family NVARCHAR(10) NULL,
    Comfort_Discussing_With_Supervisor NVARCHAR(10) NULL,
    Discuss_MH_with_Coworkers NVARCHAR(10) NULL,
    Employee_Courage_Disclosing_MH NVARCHAR(10) NULL,
    Employee_Courage_Discussing_PH NVARCHAR(10) NULL,
    MH_Issues_Impact_Relations NVARCHAR(255) NULL,
    Managers_Reactions NVARCHAR(255) NULL,
    Badly_Handled_Response NVARCHAR(10) NULL,
    Observations_Impact NVARCHAR(10) NULL,
    Productivity_Affected NVARCHAR(10) NULL,
    Career_Impact NVARCHAR(255) NULL,
    Request_Medical_Leave_Difficulty NVARCHAR(50) NULL,
    Know_Local_Online_Resources NVARCHAR(50) NULL
);

-- 2?? BULK INSERT
BULK INSERT dbo.MentalHealthSurvey
FROM 'D:\DEPI\GP Final Submisations\Data Sets\Last Submissions\merged_df_Lasttt_CSV.csv'
WITH
(
    FORMAT = 'CSV',
    FIRSTROW = 2,
    CODEPAGE = '65001',
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    KEEPNULLS
);

-- 3?? ????? Dimensions

-- ???? ????????
CREATE TABLE Dim_Employee (
    Employee_ID NVARCHAR(50) PRIMARY KEY,
    Age INT NULL,
    Gender NVARCHAR(20) NULL,
    Race NVARCHAR(50) NULL,
    Tech_Employee NVARCHAR(10) NULL,
    Tech_Company NVARCHAR(10) NULL,
    Residence_far_from_Work NVARCHAR(10) NULL,
    Is_Expatriate NVARCHAR(10) NULL,
    Company_Size_Category NVARCHAR(50) NULL
);

-- ???? ???????
CREATE TABLE Dim_Company (
    Company_ID INT IDENTITY(1,1) PRIMARY KEY,
    Company_Name NVARCHAR(255) NULL,
    Company_Employees NVARCHAR(50) NULL
);

-- ???? ???????
CREATE TABLE Dim_Location (
    Location_ID INT IDENTITY(1,1) PRIMARY KEY,
    US_State_Live NVARCHAR(50) NULL,
    US_State_Work NVARCHAR(50) NULL,
    Country_Live NVARCHAR(50) NULL,
    Country_Work NVARCHAR(50) NULL
);

-- ???? ????? ??????? / ????????
CREATE TABLE Dim_MentalHealth (
    MH_ID INT IDENTITY(1,1) PRIMARY KEY,
    Current_MH_Disorder NVARCHAR(10) NULL,
    Ever_Diagnosed_MH NVARCHAR(10) NULL,
    Family_History_MH NVARCHAR(50) NULL,
    Sought_Treatment_MH NVARCHAR(10) NULL,
    Comfort_Talking_Previous_Employer NVARCHAR(50) NULL,
    Anonymity_Protected_Previous NVARCHAR(10) NULL,
    Managers_Reactions NVARCHAR(255) NULL,
    Career_Impact NVARCHAR(255) NULL,
    Request_Medical_Leave_Difficulty NVARCHAR(50) NULL,
    Know_Local_Online_Resources NVARCHAR(50) NULL
);

-- 4?? ????? Fact Table
CREATE TABLE Fact_Survey (
    Survey_ID INT IDENTITY(1,1) PRIMARY KEY,
    Employee_ID NVARCHAR(50) NOT NULL,
    Company_ID INT NULL,
    Location_ID INT NULL,
    MH_ID INT NULL,
    Duration_minutes INT NULL,
    Survey_Year INT NULL,
    Previous_Employer_MH_Benefits NVARCHAR(10) NULL,
    Discussed_MH_with_Previous_Employer NVARCHAR(10) NULL,
    Previous_Employer_Formal_MH NVARCHAR(10) NULL,
    Anonymity_Protected_Employer NVARCHAR(255) NULL,
    Previous_MH_Importance NVARCHAR(50) NULL,
    Previous_PH_Importance NVARCHAR(50) NULL,
    Overall_MH_Importance_Score NVARCHAR(50) NULL,
    Overall_PH_Importance_Score NVARCHAR(50) NULL,
    Employer_Provide_MH_Benefits NVARCHAR(50) NULL,
    Aware_of_MH_Options NVARCHAR(10) NULL,
    Employer_Formal_MH_Discussion NVARCHAR(50) NULL,
    Employer_MH_Importance NVARCHAR(50) NULL,
    Employer_PH_Importance NVARCHAR(50) NULL,
    Employer_MH_Benefits_Score NVARCHAR(50) NULL,
    Willing_to_Talk_Extensively NVARCHAR(10) NULL,
    Bring_up_MH_in_Interview NVARCHAR(10) NULL,
    Bring_up_PH_in_Interview NVARCHAR(10) NULL,
    Comfort_Talking_Coworkers NVARCHAR(50) NULL,
    Willing_to_Share_Friends_Family NVARCHAR(10) NULL,
    Comfort_Discussing_With_Supervisor NVARCHAR(10) NULL,
    Discuss_MH_with_Coworkers NVARCHAR(10) NULL,
    Employee_Courage_Disclosing_MH NVARCHAR(10) NULL,
    Employee_Courage_Discussing_PH NVARCHAR(10) NULL,
    MH_Issues_Impact_Relations NVARCHAR(255) NULL,
    Badly_Handled_Response NVARCHAR(10) NULL,
    Observations_Impact NVARCHAR(10) NULL,

    FOREIGN KEY (Employee_ID) REFERENCES Dim_Employee(Employee_ID),
    FOREIGN KEY (Company_ID) REFERENCES Dim_Company(Company_ID),
    FOREIGN KEY (Location_ID) REFERENCES Dim_Location(Location_ID),
    FOREIGN KEY (MH_ID) REFERENCES Dim_MentalHealth(MH_ID)
);

--Enter Data
INSERT INTO Dim_Employee (Employee_ID, Age, Gender, Race, Tech_Employee, Tech_Company, Residence_far_from_Work, Is_Expatriate, Company_Size_Category)
SELECT DISTINCT 
    Employee_ID, 
    TRY_CAST(Age AS INT),
    Gender,
    Race,
    Tech_Employee,
    Tech_Company,
    Residence_far_from_Work,
    Is_Expatriate,
    Company_Size_Category
FROM dbo.MentalHealthSurvey
WHERE Employee_ID IS NOT NULL;

--Dim_Company
INSERT INTO Dim_Company (Company_Name, Company_Employees)
SELECT DISTINCT
    Tech_Company AS Company_Name,
    Company_Employees
FROM dbo.MentalHealthSurvey
WHERE Tech_Company IS NOT NULL;


--Dim_Location
INSERT INTO Dim_Location (US_State_Live, US_State_Work, Country_Live, Country_Work)
SELECT DISTINCT
    US_State_Live,
    US_State_work,
    Country_Live,
    Country_Work
FROM dbo.MentalHealthSurvey;


--Dim_MentalHealth
INSERT INTO Dim_MentalHealth (Current_MH_Disorder, Ever_Diagnosed_MH, Family_History_MH, Sought_Treatment_MH,
                              Comfort_Talking_Previous_Employer, Anonymity_Protected_Previous, Managers_Reactions,
                              Career_Impact, Request_Medical_Leave_Difficulty, Know_Local_Online_Resources)
SELECT DISTINCT
    Current_MH_Disorder,
    Ever_Diagnosed_MH,
    Family_History_MH,
    Sought_Treatment_MH,
    Comfort_Talking_Previous_Employer,
    Anonymity_Protected_Previous,
    Managers_Reactions,
    Career_Impact,
    Request_Medical_Leave_Difficulty,
    Know_Local_Online_Resources
FROM dbo.MentalHealthSurvey;


--Fact_Survey
INSERT INTO Fact_Survey (Employee_ID, Company_ID, Location_ID, MH_ID, Duration_minutes, Survey_Year,
                         Previous_Employer_MH_Benefits, Discussed_MH_with_Previous_Employer, Previous_Employer_Formal_MH,
                         Anonymity_Protected_Employer, Previous_MH_Importance, Previous_PH_Importance, Overall_MH_Importance_Score,
                         Overall_PH_Importance_Score, Employer_Provide_MH_Benefits, Aware_of_MH_Options, Employer_Formal_MH_Discussion,
                         Employer_MH_Importance, Employer_PH_Importance, Employer_MH_Benefits_Score, Willing_to_Talk_Extensively,
                         Bring_up_MH_in_Interview, Bring_up_PH_in_Interview, Comfort_Talking_Coworkers, Willing_to_Share_Friends_Family,
                         Comfort_Discussing_With_Supervisor, Discuss_MH_with_Coworkers, Employee_Courage_Disclosing_MH,
                         Employee_Courage_Discussing_PH, MH_Issues_Impact_Relations, Badly_Handled_Response, Observations_Impact)
SELECT
    e.Employee_ID,
    c.Company_ID,
    l.Location_ID,
    m.MH_ID,
    TRY_CAST(Duration_minutes AS INT),
    TRY_CAST(Survey_Year AS INT),
    Previous_Employer_MH_Benefits,
    Discussed_MH_with_Previous_Employer,
    Previous_Employer_Formal_MH,
    Anonymity_Protected_Employer,
    Previous_MH_Importance,
    Previous_PH_Importance,
    Overall_MH_Importance_Score,
    Overall_PH_Importance_Score,
    Employer_Provide_MH_Benefits,
    Aware_of_MH_Options,
    Employer_Formal_MH_Discussion,
    Employer_MH_Importance,
    Employer_PH_Importance,
    Employer_MH_Benefits_Score,
    Willing_to_Talk_Extensively,
    Bring_up_MH_in_Interview,
    Bring_up_PH_in_Interview,
    Comfort_Talking_Coworkers,
    Willing_to_Share_Friends_Family,
    Comfort_Discussing_With_Supervisor,
    Discuss_MH_with_Coworkers,
    Employee_Courage_Disclosing_MH,
    Employee_Courage_Discussing_PH,
    MH_Issues_Impact_Relations,
    Badly_Handled_Response,
    Observations_Impact
FROM dbo.MentalHealthSurvey s
JOIN Dim_Employee e ON s.Employee_ID = e.Employee_ID
JOIN Dim_Company c ON s.Tech_Company = c.Company_Name
JOIN Dim_Location l ON s.US_State_Live = l.US_State_Live AND s.US_State_work = l.US_State_Work AND s.Country_Live = l.Country_Live AND s.Country_Work = l.Country_Work
JOIN Dim_MentalHealth m 
    ON s.Current_MH_Disorder = m.Current_MH_Disorder 
    AND s.Ever_Diagnosed_MH = m.Ever_Diagnosed_MH
    AND s.Family_History_MH = m.Family_History_MH;



--How many workers were included in the study
SELECT COUNT(DISTINCT Employee_ID) AS Total_Workers
FROM Fact_Survey;

--How many of them work in the Technology Field
SELECT COUNT(DISTINCT e.Employee_ID) AS Tech_Workers
FROM Dim_Employee e
JOIN Fact_Survey f ON e.Employee_ID = f.Employee_ID
WHERE e.Tech_Employee = 1;

--How many work in Non-Technical Fields
SELECT COUNT(DISTINCT e.Employee_ID) AS NonTech_Workers
FROM Dim_Employee e
JOIN Fact_Survey f ON e.Employee_ID = f.Employee_ID
WHERE e.Tech_Employee = 0;

--How many workers suffer from MH Disorder in Technical vs Non-Tech fields
SELECT 
    e.Tech_Employee,
    COUNT(DISTINCT f.Employee_ID) AS Workers_with_MH
FROM Dim_Employee e
JOIN Fact_Survey f ON e.Employee_ID = f.Employee_ID
JOIN Dim_MentalHealth m ON f.MH_ID = m.MH_ID
WHERE m.Current_MH_Disorder = 'Yes'
GROUP BY e.Tech_Employee;

--Among workers in tech field, how many currently suffer from MH Disorder
SELECT COUNT(DISTINCT f.Employee_ID) AS Tech_Workers_with_MH
FROM Dim_Employee e
JOIN Fact_Survey f ON e.Employee_ID = f.Employee_ID
JOIN Dim_MentalHealth m ON f.MH_ID = m.MH_ID
WHERE e.Tech_Employee = 'Yes' AND m.Current_MH_Disorder = 'Yes';

--Which genders suffer more?
SELECT e.Gender, COUNT(DISTINCT f.Employee_ID) AS Workers_with_MH
FROM Dim_Employee e
JOIN Fact_Survey f ON e.Employee_ID = f.Employee_ID
JOIN Dim_MentalHealth m ON f.MH_ID = m.MH_ID
WHERE m.Current_MH_Disorder = 'Yes'
GROUP BY e.Gender
ORDER BY Workers_with_MH DESC;


--Which age group suffers the most
SELECT 
    CASE 
        WHEN e.Age BETWEEN 18 AND 25 THEN '18-25'
        WHEN e.Age BETWEEN 26 AND 35 THEN '26-35'
        WHEN e.Age BETWEEN 36 AND 45 THEN '36-45'
        WHEN e.Age BETWEEN 46 AND 60 THEN '46-60'
        ELSE '60+' 
    END AS Age_Group,
    COUNT(DISTINCT f.Employee_ID) AS Workers_with_MH
FROM Dim_Employee e
JOIN Fact_Survey f ON e.Employee_ID = f.Employee_ID
JOIN Dim_MentalHealth m ON f.MH_ID = m.MH_ID
WHERE m.Current_MH_Disorder = 'Yes'
GROUP BY 
    CASE 
        WHEN e.Age BETWEEN 18 AND 25 THEN '18-25'
        WHEN e.Age BETWEEN 26 AND 35 THEN '26-35'
        WHEN e.Age BETWEEN 36 AND 45 THEN '36-45'
        WHEN e.Age BETWEEN 46 AND 60 THEN '46-60'
        ELSE '60+' 
    END
ORDER BY Workers_with_MH DESC;


--Percentage of cases per year
SELECT 
    f.Survey_Year,
    COUNT(DISTINCT f.Employee_ID) AS Workers_with_MH,
    CAST(COUNT(DISTINCT f.Employee_ID) * 100.0 / (SELECT COUNT(DISTINCT Employee_ID) FROM Fact_Survey) AS DECIMAL(5,2)) AS Percentage
FROM Fact_Survey f
JOIN Dim_MentalHealth m ON f.MH_ID = m.MH_ID
WHERE m.Current_MH_Disorder = 'Yes'
GROUP BY f.Survey_Year
ORDER BY f.Survey_Year;





