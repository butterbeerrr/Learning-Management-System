CREATE DATABASE lms_db; 

USE lms_db; 


CREATE TABLE users(
    id INT AUTO_INCREMENT PRIMARY KEY, 
    full_name VARCHAR(100) NOT NULL, 
    email VARCHAR (100) UNIQUE NOT NULL,
    role ENUM('student', 'mentor') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE course_categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);

CREATE TABLE courses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    description TEXT,
    price INT NOT NULL,
    quota INT DEFAULT 0,

    category_id INT,
    mentor_id INT,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (category_id)
    REFERENCES course_categories(id),

    FOREIGN KEY (mentor_id)
    REFERENCES users(id)
);

CREATE TABLE enrollments (
    id INT AUTO_INCREMENT PRIMARY KEY,

    user_id INT,
    course_id INT,

    enroll_date DATE,

    FOREIGN KEY (user_id)
    REFERENCES users(id),

    FOREIGN KEY (course_id)
    REFERENCES courses(id)
);

INSERT INTO course_categories (category_name)
VALUES
('Web Development'),
('UI UX Design'),
('Data Science'),
('Cyber Security'),
('Mobile Development');

INSERT INTO users (full_name, email, role)
VALUES
('Osudhi dhuv', 'dhuv@gmail.com', 'mentor'),
('samsut sung', 'sung@gmail.com', 'mentor'),
('stanley bottle', 'stanley@gmail.com', 'student'),
('nivea lotion', 'nivea@gmail.com', 'student'),
('bird twt', 'twt@gmail.com', 'student'),
('Fajar Sadboy', 'sadboy@gmail.com', 'student'),
('chen tingting', 'tingting@gmail.com', 'student'),
('corkcicle exp', 'exp@gmail.com', 'student'),
('hanabi veren', 'veren@gmail.com', 'student'),
('wiko babat', 'babat@gmail.com', 'student');

INSERT INTO courses
(title, description, price, quota, category_id, mentor_id)
VALUES
('HTML Basic', 'Learn HTML from scratch', 50000, 20, 1, 1),

('CSS', 'Advanced CSS course', 75000, 15, 1, 1),

('JavaScript Beginner', 'Introduction to JavaScript', 100000, 25, 1, 2),

('UI Design Fundamentals', 'Basic UI Design', 150000, 10, 2, 2),

('UX Research', 'Learn UX Research', 175000, 8, 2, 2),

('Python for Data Science', 'Python Data Science course', 250000, 30, 3, 1),

('Machine Learning Intro', 'Basic machine learning', 350000, 12, 3, 1),

('Cyber Security Basic', 'Security fundamentals', 500000, 18, 4, 2),

('Ethical Hacking', 'Introduction to ethical hacking', 650000, 5, 4, 2),

('Android Development', 'Build Android apps', 300000, 10, 5, 1);

INSERT INTO enrollments
(user_id, course_id, enroll_date)
VALUES
(3, 1, '2025-05-01'),
(3, 2, '2025-05-02'),
(4, 3, '2025-05-03'),
(5, 4, '2025-05-04'),
(6, 5, '2025-05-05'),
(7, 6, '2025-05-06'),
(8, 7, '2025-05-07'),
(9, 8, '2025-05-08'),
(10, 9, '2025-05-09'),
(4, 10, '2025-05-10');

-- Seluruh data course
SELECT * FROM courses;

-- Tampilkan nama course dan harga saja.
SELECT title, price FROM courses;

-- Tampilkan course dengan harga antara 50.000 sampai 200.000.
SELECT * FROM courses
WHERE price BETWEEN 50000 AND 200000;

-- Tampilkan course yang memiliki kuota 0 ATAU harga di atas 500.000.
SELECT * FROM courses
WHERE quota = 0 OR price > 500000;

-- Tampilkan 5 course dengan harga tertinggi.
SELECT * FROM courses
ORDER BY price DESC
LIMIT 5;

-- Hitung total user yang terdaftar.
SELECT COUNT(*) AS total_users
FROM users;

-- Hitung total course yang tersedia
SELECT COUNT(*) AS total_course
FROM courses;

-- Hitung jumlah course per kategori
SELECT category_id, COUNT(*) AS total_course
FROM courses
GROUP BY category_id;

-- Hitung rata-rata harga course per kategori
SELECT category_id, AVG(price) AS average_price
FROM courses
GROUP BY category_id;

--Tampilkan kategori yang memiliki lebih dari 3 course
SELECT category_id, COUNT(*) AS total_course
FROM courses
GROUP BY category_id
HAVING COUNT(*) > 3;

--Tampilkan daftar course beserta nama kategorinya
SELECT c.title, cc.category_name
FROM courses c
INNER JOIN course_categories cc
ON c.category_id = cc.id;

-- Tampilkan semua kategori meskipun belum memiliki course
SELECT cc.category_name, c.title
FROM course_categories cc
LEFT JOIN courses c
ON cc.id = c.category_id;

-- Tampilkan semua user meskipun belum pernah mengupload course
SELECT u.full_name, c.title
FROM users u 
LEFT JOIN courses c
ON u.id = c.mentor_id;

-- Tampilkan daftar course beserta nama instructor yang membuat course tersebut
SELECT c.title, u.full_name AS mentor_name 
FROM courses c
LEFT JOIN users u
ON c.mentor_id = u.id ;
  
-- Tampilkan jumlah course yang dibuat oleh masing-masing instructor
SELECT u.full_name AS mentor_name, COUNT(c.id) AS total_course
FROM users u
LEFT JOIN courses c
ON u.id = c.mentor_id
GROUP BY u.full_name;