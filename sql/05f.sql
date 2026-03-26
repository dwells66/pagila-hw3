/* 
 * Finding movies with similar categories still gives you too many options.
 *
 * Write a SQL query that lists all movies that share 2 categories with AMERICAN CIRCUS and 1 actor.
 *
 * HINT:
 * It's possible to complete this problem both with and without set operations,
 * but I find the version using set operations much more intuitive.
 */
SELECT title
FROM (
    SELECT f.title
    FROM film f
    JOIN film_category AS fc ON f.film_id = fc.film_id
    JOIN category AS c ON fc.category_id = c.category_id
    WHERE c.name IN (SELECT name
        FROM category
        JOIN film_category USING (category_id)
        JOIN film USING (film_id)
        WHERE title = 'AMERICAN CIRCUS')
    GROUP BY f.film_id, f.title
    HAVING COUNT(DISTINCT fc.category_id) >=2

    INTERSECT

    SELECT f.title
    FROM film f
    JOIN film_actor fa ON f.film_id = fa.film_id
    JOIN actor a ON fa.actor_id = a.actor_id
    WHERE a.actor_id IN (SELECT actor_id
        FROM actor
        JOIN film_actor USING (actor_id)
        JOIN film USING (film_id)
        WHERE title = 'AMERICAN CIRCUS')) AS sub
ORDER BY title;
