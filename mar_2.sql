use ai_task_db;
create table users 
(
user_id int primary key,
user_name varchar(50) not null,
email varchar(100) unique
);


create table orderss
(
order_id int primary key,
order_amount decimal(10,2),
user_id int,
foreign key (user_id) references users(user_id)
on delete cascade
on update cascade
);

INSERT INTO orderss VALUES
(101, 5000, 1),
(102, 7000, 1),
(103, 3000, 2),
(104, 9000, 3),
(105, 2000, 3),
(106, 1500, 4);


INSERT INTO users VALUES
(1, 'Arjun', 'arjun@gmail.com'),
(2, 'Priya', 'priya@gmail.com'),
(3, 'Ravi', 'ravi@gmail.com'),
(4, 'Sneha', 'sneha@gmail.com'),
(5, 'Kiran', 'kiran@gmail.com');

select u.user_name , o.order_amount  
from users as u
inner join orderss as o 
on u.user_id = o.user_id;

select u.user_name , o.order_amount  
from users as u
left join orderss as o 
on u.user_id = o.user_id;

SELECT *
FROM users u
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.user_id = u.user_id
    AND o.order_amount > 5000
);

SELECT DISTINCT u.*
FROM users u
JOIN orders o
ON u.user_id = o.user_id
WHERE o.order_amount > 5000;

SELECT u.*
FROM users AS u
JOIN orders AS o
ON u.user_id = o.user_id
WHERE order_amount > 5000;

SELECT u.*
FROM users u
JOIN orders o
ON u.user_id = o.user_id
GROUP BY u.user_id
HAVING 
    SUM(o.order_amount) < 15000
    AND SUM(CASE WHEN o.order_amount > 5000 THEN 1 ELSE 0 END) > 0;
    
SELECT u.user_name
FROM users u
JOIN orders o
ON u.user_id = o.user_id
GROUP BY u.user_id, u.user_name
HAVING COUNT(o.order_id) = 1
   AND MAX(o.order_amount) > 5000;
   

SELECT u.user_name,
       SUM(o.order_amount) AS total_spent
FROM users u
JOIN orders o
ON u.user_id = o.user_id
GROUP BY u.user_id, u.user_name
ORDER BY total_spent DESC
LIMIT 1;