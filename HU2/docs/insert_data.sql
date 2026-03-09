--inserts
--departments
INSERT INTO departments (department_name)
VALUES
('Engineering'),
('Business'),
('Technology');
--majors
INSERT INTO majors (major_name)
VALUES
('Systems Engineering'),
('Industrial Engineering'),
('Business Administration'),
('Accounting');
--students
INSERT INTO students
(full_name, email, gender, identification, major_id, birth_date, admission_date)
VALUES
('Laura Gomez','laura@email.com','Female','1001',1,'2002-04-10','2022-01-15'),
('Carlos Perez','carlos@email.com','Male','1002',2,'2001-09-12','2021-02-10'),
('Ana Martinez','ana@email.com','Female','1003',3,'2000-06-18','2020-02-15'),
('David Rodriguez','david@email.com','Male','1004',1,'2003-01-25','2023-01-20'),
('Sofia Torres','sofia@email.com','Female','1005',4,'2002-11-02','2022-07-12');
--teachers
INSERT INTO teachers
(full_name, institutional_email, department_id, years_experience)
VALUES
('Dr. Juan Ramirez','juan.ramirez@university.edu',1,10),
('Dr. Patricia Lopez','patricia.lopez@university.edu',2,7),
('Eng. Andres Molina','andres.molina@university.edu',3,3);
--courses
INSERT INTO courses
(name, code, credits, semester, teacher_id)
VALUES
('Database Systems','DB101',3,2,1),
('Programming Fundamentals','PRG201',4,1,1),
('Business Management','BUS110',3,2,2),
('Statistics','STAT200',3,3,3);
--enrollments
INSERT INTO enrollments
(student_id, course_id, enrollment_date, final_grade)
VALUES
(1,1,'2024-02-01',4.5),
(1,2,'2024-02-01',4.0),
(2,1,'2024-02-02',3.8),
(2,3,'2024-02-02',4.2),
(3,3,'2024-02-03',4.6),
(4,2,'2024-02-04',3.5),
(4,1,'2024-02-04',3.9),
(5,4,'2024-02-05',4.1);

