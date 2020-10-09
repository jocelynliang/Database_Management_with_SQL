-- Write Queries to answer your business questions (or additional business questions) 
-- 1.How many transactions are cash vs credit?
SELECT m.payment_method, COUNT(o.order_id) AS no_of_transaction
FROM members m
JOIN orders o
ON o.member_id = m.member_id
GROUP BY m.payment_method;

-- 2.What are the total sales in each movie theater?
CREATE VIEW sales_by_theater AS
SELECT o.total_amount, th.theater_id, th.theater_name, th.zipcode, th.phone_number, th.manager
FROM orders o
JOIN ticket ti
ON o.ticket_confirmation_id = ti.ticket_confirmation_id
JOIN schedules s
ON s.schedule_id = ti.schedule_id
JOIN theater th
ON th.theater_id = s.theater_id;

SELECT SUM(total_amount) AS total_sales, theater_id, theater_name, zipcode, phone_number, manager
FROM sales_by_theater
GROUP BY theater_id, theater_name, zipcode, phone_number, manager
ORDER BY total_sales DESC;

-- 3.How many transactions are processed online vs in person?
SELECT SUM(CASE WHEN employee_id IS NULL THEN 1 ELSE 0 END) AS no_of_trans_online, 
       SUM(CASE WHEN employee_id IS NOT NULL THEN 1 ELSE 0 END) AS no_of_trans_in_person
FROM (SELECT o.order_id, e.employee_id
      FROM employees e
      FULL OUTER JOIN orders o
      ON o.employee_id = e.employee_id);

-- 4.Which version of screen were the most shows on? 
SELECT version, COUNT(version) AS no_of_shows 
FROM schedules
GROUP BY version
ORDER BY COUNT(version) DESC
FETCH FIRST 1 ROW ONLY;
         
-- 5.What time of the day do most people come to watch movie in the theater?
SELECT TO_CHAR(CAST(s.movie_time AS TIME),'hh24:mi:ss') AS time, (SUM(o.regular_quantity) + SUM(o.special_quantity)) AS no_of_customers
FROM schedules s
RIGHT OUTER JOIN ticket ti
ON ti.schedule_id = s.schedule_id
JOIN orders o
ON o.ticket_confirmation_id = ti.ticket_confirmation_id
GROUP BY TO_CHAR(CAST(s.movie_time AS TIME),'hh24:mi:ss')
ORDER BY SUM(o.regular_quantity) + SUM(o.special_quantity) DESC;

     
-- 6.How much time do customers purchase tickets ahead of show time on average?
SELECT   AVG(EXTRACT(day FROM time_diff)*24 +
         EXTRACT(hour FROM time_diff)) AS avg_hour_diff,
         AVG((EXTRACT(day FROM time_diff)*24*60 +
         EXTRACT(hour FROM time_diff)*60 +
         EXTRACT(minute FROM time_diff))) AS avg_minute_diff
FROM(
SELECT (s.movie_time - o.order_date) AS time_diff
FROM orders o
JOIN ticket ti
ON o.ticket_confirmation_id = ti.ticket_confirmation_id
LEFT OUTER JOIN schedules s
ON s.schedule_id = ti.schedule_id);
         
-- 7.Which genre of movies is the most popular?
SELECT m.genre, (SUM(o.regular_quantity) + SUM(o.special_quantity)) AS no_of_purchase
FROM movie m
JOIN schedules s
ON m.movie_id = s.movie_id
RIGHT OUTER JOIN ticket ti
ON s.schedule_id = ti.schedule_id
JOIN orders o
ON ti.ticket_confirmation_id = o.ticket_confirmation_id
GROUP BY m.genre
ORDER BY no_of_purchase DESC
FETCH FIRST 1 ROW ONLY;
         
-- 8.Which auditoriums offer reversed seats?
SELECT th.theater_name, s.auditorium, ti.reserved_seats
FROM ticket ti
LEFT OUTER JOIN schedules s
ON s.schedule_id = ti.schedule_id
JOIN theater th
ON th.theater_id = s.theater_id
WHERE ti.reserved_seats IS NOT NULL;
                  
-- 9.Which customers order more than once? 
SELECT o.member_id, m.member_name, COUNT(o.order_id) AS no_of_orders
FROM orders o
LEFT OUTER JOIN members m
ON o.member_id = m.member_id
GROUP BY o.member_id, m.member_name
HAVING COUNT(o.order_id) > 1;
                 
-- 10.Who is in charge of the theater which has the most movies on show?
 SELECT th.theater_id, th.theater_name, th.manager, COUNT(s.schedule_id) AS no_of_shows
 FROM theater th
 RIGHT JOIN schedules s
 ON th.theater_id = s.theater_id
 GROUP BY th.theater_id, th.theater_name, th.manager
 ORDER BY COUNT(s.schedule_id) DESC
 FETCH FIRST 1 ROW ONLY;