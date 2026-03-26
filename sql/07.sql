/*
 * List all actors with Bacall Number 2;
 * That is, list all actors that have appeared in a film with an actor that has appeared in a film with 'RUSSELL BACALL',
 * but do not include actors that have Bacall Number < 2.
 */

SELECT
    DISTINCT CONCAT(a.first_name,' ',a.last_name) AS "Actor Name"
FROM actor a
JOIN film_actor fa USING (actor_id)
JOIN film f USING (film_id)
WHERE f.film_id IN (SELECT f.film_id FROM film f
    JOIN film_actor fa USING (film_id)
    JOIN actor a USING (actor_id)
    WHERE a.actor_id IN (SELECT a.actor_id
        FROM actor a
        JOIN film_actor fa USING (actor_id)
        WHERE fa.film_id IN (SELECT f2.film_id
            FROM film f2
            JOIN film_actor fa2 USING (film_id)
            JOIN actor a2 USING (actor_id)
            WHERE a2.first_name = 'RUSSELL' AND a2.last_name = 'BACALL')))
AND a.actor_id NOT IN (SELECT a.actor_id FROM actor a
      JOIN film_actor fa USING (actor_id)
      JOIN film f USING (film_id)
      WHERE a.actor_id IN (SELECT a.actor_id
          FROM actor a
          JOIN film_actor fa USING (actor_id)
          WHERE fa.film_id IN (SELECT f2.film_id
              FROM film f2
              JOIN film_actor fa2 USING (film_id)
              JOIN actor a2 USING (actor_id)
              WHERE a2.first_name = 'RUSSELL' AND a2.last_name = 'BACALL')))ORDER BY "Actor Name";
