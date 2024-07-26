SELECT
    p.person_id AS director_id,
    CONCAT(p.first_name, ' ', p.last_name) AS director_name,
    AVG(m.budget) AS average_budget
FROM
    people p
JOIN
    movies m ON p.person_id = m.director_id
GROUP BY
    p.person_id, p.first_name, p.last_name;
