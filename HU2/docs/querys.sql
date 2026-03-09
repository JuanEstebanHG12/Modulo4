--3. Consultas básicas y manipulación:

--Listar todos los estudiantes con sus inscripciones y cursos (JOIN).
SELECT 
    s.*,
    m.major_name AS major,
    c.name AS course,
    e.enrollment_date,
    e.final_grade
FROM students s
JOIN majors m 
    ON s.major_id = m.major_id
JOIN enrollments e 
    ON s.student_id = e.student_id
JOIN courses c 
    ON e.course_id = c.course_id
ORDER BY s.full_name;

--Listar cursos dictados por docentes con > 5 años de experiencia.
SELECT 
    c.name AS course,
    t.full_name AS teacher,
    d.department_name,
    t.years_experience
FROM courses c
JOIN teachers t 
    ON c.teacher_id = t.teacher_id
JOIN departments d 
    ON t.department_id = d.department_id
WHERE t.years_experience > 5;

--Obtener promedio de calificaciones por curso (GROUP BY + AVG).
SELECT 
    c.name AS course,
    ROUND(AVG(e.final_grade),1) AS average_grade
FROM courses c
JOIN enrollments e 
    ON c.course_id = e.course_id
GROUP BY c.name
ORDER BY average_grade DESC;

--Mostrar estudiantes inscritos en más de un curso (HAVING COUNT(*) > 1)
SELECT 
    s.full_name,
    COUNT(e.course_id) AS total_courses
FROM students s
JOIN enrollments e 
    ON s.student_id = e.student_id
GROUP BY s.full_name
HAVING COUNT(e.course_id) > 1;

--ALTER TABLE: agregar columna estado_academico a estudiantes.
ALTER TABLE students
ADD COLUMN academic_status VARCHAR(20) DEFAULT 'Active';

--Eliminar un docente y observar el efecto en cursos (revisar ON DELETE en la FK).
DELETE FROM teachers
WHERE teacher_id = 3;

--Consultar cursos con más de 2 estudiantes inscritos (GROUP BY + COUNT + HAVING).
SELECT 
    c.name AS course,
    COUNT(e.student_id) AS total_students
FROM courses c
JOIN enrollments e 
    ON c.course_id = e.course_id
GROUP BY c.name
HAVING COUNT(e.student_id) > 2;

--4. Subconsultas y funciones:
--Estudiantes cuya calificación promedio sea > promedio general (AVG() + subconsulta).
SELECT 
    s.full_name AS student,
    ROUND(AVG(e.final_grade),1) AS student_avg
FROM students s
JOIN enrollments e 
    ON s.student_id = e.student_id
GROUP BY s.student_id, s.full_name
HAVING AVG(e.final_grade) > (
    SELECT AVG(final_grade) FROM enrollments
)
ORDER BY student_avg DESC;

--Nombres de carreras con estudiantes inscritos en cursos del semestre ≥ 2 (IN o EXISTS).
SELECT DISTINCT m.major_name
FROM majors m
WHERE m.major_id IN (
    SELECT s.major_id
    FROM students s
    JOIN enrollments e ON s.student_id = e.student_id
    JOIN courses c ON e.course_id = c.course_id
    WHERE c.semester >= 2
);

--Usar ROUND, SUM, MAX, MIN, COUNT para obtener indicadores.
SELECT
    ROUND(AVG(final_grade),2) AS overall_average,
    MAX(final_grade) AS highest_grade,
    MIN(final_grade) AS lowest_grade,
    SUM(final_grade) AS total_grades_sum,
    COUNT(*) AS total_grades_count
FROM enrollments;

--5. Creación de una vista:
--Crea la vista vista_historial_academico que muestre: nombre del estudiante, nombre del curso, nombre del docente, semestre y calificación final.
CREATE VIEW academic_history_view AS
SELECT
    s.full_name AS student_name,
    c.name AS course_name,
    t.full_name AS teacher_name,
    c.semester,
    e.final_grade
FROM enrollments e
JOIN students s 
    ON e.student_id = s.student_id
JOIN courses c 
    ON e.course_id = c.course_id
LEFT JOIN teachers t 
    ON c.teacher_id = t.teacher_id
ORDER BY s.full_name, c.semester;
--uso de la vista
SELECT * FROM academic_history_view;



--6. Control de acceso y transacciones:
--Otorga permisos de solo lectura a un rol revisor_academico sobre la vista (GRANT SELECT).
--crear rol
CREATE ROLE academic_reviewer;
--Garantizar permisos de solo lectura
GRANT SELECT ON academic_history_view TO academic_reviewer;



--Revoca permisos de modificación de datos en inscripciones para ese rol (REVOKE).
REVOKE INSERT, UPDATE, DELETE
ON enrollments
FROM academic_reviewer;

--Simula actualización de calificaciones usando BEGIN, SAVEPOINT, ROLLBACK y COMMIT.
-- iniciar transaccion
BEGIN;

-- Actualizar nota
UPDATE enrollments
SET final_grade = 4.8
WHERE enrollment_id = 1;

-- guardar savepoint
SAVEPOINT grade_update;

-- otra actualizacion simulando error
UPDATE enrollments
SET final_grade = 2.0
WHERE enrollment_id = 2;

-- Rollback al savepoint
ROLLBACK TO grade_update;


COMMIT;
