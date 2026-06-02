--Creating the table employee
CREATE TABLE employee(
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    birthday DATE,
    sex VARCHAR(1),
    salary INT,
    super_id INT,
    FOREIGN KEY(super_id) REFERENCES employee(employee_id)

);

--Viewing the table employee
SELECT * FROM employee;

--Creating the table branch
CREATE TABLE branch(
    branch_id INT PRIMARY KEY,
    branch_name VARCHAR(50),
    mgr_id INT,
    start_date DATE,
    FOREIGN KEY (mgr_id) REFERENCES employee(employee_id)
);

--Viewing the table branch
SELECT * FROM branch;

--Altering the table employee to add the branch_id column after creating the table branch
ALTER TABLE employee ADD COLUMN branch_id INT;

--Altering the table employee to declare the new branch_id column as a foreign key
ALTER TABLE employee ADD FOREIGN KEY(branch_id) REFERENCES branch(branch_id);

--Creating the table client
CREATE TABLE client(
    client_id INT PRIMARY KEY,
    client_name VARCHAR(50),
    branch_id INT,
    FOREIGN KEY(branch_id) REFERENCES branch(branch_id)
);

--Viewing the table client
SELECT * FROM client;

--Creating the table supplier
CREATE TABLE supplier(
    branch_id INT,
    supplier_name VARCHAR(50),
    supply_type VARCHAR(50),
    FOREIGN KEY(branch_id) REFERENCES branch(branch_id),
    PRIMARY KEY(branch_id,supplier_name)

);

--Viewing the table supplier
SELECT * FROM supplier;

--Creating the table works_on
CREATE TABLE works_on(
    employee_id INT,
    client_id INT,
    total_sales INT,
    FOREIGN KEY(employee_id) REFERENCES employee(employee_id),
    FOREIGN KEY(client_id) REFERENCES client(client_id),
    PRIMARY KEY(employee_id, client_id)
);

--Viewing the table works_on
SELECT * FROM works_on;

--Adding values to the table branch
INSERT INTO branch VALUES (1, 'Corporate', NULL, '2009-02-09');
INSERT INTO branch VALUES (2, 'Scranton', NULL, '1992-09-23');
INSERT INTO branch VALUES (3, 'Stamford', NULL, '2010-01-23');

--Adding Values to the table employee
INSERT INTO employee VALUES (100, 'David', 'Wallace', '1967-11-17', 'M', 250000, NULL, 1);

INSERT INTO employee(employee_id,first_name, last_name, birthday, sex, salary, super_id, branch_id) 
VALUES
    (101, 'Jan', 'Levinson', '1961-05-11', 'F', 110000, 100, 1),
    (102, 'Michael', 'Scott', '1964-03-15', 'M', 75000, 100, 2),
    (103, 'Angella', 'Martin', '1971-06-25', 'F', 63000, 102, 2),
    (104, 'Kelly', 'Kapoor', '1980-02-05', 'F', 55000, 102, 2),
    (105, 'Stanley', 'Hudson', '1958-02-19', 'M', 69000, 102, 2),
    (106, 'Josh', 'Porter', '1969-09-05', 'M', 78000, 100, 3),
    (107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, 3),
    (108, 'Jim', 'Hulpert', '1978-10-01', 'M', 71000, 106, 3);

--Altering the table branch to add manager IDs
UPDATE branch
SET mgr_id = 100
WHERE branch_id = 1;

UPDATE branch
SET mgr_id = 102
WHERE branch_id = 2;

UPDATE branch
SET mgr_id = 106
WHERE branch_id = 3;

--Adding values to the table client
INSERT INTO client(client_id, client_name, branch_id) VALUES
(400, 'Dunmore Highschool', 2),
(401, 'Lackanawa County', 2),
(402, 'FedEx', 3),
(403, 'John Daly Law LLC', 3),
(404, 'Scranton Whitepages',2),
(405, 'Times Newspaper', 3),
(406, 'FedEx', 2);

--Adding Values to the table works_on
INSERT INTO works_on VALUES
(105,400,55000),
(102,401,267000),
(108,402,22500),
(107,403,5000),
(108,403,12000),
(105,404,33000),
(107,405,26000),
(102,406,15000),
(105,406,130000);

--Adding values into the table supplier
INSERT INTO supplier(branch_id, supplier_name, supply_type) VALUES
(2, 'Hammer Mill', 'Paper'),
(2, 'Uni-ball', 'Utensils'),
(3, 'Patriot Paper', 'Paper'),
(2, 'J.T. Forms & Labels', 'Custom Forms'),
(3, 'Uni-ball', 'Utensils'),
(3, 'Hammer Mill', 'Paper'),
(3, 'Stamford Labels', 'Custom Forms');


--BASIC QUERIES

--Find all employees
SELECT * FROM employee;

--Find all clients
SELECT * FROM client;

--Find all employees ordered by salary
SELECT * FROM employee
ORDER BY salary;

--Find all employees ordered by sex then name.
SELECT * FROM employee
ORDER BY sex,first_name;

--Find the first 5 employees in the table
SELECT * FROM employee
LIMIT 5;

--Find the first and last names of all employees
SELECT first_name,last_name 
FROM employee;

--Find the forenames and surnames of all employees
SELECT first_name AS forename, last_name AS surname
FROM employee;

--Find all the different genders
SELECT DISTINCT sex
FROM employee;

--Find all male employees
SELECT * FROM employee
WHERE sex = 'M';

--Find all employees at branch 2
SELECT * FROM employee
WHERE branch_id = 2;

--Find all employee's id's and names who were born after 1969
SELECT employee_id, first_name, last_name FROM employee
WHERE birthday >= '1970-01-01';

--Find all female employees at branch 2
SELECT * FROM employee
WHERE sex = 'F' AND branch_id = 2;

--Find all employees who are female and born after 1969 or who make over 80000
SELECT * FROM employee
WHERE (sex = 'F' AND birthday >= '1970-01-01') OR salary > 80000;

--Find all employees born between 1970 and 1975
SELECT * FROM employee
WHERE birthday BETWEEN'1970-01-01' AND '1975-12-31';

--Find all employees named Jim, Michael, Johnny, or David
SELECT * FROM employee
WHERE first_name IN ('Jim', 'Michael', 'Johnny', 'David');


--SQL FUNCTIONS

--Find the number of employees
SELECT COUNT(employee_id) FROM employee;

--Find the average of all employee's salaries
SELECT AVG(salary) FROM employee;

--Find the sum of all employee's salaries
SELECT SUM(salary) FROM employee;

--Find out how many males and females there are
SELECT COUNT(sex),sex
FROM employee
GROUP BY sex;

--Find the total sales of each salesman
SELECT SUM(total_sales), employee_id
FROM works_on
GROUP BY employee_id;

--Find the total amount of money spent by each client
SELECT SUM(total_sales), client_id
FROM works_on
GROUP BY client_id;

--WILDCARDS

--Find any clients who are an LLC
SELECT * FROM client
WHERE client_name LIKE '%LLC';

--Find any branch suppliers who are in the label business
SELECT * FROM supplier
WHERE supplier_name LIKE '%label%';

--Find any employee born on the 11th day of the month
SELECT * FROM employee
WHERE birthday LIKE '____-__-11%';

--Find any clients who are schools
SELECT * FROM client
WHERE client_name LIKE '%school%';

--UNIONS

--Find all employees and branch names
SELECT employee.first_name AS employee_branch_names
FROM employee
UNION
SELECT branch.branch_name
FROM branch;

--Find a list of all clients & branch suppliers' names
SELECT client.client_name AS clients_and_suppliers_names, client.branch_id AS Branch_ID
FROM client
UNION
SELECT supplier.supplier_name, supplier.branch_id
FROM supplier;


--JOINS
SELECT employee.employee_id, employee.first_name, branch.branch_name
FROM employee
JOIN branch
ON employee.employee_id = branch.mgr_id;

--NESTED QUERIES

--Find names of all employees who have sold over 50,000

SELECT employee.first_name, employee.last_name
FROM employee
WHERE employee_id IN(
    SELECT works_on.employee_id
    FROM works_on
    GROUP BY works_on.employee_id
    HAVING SUM(total_sales) > 50000   
);

SELECT employee.first_name, employee.last_name
FROM employee
WHERE employee.employee_id
IN(
    SELECT works_on.employee_id 
    FROM works_on
    WHERE works_on.total_sales > 50000
);

--Find all clients who are handled by the branch that Michael Scott manages
--Assume you know Michael's ID
SELECT client.client_id, client.client_name
FROM client
WHERE client.branch_id = (
    SELECT branch.branch_id
    FROM branch
    WHERE branch.mgr_id = 102
);

--Find all clients who are handled by the branch that Michael Scott manages
--Assume you do not know Michael's ID
SELECT client.client_id, client.client_name
FROM client
WHERE client.branch_id = (
    SELECT branch.branch_id
    FROM branch
    WHERE branch.mgr_id = (
        SELECT employee.employee_id 
        FROM employee
        WHERE employee.first_name = 'Michael' AND employee.last_name = 'Scott'
    )
);


--Find the names of employees who work with clients handled by the Scranton branch
SELECT employee.employee_id, employee.first_name, employee.last_name
FROM employee
WHERE employee.employee_id IN (
    SELECT works_on.employee_id
    FROM works_on
    WHERE works_on.client_id IN (
        SELECT client.client_id
        FROM client
        WHERE client.branch_id = (
            SELECT branch.branch_id
            FROM branch
            WHERE branch_name = 'Scranton'
        )
    )
);

--Find then names of all clients who have spent more than 100,000 USD
SELECT client.client_id, client.client_name
FROM client
WHERE client.client_id IN (
    SELECT works_on.client_id
    FROM works_on
    GROUP BY client_id
    HAVING SUM(total_sales) > 100000
);

--TRIGGERS

CREATE TABLE trigger_test(
    message VARCHAR(100)
);

--View table trigger_test
SELECT * FROM trigger_test;

--A trigger to alert us whenever a new employee is added to the Database
DELIMITER $$

CREATE TRIGGER employee_alert
AFTER INSERT
ON employee
FOR EACH ROW
BEGIN
   INSERT INTO trigger_test VALUES  ('NEW EMPLOYEE ADDED');
END$$

DELIMITER ;

--Insert into the table employee a new employee test the above trigger
INSERT INTO employee VALUES(109, 'Dave', 'Chapelle', '1989-08-09', 'M', 210000, 100, 3);


--A trigger that returns the first name of the added employee
DELIMITER $$

CREATE TRIGGER first_name
AFTER INSERT
ON employee
FOR EACH ROW
BEGIN
   INSERT INTO trigger_test VALUES(NEW.first_name);
END$$

DELIMITER ;

--Insert a new employee into the table employee to test the above trigger
INSERT INTO employee VALUES(110, 'Gabe', 'Lavelle', '1979-08-09', 'F', 110000, 106, 2);

--A trigger that alerts us on the gender of the new employee

DELIMITER $$

CREATE TRIGGER trigger_test
AFTER INSERT
ON employee
FOR EACH ROW
BEGIN
    IF NEW.sex = 'M' THEN
        INSERT INTO trigger_test VALUES ('ADDED A MALE EMPLOYEE');
    ELSEIF NEW.sex = 'F' THEN
        INSERT INTO trigger_test VALUES ('ADDED A FEMALE EMPLOYEE');
    ELSE
        INSERT INTO trigger_test VALUES ('ADDED JUST ANOTHER EMPLOYEE'); 
    END IF;
END$$

DELIMITER ;

--Add new employees to test the above trigger
INSERT INTO employee VALUES(111, 'Gill', 'Pele', '2009-08-09', 'F', 80000, 102, 2);
INSERT INTO employee VALUES(112, 'Gabriel', 'Peter', '1979-10-09', 'M', 100000, 106, 2);
INSERT INTO employee VALUES(113, 'Giselle', 'Glory', '1999-10-09', NULL, 70000, 106, 2);









