-- 1. Create a new column called “status” in the rental table that uses a case statement to indicate if a film was returned late, early, or on time. 
ALTER TABLE rental
ADD COLUMN status text; --This adds the column to the table, but will have only Null values

update rental
set status =    --This will fill the new status column with data, specifically the CASE data I've created below:
   CASE 
WHEN rental_duration > date_part('day', return_date - rental_date) THEN 'Returned Early'
WHEN rental_duration < date_part('day', return_date - rental_date) THEN 'Returned Late'
ELSE 'Returned On Time'
END
FROM film ---Here I had to link another table's data for the ids and rental duration values.
INNER JOIN inventory
ON inventory.film_id = film.film_id 

-- 2. Show the total payment amounts for people who live in Kansas City or Saint Louis. 

/*Here I had to add the payment amounts for customers from two cities. That
involved chaining 4 tables together with INNER JOINS */

SELECT SUM(amount) AS Total_Payment_Amount  
FROM payment as p
INNER JOIN customer as c1
ON c1.customer_id = p.customer_id
INNER JOIN address AS ad
ON ad.address_id = c1.address_id
INNER JOIN city AS c2
ON c2.city_id = ad.city_id
WHERE city = 'Kansas City' OR city = 'Saint Louis'

-- 3. How many films are in each category? Why do you think there is a table for category and a table for film category?

/* I did not have to ORDER BY category_id, but I did because that result looked crazy and I did not like it!*/

SELECT category_id, COUNT(film_id) AS number_of_films
FROM film_category
GROUP BY category_id
ORDER BY category_id

/* I think having the seperate tables for categories and film-categories pairs allows the assignment of
integer values to what would otherwise be varchar fields, allowing for more efficient data manipulation. That
is probably why film names are assigned film ids, as well. */ 


-- 4. Show a roster for the staff that includes their email, address, city, and country (not ids)

/* While not explicity told to do so, I did include staff last and first names
as I figured that is what a roster is. Then it was just a matter of following
relationship maps to include the desired data in one query with INNER JOINS (which are
quickly becoming my favorite way to craft queries.)*/

SELECT last_name, first_name, email, address, city, country 
FROM staff
INNER JOIN address AS ad
ON ad.address_id = staff.address_id
INNER JOIN city
ON city.city_id = ad.city_id
INNER JOIN country
ON country.country_id = city.country_id

-- 5. Show the film_id, title, and length for the movies that were returned from May 15 to 31, 2005

SELECT film.film_id, title, length AS length_in_minutes
FROM film
INNER JOIN inventory as i
ON i.film_id = film.film_id
INNER JOIN rental AS r
ON r.inventory_id = i.inventory_id
WHERE return_date BETWEEN '2005-05-15' AND '2005-06-01'
/* From experimentation, I learned that BETWEEN is inclusive on the left, exclusive
on the right. That is why I needed to extend my date by one day on the right to include rentals
returned on May 31st. */

-- 6. Write a subquery to show which movies are rented below the average price for all movies. 

/*341 Directly answering the question only necessitates I query for titles, but to confirm I had pulled the 
desired data, I checked with a DISTINCT rental_rate query to see if there is, actually, only one rental rate below the average
for all movies. A subquery was a concise way to answer this question, because aggregate function like 
'WHERE rental_rate < AVG(rental_rate)' are not allowed in the WHERE clause. */
SELECT title
FROM film
WHERE rental_rate <
	(SELECT AVG(rental_rate)
	FROM film) 

-- 7. Write a join statement to show which movies are rented below the average price for all movies.
SELECT f1.title, f1.rental_rate
FROM film as f1
INNER JOIN film as f2
  ON f1.title = f2.title
  AND f1.rental_rate < 2.98
GROUP BY f1.title, f1.rental_rate


-- 8. Perform an explain plan on 6 and 7, and describe what you’re seeing and important ways they differ.
-- For number 6:
EXPLAIN ANALYZE SELECT title
FROM film
WHERE rental_rate <
	(SELECT AVG(rental_rate)
	FROM film)

/* Plan stated: "Seq Scan on film  (cost=66.51..133.01 rows=333 width=15) (actual time=0.888..1.532 rows=341 loops=1)"
"  Filter: (rental_rate < $0)"
"  Rows Removed by Filter: 659"
"  InitPlan 1 (returns $0)"
"    ->  Aggregate  (cost=66.50..66.51 rows=1 width=32) (actual time=0.854..0.855 rows=1 loops=1)"
"          ->  Seq Scan on film film_1  (cost=0.00..64.00 rows=1000 width=6) (actual time=0.009..0.326 rows=1000 loops=1)"
"Planning Time: 0.575 ms"
"Execution Time: 1.638 ms"*?


-- For number 7: 

-- 9. With a window function, write a query that shows the film, its duration, and what percentile the duration fits into. This may help https://mode.com/sql-tutorial/sql-window-functions/#rank-and-dense_rank 
/* A window function is indicated by the 'OVER' and defined by the (ORDER BY) in my query. I'm telling the program that
I want to take the length of the film over all film lengths, subdivided by 100 with the NTILE command.*/

SELECT title, length, NTILE(100) OVER (ORDER BY length) AS percentile
FROM film
ORDER BY title, length

-- 10. In under 100 words, explain what the difference is between set-based and procedural programming. Be sure to specify which sql and python are. 
/*In set-based programming, as is done in SQL, the focus is on entire SETS (or set of rows) of data. The syntax and structure are focused on efficiently manipulating entire
data sets and the relationships between data. A programmer says 'what' to do, not 'how' to do it. With procedural programming like python, the focus is more on creating
a list of instructions (or procedures) for the program to execute, explicitly stating the 'how' of the execution.*/

-- Bonus: Find the relationship that is wrong in the data model. Explain why it’s wrong. 
/* The relationship that is not represented correctly in the data model is the one between the customer table
and the rental table. The model shows that relationship as an optional one-to-one relationship. However, while
the optional part is correct (a new customer might not have any rentals), one customer can have many rentals. 
Therefore, the relationship from customer table to rental table should be represented as an optional one-to-many relationship or
circle/crow's feet.*/