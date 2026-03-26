/* 
 * In the previous query, the actors could come from any combination of movies.
 * Unfortunately, you've found that if the actors all come from only 1 or 2 of the movies,
 * then there is not enough diversity in the acting talent.
 *
 * Write a SQL query that lists all of the movies where:
 * at least 1 actor was also in AMERICAN CIRCUS,
 * at least 1 actor was also in ACADEMY DINOSAUR,
 * and at least 1 actor was also in AGENT TRUMAN.
 *
 * HINT:
 * There are many ways to solve this problem,
 * but I personally found the INTERSECT operator to make a convenient solution.
 */

SELECT f.title
FROM film f
WHERE film_id IN (
    SELECT fa1.film_id
    FROM film_actor fa1
    WHERE fa1.actor_id IN (
        SELECT fa_ac.actor_id
        FROM film_actor fa_ac
        JOIN film f_ac ON fa_ac.film_id = f_ac.film_id
        WHERE f_ac.title = 'AMERICAN CIRCUS'
    )

    INTERSECT 

    SELECT fa2.film_id
    FROM film_actor fa2
    WHERE fa2.actor_id IN (
        SELECT fa_ad.actor_id
        FROM film_actor fa_ad
        JOIN film f_ad ON fa_ad.film_id = f_ad.film_id
        WHERE f_ad.title = 'ACADEMY DINOSAUR'
    )

    INTERSECT 

    SELECT fa3.film_id
    FROM film_actor fa3
    WHERE fa3.actor_id IN (
        SELECT fa_at.actor_id
        FROM film_actor fa_at
        JOIN film f_at ON fa_at.film_id = f_at.film_id
        WHERE f_at.title = 'AGENT TRUMAN'
    ) )
ORDER BY title;
