create table employee(
id int,
name varchar(100),
salary int,
bonus int);

create table department(
dep_id int,
dep_name varchar(50)
);

insert into employee
(id,name,salary,bonus)
values
(1,'madhu',80000,10),
(2,'karthi',80000,7);

insert into department (dep_id, dep_name)
values
(1,'IT'),
(2,'MQ');


SELECT name,count(*)as total FROM ai_task_db.employee
group by name
having total =1;
alter table employee
add age int;

set sql_safe_updates=0;
update employee 
set age =24
where id=1;
update employee 
set age =20
where id=2;
update employee
set salary= 95000
where id =1;

select employee.name,department.dep_name
from employee
inner join department 
on employee.id=department.dep_id;

/*problem-1 Find employees with salary > 8000*/
select * from employee
where salary >8000;

/* problem-2 Count employees in each department*/
select dep_id,count(*) as total_employees
from department
group by dep_id;

SELECT d.dep_name, COUNT(e.id) AS total_employees
FROM employee e
INNER JOIN department d
ON e.id = d.dep_id
GROUP BY d.dep_name;

/* problem -3 join two table */ 

select e.name,d.dep_name
from employee e
inner join department d
on e.id = d.dep_id;

/* problem -4 find second highest salary */
select max(salary) from employee
where salary < (select max(salary) from employee);

select distinct salary 
from employee
order by salary desc
limit 1 offset 1;

/* problem 5 Group by department with average salary */

select id, avg(salary) as avg_salry
from employee
group by id;

select * from employee;
select dep_id,dep_name from department;
select * from employee
where age=20;

select name,count(*) from employee
group by name;

select distinct name 
from employee;

select name,count(*)as total from employee
group by name 
having total>0;

select * from employee
order by age,name asc;

select * from employee
where age between 21 and 25;

select * from employee
where id in (1,2);

select name as employees from employee;

select c1.age as age ,c2.salary as salary
from employee as c1 ,employee as c2
where c1.age=c2.age and c1.salary =c2.salary;

select c.name as emp , c.salary as revenue
from employee as c
where c.age>18;

select employee.id , employee.name, employee.age, department.dep_name
from employee
inner  join department
on  employee.id= department.dep_id;


select employee.id , employee.name, employee.age, department.dep_name,department.grade
from employee
left outer join department
on employee.id= department.dep_id;

insert into employee(id, name, salary, bonus)
values (3,'vijaya',10000,8);

update department
set dep_name="CEO"
where dep_id=3;

select employee.id, employee.name, employee.age, department.dep_name,department.grade
from employee
right join department
on employee.id= department.dep_id;

select * from department;

insert into department(dep_id, dep_name)
values(3, 'CEO');

alter table department 
add grade varchar(50);

SELECT *
FROM employee
LEFT JOIN department
ON employee.id = department.dep_id;

SELECT *
FROM employee
RIGHT JOIN department
ON employee.id = department.dep_id;

select * from employee
cross join department;

create table customers(
customer_id int primary key,
customer_name varchar(50)
);

create table orders(
order_id int primary key,
order_amount decimal(10,2),
customer_id int,
foreign key (customer_id) references customers(customer_id)
);

INSERT INTO customers VALUES
(1, 'Ravi'),
(2, 'Priya'),
(3, 'Arjun'),
(4, 'Meena');

INSERT INTO orders VALUES
(101, 5000, 1),
(102, 7000, 1),
(103, 3000, 2),
(104, 9000, 5);

INSERT INTO orders VALUES
(101, 5000, 1),
(102, 7000, 1),
(103, 3000, 2);

select c.customer_name , o.order_amount
from customers as c
inner join orders as o 
on c.customer_id= o.customer_id;

SELECT c.customer_name, o.order_amount
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id;

SELECT c.customer_name, o.order_amount
FROM customers c
RIGHT JOIN orders o
ON c.customer_id = o.customer_id;

SELECT c.customer_name, o.order_amount
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id

UNION

SELECT c.customer_name, o.order_amount
FROM customers c
RIGHT JOIN orders o
ON c.customer_id = o.customer_id;

SELECT c.customer_name
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

select c.customer_name,sum(o.order_amount) as total
from customers c
inner join orders o
on c.customer_id= o.customer_id
group by c.customer_id,c.customer_name
order by total Desc
limit 1, 3 ;


SELECT customer_name, total
FROM (
    SELECT c.customer_name,
           SUM(o.order_amount) AS total
    FROM customers c
    INNER JOIN orders o
    ON c.customer_id = o.customer_id
    GROUP BY c.customer_id, c.customer_name
) t
WHERE total = (
    SELECT DISTINCT total_sum
    FROM (
        SELECT SUM(order_amount) AS total_sum
        FROM orders
        GROUP BY customer_id
        ORDER BY total_sum DESC
        LIMIT 1 OFFSET 2
    ) x
);