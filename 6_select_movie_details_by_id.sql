SELECT
    m.movie_id AS id,
    m.title,
    m.release_date,
    m.duration,
    m.description,
    json_build_object('file_id', f.file_id, 'file_name', f.file_name, 'mime_type', f.mime_type, 'file_key', f.file_key, 'file_url', f.file_url) AS poster,
    json_build_object(
        'id', p.person_id,
        'first_name', p.first_name,
        'last_name', p.last_name,
        'photo', json_build_object(
            'file_id', pf.file_id,
            'file_name', pf.file_name,
            'mime_type', pf.mime_type,
            'file_key', pf.file_key,
            'file_url', pf.file_url
        )
    ) AS director,
    ARRAY_AGG(
        json_build_object(
            'id', ac.person_id,
            'first_name', ac.first_name,
            'last_name', ac.last_name,
            'photo', json_build_object(
                'file_id', af.file_id,
                'file_name', af.file_name,
                'mime_type', af.mime_type,
                'file_key', af.file_key,
                'file_url', af.file_url
            )
        )
    ) AS actors,
    ARRAY_AGG(
        json_build_object(
            'id', g.genre_id,
            'name', g.name
        )
    ) AS genres
FROM
    movies m
LEFT JOIN
    files f ON m.poster_id = f.file_id
LEFT JOIN
    people p ON m.director_id = p.person_id
LEFT JOIN
    person_photos pp ON p.person_id = pp.person_id AND pp.is_primary = TRUE
LEFT JOIN
    files pf ON pp.file_id = pf.file_id
LEFT JOIN
    characters c ON m.movie_id = c.movie_id
LEFT JOIN
    people ac ON c.person_id = ac.person_id
LEFT JOIN
    person_photos ap ON ac.person_id = ap.person_id AND ap.is_primary = TRUE
LEFT JOIN
    files af ON ap.file_id = af.file_id
LEFT JOIN
    movie_genres mg ON m.movie_id = mg.movie_id
LEFT JOIN
    genres g ON mg.genre_id = g.genre_id
WHERE
    m.movie_id = 1
GROUP BY
    m.movie_id, m.title, m.release_date, m.duration, m.description, f.file_id, f.file_name, f.mime_type, f.file_key, f.file_url, p.person_id, p.first_name, p.last_name, pf.file_id, pf.file_name, pf.mime_type, pf.file_key, pf.file_url;
