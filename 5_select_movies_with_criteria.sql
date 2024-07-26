SELECT
    m.movie_id AS id,
    m.title,
    m.release_date,
    m.duration,
    m.description,
    json_build_object('file_id', f.file_id, 'file_name', f.file_name, 'mime_type', f.mime_type, 'file_key', f.file_key, 'file_url', f.file_url) AS poster,
    json_build_object('id', p.person_id, 'first_name', p.first_name, 'last_name', p.last_name) AS director
FROM
    movies m
JOIN
    files f ON m.poster_id = f.file_id
JOIN
    people p ON m.director_id = p.person_id
JOIN
    movie_genres mg ON m.movie_id = mg.movie_id
JOIN
    genres g ON mg.genre_id = g.genre_id
WHERE
    m.country_id = 1
    AND m.release_date >= '2022-01-01'
    AND m.duration > INTERVAL '2 hours 15 minutes'
    AND g.name IN ('Action', 'Drama')
GROUP BY
    m.movie_id, m.title, m.release_date, m.duration, m.description, f.file_id, f.file_name, f.mime_type, f.file_key, f.file_url, p.person_id, p.first_name, p.last_name;
