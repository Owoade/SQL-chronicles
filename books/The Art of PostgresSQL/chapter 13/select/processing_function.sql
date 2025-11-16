SELECT 
    to_char(date, 'Dy') AS day_name,
    extract(isodow   FROM date) AS iso_dow,
    extract(isoyear  FROM date) AS iso_year,
    extract(week     FROM date) AS week,
    extract(day      FROM (date + interval '2 month - 1 day')) AS feb_last_day,
    extract(year     FROM date) AS year,
    (extract(day FROM (date + interval '2 month - 1 day')) = 29) AS leap
FROM 
    generate_series(date '2000-01-01', date '2010-01-01', interval '1 month') AS t(date);
