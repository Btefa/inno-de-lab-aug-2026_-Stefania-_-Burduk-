-- Задание было спроектировать хранилище данных(DWH) для Системы высшего образования
-- Для данной системы был определен следующий бизнес-процесс: Мониторинг успеваемости студентов
-- Для данного бизнес-процесса был определен следующий уровень детализации(grain): 
-- Студент "Бурдук С.В.", у профессора "Леванцов В.Н.", по предмету "Базы данных", сдал экзамен 20.05.2019 и получил 10
    CREATE TABLE Fact_Student_Performance (
    Fact_ID SERIAL PRIMARY KEY,
    Student_Key INT,
    Professor_Key INT,
    Subject_Key INT,
    Date_Key INT,
    AssessmentType_key INT,
    Result INT, -- оценка 0-10 (0 если не сдал)
    FOREIGN KEY (Student_Key) REFERENCES Dim_Student(Student_Key),
    FOREIGN KEY (Professor_Key) REFERENCES Dim_Professor (Professor_Key),
    FOREIGN KEY (Subject_Key) REFERENCES Dim_Subject (Subject_Key),
    FOREIGN KEY (Date_Key) REFERENCES Dim_Date (Date_Key),
    FOREIGN KEY (AssessmentType_key) REFERENCES Dim_AssessmentType (AssessmentType_key)
);

 CREATE TABLE Dim_Student (
    Student_Key SERIAL PRIMARY KEY,
    Student_ID INT,
    StudentFullName VARCHAR(100) NOT NULL, -- Бурдук С.В.
    GroupName VARCHAR(100) NOT NULL, -- АСОИ-16
    SpecialityName VARCHAR(100) NOT NULL, -- Автоматизированные системы обработки информации(АСОИ)
    AdmissionYear INT -- год поступления в университет (2016)
);

 CREATE TABLE Dim_Professor (
    Professor_Key SERIAL PRIMARY KEY,
    Professor_ID INT,
    ProfessorFullName VARCHAR(100) NOT NULL, -- Леванцов В.Н.
    FacultyName VARCHAR(100) NOT null -- Факультет физики и информационных технологий (ФИИТ)
);

 CREATE TABLE Dim_Subject (
    Subject_Key SERIAL PRIMARY KEY,
    Subject_ID INT,
    SubjectName VARCHAR(100) NOT NULL, --Базы данных
    TotalHours INT 
);

 CREATE TABLE Dim_Date ( 
    Date_Key SERIAL PRIMARY KEY,
    Date_ID INT,
    Year INT,
    Month VARCHAR(100) NOT NULL,
    Day INT
);

 CREATE TABLE Dim_AssessmentType (
    AssessmentType_key SERIAL PRIMARY KEY,
    AssessmentType_ID INT,
    Type VARCHAR(100) NOT NULL, -- экзамен/зачёт
    IsPassing BOOLEAN -- сдал/не сдал
);

-- Последнее задание: привести несколько примеров аналитических запросов, которые могут ответить на ключевые вопросы нашего бизнеса
-- 1. Общая успеваемость студентов: Какой процент студентов не сдал экзамены/зачёты в целом? (Оценка рисков)
SELECT
    COUNT(*) AS total_assessments,
    SUM(CASE WHEN Result = 0 THEN 1 ELSE 0 END) AS failed_assessments,
    ROUND(
        SUM(CASE WHEN Result = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS fail_rate_percent
FROM Fact_Student_Performance;

-- 2. Нагрузка на преподавателей: Кто из преподавателей принимает больше всего экзаменов?
SELECT
    dp.ProfessorFullName,
    COUNT(*) AS assessments_count
FROM Fact_Student_Performance fsp
JOIN Dim_Professor dp ON fsp.Professor_Key = dp.Professor_Key
GROUP BY dp.ProfessorFullName
ORDER BY assessments_count DESC;

-- 3. Рейтинг курсов: успеваемость студентов по предметам на основе среднего балла по дисциплинам
SELECT
    dsb.SubjectName,
    AVG(fsp.Result) AS avg_score
FROM Fact_Student_Performance fsp
JOIN Dim_Subject dsb ON fsp.Subject_Key = dsb.Subject_Key
GROUP BY dsb.SubjectName
ORDER BY avg_score DESC;

-- 4. Топ 10 студентов с высокими средними баллами, которых поощряют повышенной стипендией
SELECT
    ds.StudentFullName,
    ds.SpecialityName,
    ds.GroupName,
    COUNT(*) AS total_assessments,
    ROUND(AVG(fsp.Result), 2) AS avg_score
FROM Fact_Student_Performance fsp
JOIN Dim_Student ds ON fsp.Student_Key = ds.Student_Key
GROUP BY ds.StudentFullName, ds.SpecialityName, ds.GroupName
ORDER BY avg_score DESC, total_assessments DESC
LIMIT 10;