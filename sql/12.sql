/* 
 * A new James Bond movie will be released soon, and management wants to send promotional material to "action fanatics".
 * They've decided that an action fanatic is any customer where at least 4 of their 5 most recently rented movies are action movies.
 *
 * Write a SQL query that finds all action fanatics.
 */

WITH ranked AS (SELECT
        r.customer_id,
        r.inventory_id,
        r.rental_date,
        ROW_NUMBER() OVER (
            PARTITION BY r.customer_id
            ORDER BY r.rental_date DESC) AS rc
        FROM rental r
),
top5 AS (SELECT *
            FROM ranked
            WHERE rc <= 5),
action_fanatics AS (SELECT t.customer_id
    FROM top5 t
    JOIN inventory i USING (inventory_id)
    JOIN film_category fc USING (film_id)
    JOIN category c USING (category_id)
    GROUP BY t.customer_id
    HAVING COUNT(*) >= 5
    AND COUNT(*) FILTER (WHERE c.name = 'Action') >= 4)
SELECT
    cu.customer_id,
    cu.first_name,
    cu.last_name
FROM action_fanatics af
JOIN customer cu USING (customer_id)
ORDER BY cu.customer_id;

