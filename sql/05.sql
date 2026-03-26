/*
 * You love the acting in the movie 'AMERICAN CIRCUS' and want to watch other movies with the same actors.
 *
 * Write a SQL query that lists the title of all movies that share at least 1 actor with 'AMERICAN CIRCUS'.
 *
 * HINT:
 * This can be solved with a self join on the film_actor table.
 */

SELECT f.title
    FROM film f
    JOIN film_actor fa ON f.film_id = fa.film_id
    JOIN actor a ON fa.actor_id = a.actor_id
    WHERE a.actor_id IN (SELECT actor_id
        FROM actor
        JOIN film_actor USING (actor_id)
        JOIN film USING (film_id)
        WHERE title = 'AMERICAN CIRCUS')
ORDER BY f.title;
