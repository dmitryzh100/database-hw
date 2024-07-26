SELECT
    p.person_id AS id,
    p.first_name,
    p.last_name,
    COALESCE(SUM(m.budget), 0) AS total_movies_budget
FROM
    people p
JOIN
    characters c ON p.person_id = c.person_id
JOIN
    movies m ON c.movie_id = m.movie_id
GROUP BY
    p.person_id, p.first_name, p.last_name;
