CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(10),
    email VARCHAR(10),
    password VARCHAR(50)
);

CREATE TABLE aspirants (
    id SERIAL PRIMARY KEY,
    name VARCHAR(10),
    email VARCHAR(10),
    department TEXT,
    score DECIMAL(5,2) CHECK (score >= 0 AND score <= 100)
)

CREATE TABLE departments (
    id SERIAL PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    department_id INT REFERENCES departments(id) ON DELETE SET NULL
);

CREATE TABLE courses (
    id SERIAL PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    student_id INT REFERENCES students(id) ON DELETE CASCADE,
    score DECIMAL(5,2) CHECK (score >= 0 AND score <= 100)
);