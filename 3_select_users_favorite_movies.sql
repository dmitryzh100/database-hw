SELECT
    u.user_id AS id,
    u.username,
    ARRAY_AGG(fm.movie_id) AS favorite_movie_ids
FROM
    users u
LEFT JOIN
    favorite_movies fm ON u.user_id = fm.user_id
GROUP BY
    u.user_id, u.username;
