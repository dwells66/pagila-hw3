/*
 * List the first and last names of all actors who:
 * 1. have appeared in at least one movie in the "Children" category,
 * 2. but that have never appeared in any movie in the "Horror" category.
 */

SELECT DISTINCT
    a.first_name,
    a.last_name
FROM actor a
JOIN
    (SELECT DISTINCT fa2.actor_id
        FROM film_actor AS fa2
        JOIN film_category AS fc2 ON fa2.film_id = fc2.film_id
        JOIN category AS c2 ON fc2.category_id = c2.category_id
        WHERE c2.name = 'Children'
) AS sub1 ON a.actor_id = sub1.actor_id
LEFT JOIN
    (SELECT DISTINCT fa3.actor_id
        FROM film_actor fa3
        JOIN film_category AS fc3 ON fa3.film_id = fc3.film_id
        JOIN category AS c3 ON fc3.category_id = c3.category_id
        WHERE c3.name = 'Horror'
) sub2 ON a.actor_id = sub2.actor_id
WHERE sub2.actor_id IS NULL
ORDER BY a.last_name,a.first_name;
