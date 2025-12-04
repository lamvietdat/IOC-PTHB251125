CREATE TABLE students (
                          id SERIAL PRIMARY KEY,
                          name VARCHAR(50),
                          age INT,
                          major VARCHAR(50),
                          gpa DECIMAL(3,2)
);

INSERT INTO students (name, age, major, gpa) VALUES
                                                 ('An', 20, 'CNTT', 3.5),
                                                 ('Binh', 21, 'Toán', 3.2),
                                                 ('Cuong', 22, 'CNTT', 3.8),
                                                 ('Duong', 20, 'Vật lý', 3.0),
                                                 ('Em', 21, 'CNTT', 2.9);

INSERT INTO students (name, age, major, gpa)
VALUES ('Huy', 23, 'CNTT', 3.6);

UPDATE students
SET gpa = 3.5
WHERE name = 'Binh';

DELETE FROM students
WHERE major = 'Vật lý';

SELECT * FROM students;

SELECT name, gpa FROM students;

SELECT * FROM students
WHERE gpa > 3.0;

SELECT * FROM students
WHERE major = 'CNTT';

SELECT DISTINCT major
FROM students;

SELECT * FROM students
WHERE name LIKE 'A%';

SELECT * FROM students
WHERE name ILIKE '%n%';

SELECT * FROM students
WHERE gpa BETWEEN 3.0 AND 3.5;

SELECT * FROM students
ORDER BY gpa DESC;

SELECT * FROM students
ORDER BY age ASC;

SELECT * FROM students
LIMIT 3;

SELECT * FROM students
OFFSET 2 LIMIT 3;
