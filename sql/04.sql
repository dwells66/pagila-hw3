/*
 * List the first and last names of all actors who:
 * 1. have appeared in at least one movie in the "Children" category,
 * 2. but that have never appeared in any movie in the "Horror" category.
 */

SELECT DISTINCT
    a.first_name,
    a.last_name
FROM actor a
JOIN film_actor fa USING (actor_id)
JOIN film_category fc USING (film_id)
JOIN category c USING (category_id)
WHERE c.name = 'Children'
AND a.actor_id NOT IN(SELECT fa2.actor_id
                        FROM film_actor fa2
                        JOIN film_category fc2 USING (film_id)
                        JOIN category c2 USING (category_id)
                        WHERE c2.name = 'Horror')
ORDER BY a.last_name;



