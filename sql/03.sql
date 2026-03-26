/*
 * List the total amount of money that customers from each country have payed.
 * Order the results from most to least money.
 */

SELECT
    co.country,
    SUM(p.amount) AS total_payments
FROM country AS co
JOIN city AS cy
    ON co.country_id = cy.country_id
JOIN address AS a
    ON cy.city_id = a.city_id
JOIN customer AS c
    ON a.address_id = c.address_id
JOIN payment AS p
    ON c.customer_id = p.customer_id
GROUP BY co.country
ORDER BY total_payments DESC,co.country;
