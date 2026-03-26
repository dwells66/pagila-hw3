/*
 * Management also wants to create a "best sellers" list for each category.
 *
 * Write a SQL query that:
 * For each category, reports the five films that have been rented the most for each category.
 *
 * Note that in the last query, we were ranking films by the total amount of payments made,
 * but in this query, you are ranking by the total number of times the movie has been rented (and ignoring the price).
 */


WITH sub AS (
    SELECT
        c.name,
        f.title,
        COUNT(r.rental_id) AS "total rentals"
    FROM film f
    JOIN film_category fc USING (film_id)
    JOIN category c USING (category_id)
    JOIN inventory i USING (film_id)
    JOIN rental r USING (inventory_id)
    GROUP BY c.name,f.title),
sub2 AS (
    SELECT
    name,
    title,
    "total rentals",
    ROW_NUMBER() OVER (
        PARTITION BY name
        ORDER BY "total rentals" DESC, title DESC ) AS rank
    FROM sub )
SELECT
    name,
    title,
    "total rentals"
FROM sub2
WHERE rank <= 5
ORDER BY name,"total rentals" DESC, title;
