/*
 * Management wants to create a "best sellers" list for each actor.
 *
 * Write a SQL query that:
 * For each actor, reports the three films that the actor starred in that have brought in the most revenue for the company.
 * (The revenue is the sum of all payments associated with that film.)
 *
 * HINT:
 * For correct output, you will have to rank the films for each actor.
 * My solution uses the `rank` window function.
 */

WITH sub AS (
    SELECT
        a.actor_id,
        a.first_name,
        a.last_name,
        f.film_id,
        f.title,
        SUM(p.amount) AS revenue
    FROM actor a
    JOIN film_actor fa USING (actor_id)
    JOIN film f USING (film_id)
    JOIN inventory i USING (film_id)
    JOIN rental r USING (inventory_id)
    JOIN payment p USING (rental_id)
    GROUP BY a.actor_id, a.first_name, a.last_name, f.film_id, f.title),
sub2 AS (
    SELECT
    actor_id,
    first_name,
    last_name,
    film_id,
    title,
    ROW_NUMBER() OVER (
        PARTITION BY actor_id
        ORDER BY revenue DESC ) AS rank,
    revenue
    FROM sub )
SELECT *
FROM sub2
WHERE rank <= 3
ORDER BY actor_id;

