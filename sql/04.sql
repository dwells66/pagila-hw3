/*
 * List the first and last names of all actors who:
 * 1. have appeared in at least one movie in the "Children" category,
 * 2. but that have never appeared in any movie in the "Horror" category.
 */

SELECT
    a.first_name,
    a.last_name
FROM actor a
JOIN film_actor AS fa USING (actor_id)
JOIN film_category AS fc ON fa.film_id = fc.film_id
JOIN category AS c ON fc.category_id = c.category_id
WHERE c.name = 'Children'
AND a.actor_id NOT IN (
        SELECT fa2.actor_id
        FROM film_actor fa2
        JOIN film_category AS fc2 ON fa2.film_id = fc2.film_id
        JOIN category AS c2 ON fc2.category_id = c2.category_id
        WHERE c2.name = 'Horror'
)
GROUP BY a.first_name, a.last_name
ORDER BY a.last_name,a.first_name;
