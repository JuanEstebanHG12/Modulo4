CREATE TABLE IF NOT EXISTS "departments" (
	"department_id" SERIAL,
	"department_name" VARCHAR(100) NOT NULL UNIQUE,
	PRIMARY KEY("department_id")
);




CREATE TABLE IF NOT EXISTS "majors" (
	"major_id" SERIAL,
	"major_name" VARCHAR(100) NOT NULL UNIQUE,
	PRIMARY KEY("major_id")
);




CREATE TABLE IF NOT EXISTS "students" (
	"student_id" SERIAL,
	"full_name" VARCHAR(100) NOT NULL,
	"email" VARCHAR(100) NOT NULL UNIQUE,
	"gender" VARCHAR(20) CHECK (gender IN ('Male','Female','Other')),
	"identification" VARCHAR(20) NOT NULL UNIQUE,
	"major_id" INTEGER,
	"birth_date" DATE NOT NULL,
	"admission_date" DATE NOT NULL,
	PRIMARY KEY("student_id"),
	FOREIGN KEY (major_id)
        REFERENCES majors(major_id)
);




CREATE TABLE IF NOT EXISTS "teachers" (
	"teacher_id" SERIAL,
	"full_name" VARCHAR(100) NOT NULL,
	"institutional_email" VARCHAR(100) NOT NULL UNIQUE,
	"department_id" INTEGER,
	"years_experience" INTEGER CHECK(years_experience >= 0),
	PRIMARY KEY("teacher_id"),
	FOREIGN KEY (department_id)
        REFERENCES departments(department_id)
);




CREATE TABLE IF NOT EXISTS "courses" (
	"course_id" SERIAL,
	"name" VARCHAR(100) NOT NULL,
	"code" VARCHAR(20) NOT NULL UNIQUE,
	"credits" INTEGER NOT NULL CHECK(credits > 0),
	"semester" INTEGER NOT NULL CHECK(semester >= 1),
	"teacher_id" INTEGER,
	PRIMARY KEY("course_id"),
	FOREIGN KEY (teacher_id)
        REFERENCES teachers(teacher_id)
        ON DELETE SET NULL
);




CREATE TABLE IF NOT EXISTS "enrollments" (
	"enrollment_id" SERIAL,
	"student_id" INTEGER NOT NULL,
	"course_id" INTEGER NOT NULL,
	"enrollment_date" DATE NOT NULL,
	"final_grade" NUMERIC(3,2) CHECK(final_grade BETWEEN 0 AND 5),
	PRIMARY KEY("enrollment_id"),
	FOREIGN KEY (student_id)
        REFERENCES students(student_id)
        ON DELETE CASCADE,

    FOREIGN KEY (course_id)
        REFERENCES courses(course_id)
        ON DELETE CASCADE
);
