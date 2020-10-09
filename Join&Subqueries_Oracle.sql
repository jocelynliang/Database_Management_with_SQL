-- Write around 5 SQL statements using Joins, SubQuery concepts
-- 1.
SELECT o.order_id, o.total_amount, e.employee_id, e.employee_name
FROM orders o
LEFT JOIN employees e
ON e.employee_id = o.employee_id
ORDER BY e.employee_id;
-- 2.
SELECT m.movie_title, m.genre, m.film_rating, s.movie_time, s.auditorium, t.theater_name
FROM movie m
JOIN schedules s
ON m.movie_id = s.movie_id
JOIN theater t
ON t.theater_id = s.theater_id
WHERE s.version = 'IMAX';
-- 3.
SELECT m.member_id, m.member_name, m.movie_title, s.movie_time
FROM members m
JOIN orders o
ON m.member_id = o.member_id
JOIN ticket ti
ON o.ticket_confirmation_id = ti.ticket_confirmation_id
JOIN schedules s
ON ti.schedule_id = s.schedule_id
JOIN movie m
ON s.movie_id = m.movie_id;
-- 4. 
SELECT movie_id, movie_time, version, auditorium
FROM schedules
WHERE theater_id =
(SELECT theater_id
FROM theater
WHERE manager = 'David May');
-- 5.
SELECT s.movie_id, m.movie_title, s.movie_time, s.version, s.auditorium
FROM schedules s
JOIN movie m
ON m.movie_id = s.movie_id
WHERE m.movie_id IN
(SELECT movie_id
FROM movie
WHERE genre LIKE '%Drama%');