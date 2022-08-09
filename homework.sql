-- Q1 How many actors are there with the last name ‘Wahlberg’?

SELECT count(*) FROM actor WHERE last_name = 'Wahlberg';

-- A1 -> 2

---------------------------------------------------------------
-- Q2 How many payments were made between $3.99 and $5.99?

SELECT count(*) FROM payment WHERE amount BETWEEN 3.99 AND 5.99;

-- A2 -> 5,607

---------------------------------------------------------------
-- Q3 What films have exactly 7 copies? (search in inventory)

SELECT f.title FROM film f
WHERE  f.film_id IN (SELECT i.film_id FROM inventory i 
					 GROUP BY i.film_id	HAVING count(i.film_id) = 7);

-- A3 Returns list of movie around 116

---------------------------------------------------------------
-- Q4 How many customers have the first name ‘Willie’?

SELECT count(*) FROM customer WHERE first_name = 'Willie'; 

-- A4 -> 2

--------------------------------------------------------------------------------------------
-- Q5 What store employee (get the id) sold the most rentals (use the rental table)?

SELECT s.staff_id, s.first_name, s.last_name FROM staff s
WHERE s.staff_id IN (SELECT r.staff_id FROM rental r 
					 GROUP BY r.staff_id ORDER BY count(r.rental_id) DESC LIMIT 1); 

-- A5 -> 1 and return name and last name as well

SELECT r.staff_id, count(r.staff_id) FROM rental r GROUP BY r.staff_id ORDER BY count(r.rental_id)

-- A5 -> 2 8,004 and 1 8040

----------------------------------------------------------------------------------------------
-- Q6 How many unique district names are there?

SELECT count(DISTINCT district) FROM address

-- A6 -> 378 


-------------------------------------------------------------------------------------------------
-- Q7 What film has the most actors in it? (use film_actor table and get film_id)

SELECT film_id FROM film_actor GROUP BY film_id ORDER BY count(film_id) DESC LIMIT 1;

-- A7 -> 508

SELECT f.title  FROM film f WHERE f.film_id =
		(SELECT film_id FROM film_actor
		 GROUP BY film_id ORDER BY count(film_id) DESC LIMIT 1);

-- A7 movie name as Lambs Cincinatti 


---------------------------------------------------------------------------------------------------
-- Q8 From store_id 1, how many customers have a last name ending with ‘es’? (use customer table)
		
SELECT count(*) FROM customer WHERE last_name LIKE '%es';
		
-- A8 -> 21		

----------------------------------------------------------------------------------------------------
-- Q9 How many payment amounts (4.99, 5.99, etc.) had a number of rentals above 250 for customers
--    with ids between 380 and 430? (use group by and having > 250)

SELECT amount, count(*) FROM payment WHERE customer_id BETWEEN 380 AND 430 GROUP BY amount HAVING count(amount) > 250;
		
		
-- A9 -> 3 and will return table 2.99 -> 290, 4.99 -> 281 and 0.99 -> 269

-----------------------------------------------------------------------------------------------------

-- Q10 Within the film table, how many rating categories are there? And what rating has the most movies total?

SELECT count(DISTINCT rating) FROM film; 

SELECT rating AS most_rated FROM film GROUP BY rating ORDER BY most_rated DESC LIMIT 1;

-- A10 -> there are 5 different rating and the most rating is PG-13
-----------------------------------------------------------------------------------------------------

