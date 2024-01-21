create table Departments(
	id serial primary key,
	Financing decimal (10, 2) not NULL default 0 check(Financing >= 0),
	name varchar(100) unique not NULL
);

INSERT INTO Departments (Financing, name) VALUES
  (150000.50, 'Finance Department'),
  (120000.75, 'Human Resources Department'),
  (80000.00, 'Marketing Department'),
  (200000.25, 'IT Department'),
  (50000.00, 'Operations Department');
  
 ---------------------------------------------------------------
 create table Faculties(
	id serial primary key,
	Dean varchar(255) not NULL,
	name varchar(100) unique not NULL
);

INSERT INTO Faculties (Dean, name) VALUES
    ('John Doe', 'Engineering Faculty'),
    ('Jane Smith', 'Science Faculty'),
    ('Bob Johnson', 'Business Faculty'),
    ('Alice Williams', 'Arts Faculty'),
    ('Michael Brown', 'Health Sciences Faculty');
	
------------------------------------------------------
 create table Groups(
	id serial primary key,
	Rating integer not NULL check(Rating >= 0 and Rating <= 5),
	name varchar(10) unique not NULL,
	Year integer not NULL check(Year >= 1 and Year <= 5)
);

INSERT INTO Groups (Rating, name, Year) VALUES
    (4, 'GroupA', 2),
    (3, 'GroupB', 1),
    (5, 'GroupC', 3),
    (2, 'GroupD', 4),
    (1, 'GroupE', 5);
  
 ----------------------------------------------------------------------------------
CREATE TABLE Teachers (
    id serial PRIMARY KEY,
    EmploymentDate date NOT NULL CHECK (EmploymentDate >= '1990-01-01'),
    IsAssistant bit NOT NULL DEFAULT B'0',
    IsProfessor bit NOT NULL DEFAULT B'0',
    Name text NOT NULL CHECK (Name <> ''),
    Position text NOT NULL CHECK (Position <> ''),
    Premium decimal(10, 2) NOT NULL DEFAULT 0 CHECK (Premium >= 0),
    Salary decimal(10, 2) NOT NULL CHECK (Salary > 0),
    Surname text NOT NULL CHECK (Surname <> '')
);

INSERT INTO Teachers (EmploymentDate, IsAssistant, IsProfessor, Name, Position, Premium, Salary, Surname) VALUES
    ('1995-03-15', B'1', B'0', 'Іван', 'Асистент', 5000.00, 60000.00, 'Петров'),
    ('2000-08-22', B'0', B'1', 'Олена', 'Професор', 7000.50, 80000.00, 'Іванова'),
    ('1998-06-10', B'1', B'0', 'Марія', 'Асистент', 4500.75, 55000.00, 'Сидорова'),
    ('2005-12-03', B'0', B'1', 'Петро', 'Професор', 8000.00, 90000.00, 'Коваль');
	
	
	
-------------------------------------------------------------------------------
--1. Вивести таблицю кафедр, але розташувати її поля у зворотному порядку.
select name, financing, id from departments;

--2. Вивести назви груп та їх рейтинги з уточненнями до назв полів відповідно до назви таблиці.
select name as "Name of group", rating as "Rating of group" from groups;

--3. Вивести для викладачів їх прізвища, відсоток ставки по 
--відношенню до надбавки та відсоток ставки по відношенню до зарплати (сума ставки та надбавки).

select surname,
premium * 100 / (premium + salary) as "Відсоток ставки до надбавки",
salary * 100 / (premium + salary) as "Відсоток ставки до зарплати"
from teachers

--4. Вивести таблицю факультетів одним полем у такому форматі: «The dean of faculty [faculty] is [dean].».
select 'The dean of faculty ' || name || ' is ' || dean as result from faculties

--5. Вивести прізвища професорів, ставка яких перевищує 1050.
select surname, salary from teachers where salary > 1050

--6. Вивести назви кафедр, фонд фінансування яких менший, ніж 11000 або більший за 25000.
select name from departments where financing < 11000 or financing > 25000 

--7. Вивести назви факультетів, окрім факультету «Computer Science».
select name from departments where name != 'Computer Science'

--8. Вивести прізвища та посади викладачів, які не є професорами
select surname, position from teachers where isprofessor = '0'

--9. Вивести прізвища, посади, ставки та надбавки асистентів,надбавка яких у діапазоні від 160 до 550.
select surname, position, salary, premium from teachers
where isprofessor = '0' and premium between 1600 and 5500

--10. Вивести прізвища та ставки асистентів
select surname, salary from teachers
where isprofessor = '0'

--11. Вивести прізвища та посади викладачів, які були прийняті на роботу до 01.01.2000.
select surname, position from teachers
where employmentdate < '01-01-2000'

--12. Вивести назви кафедр, які в алфавітному порядку розміщені до кафедри «Software Development». 
--Виведене поле назвіть «Name of Department»
SELECT name AS "Name of Department"
FROM Departments
WHERE name < 'Software Development'
ORDER BY name;

--13. Вивести прізвища асистентів із зарплатою (сума ставки та надбавки) не більше 1200.

select surname from teachers
where isprofessor = '0'and salary + premium <= 1200

--14. Вивести назви груп 5-го курсу з рейтингом у діапазоні від 2 до 4

select name from groups
where year = 5 and rating between 2 and 4

--15. Вивести прізвища асистентів зі ставкою менше, ніж 550 або надбавкою менше, ніж 200.
select surname from teachers
where isprofessor = '0'and (salary < 550 or premium < 200)
 