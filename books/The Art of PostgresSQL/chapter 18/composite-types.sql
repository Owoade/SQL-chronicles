CREATE TYPE address AS (
  street TEXT,
  city TEXT,
  state TEXT,
  country TEXT
);

CREATE TABLE users (
  id UUID PRIMARY KEY,
  home_address address
);

INSERT INTO users (id, home_address)
VALUES (
  gen_random_uuid(),
  ROW('12 Allen Ave', 'Ikeja', 'Lagos', 'Nigeria')::address
);

SELECT (home_address).city FROM users;

UPDATE users
SET home_address.city = 'Yaba'
WHERE id = '...';