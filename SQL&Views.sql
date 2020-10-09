-- Write 10 SQL to queries on your denormalized and normalized tables without joins 
-- 1. 
SELECT payment_method, COUNT(member_id) AS no_of_members
FROM members
GROUP BY payment_method;
-- 2.
SELECT movie_id, movie_title, genre
FROM movie
WHERE genre LIKE '%Drama%';
-- 3.
SELECT SUM(total_amount) AS total_revenue
FROM orders;
-- 4.
SELECT order_id, ticket_confirmation_id, fee
FROM orders
WHERE fee = 0;
-- 5.
SELECT theater_id, COUNT(movie_id) AS no_of_movies 
FROM schedules
GROUP BY theater_id;
-- 6.
SELECT version, COUNT(movie_id) AS no_of_movies 
FROM schedules
GROUP BY version;
-- 7.
SELECT *
FROM theater
WHERE manager = 'David May';
-- 8.
SELECT schedule_id, reserved_seats
FROM ticket
WHERE reserved_seats IS NOT NULL;
-- 9.
SELECT gender, COUNT(employee_id) AS no_of_employees
FROM employees
GROUP BY gender;
-- 10. 
SELECT AVG(regular_unit_price - special_unit_price) AS avg_price_diff
FROM orders;
-- Create 2 Views
-- 1.
CREATE VIEW movies_on_show AS
SELECT m.movie_id, m.movie_title, m.genre, m.film_rating, s.movie_time, s.version, s.auditorium, t. theater_name
FROM movie m
JOIN schedules s
ON m.movie_id = s.movie_id
JOIN theater t
ON t.theater_id = s.theater_id;

SELECT *
FROM movies_on_show;
-- 2.
CREATE VIEW employees_list AS
SELECT e.employee_id, e.employee_name, th.theater_id, th.theater_name
FROM employees e
JOIN orders o
ON e.employee_id = o.employee_id
JOIN ticket ti
ON ti.ticket_confirmation_id = o.ticket_confirmation_id
JOIN schedules s
ON s.schedule_id = ti.schedule_id
JOIN theater th
ON th.theater_id = s.theater_id;

SELECT *
FROM employees_list;