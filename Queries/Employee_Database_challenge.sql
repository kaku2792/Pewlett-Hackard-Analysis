CREATE TABLE employees (   
	emp_no INT NOT NULL,
     birth_date DATE NOT NULL,
     first_name VARCHAR NOT NULL,
     last_name VARCHAR NOT NULL,
     gender VARCHAR NOT NULL,
     hire_date DATE NOT NULL,
     PRIMARY KEY (emp_no)
);

-- Creating tables for PH-EmployeeDB
CREATE TABLE departments (
     dept_no VARCHAR(4) NOT NULL,
     dept_name VARCHAR(40) NOT NULL,
     PRIMARY KEY (dept_no),
     UNIQUE (dept_name)
);

CREATE TABLE dept_manager (
dept_no VARCHAR(4) NOT NULL,
    emp_no INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE salaries (
  emp_no INT NOT NULL,
  salary INT NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  PRIMARY KEY (emp_no)
);

Create Table dept_emp (
emp_no INT NOT Null,
dept_no varchar NOT NULL,
from_date Date NOT NULL,
to_date Date Not NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no)
);

Create Table Titles (
emp_no INT NOT NULL,
title varchar NOT NULL,
from_date date NOT NULL,
to_date date,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
PRIMARY KEY (emp_no, title, from_date)
);

--Deliverabe 1: filter retiring employees with titles part 1
SELECT e.emp_no, e.first_name, e.last_name, t.title, t.from_date, t.to_date
INTO retirement_titles
FROM employees as e
JOIN titles as t USING(emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY (e.emp_no);

-- Deliverabe 1: Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no, rt.first_name, rt.last_name, rt.title, rt.from_date, rt.to_date
INTO unique_titles
FROM retirement_titles as rt
where rt.to_date = '9999-01-01'
ORDER BY rt.emp_no, rt.to_date DESC;

-- Deliverabe 1 count title
Select Count(emp_no), title
From unique_titles
GROUP BY title
ORDER BY count(emp_no) Desc;


-- Deliverable 2: get eligible employees for mentorship program
SELECT DISTINCT ON (emp_no) emp_no, first_name, last_name, birth_date, de.from_date, de.to_date, t.title
--INTO mentorship_eligiablity
FROM employees AS e
JOIN dept_emp AS de USING(emp_no)
JOIN titles AS t USING(emp_no)
WHERE birth_date BETWEEN '1965-01-01' AND '1965-12-31'AND de.to_date = '9999/01/01'
ORDER BY emp_no;


