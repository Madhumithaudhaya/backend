use ai_task_db;
/* Find Top 3 customers */
select u.user_name,
SUM(o.order_amount) as total_spent
from users as u
join orderss as o
on u.user_id=o.user_id
group by u.user_id, u.user_name
order by total_spent DESC
limit 3;


/* Highest order value pair*/
SELECT u.user_name,
       MAX(o.order_amount) AS highest_order
FROM users u
JOIN orders o
ON u.user_id = o.user_id
GROUP BY u.user_id, u.user_name;


/* Duplicate emails*/

select email , count(*) as Duplicate_count 
from users
group by email 
having count(*) >1;
