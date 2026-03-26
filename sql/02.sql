/*
 * Compute the country with the most customers in it. 
 */

SELECT
    country FROM country AS co
JOIN city AS cy
    ON co.country_id = cy.country_id
JOIN address AS a
    ON cy.city_id = a.city_id
JOIN customer AS c
    ON a.address_id = c.address_id
GROUP BY co.country
ORDER BY COUNT(c.customer_id) DESC
LIMIT 1;
