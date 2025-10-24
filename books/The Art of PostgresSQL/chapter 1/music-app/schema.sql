CREATE TABLE artist (
    artistid SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    genre VARCHAR(100),
    country VARCHAR(100),
    formed_year INT,
    label VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE albums (
    albumid SERIAL PRIMARY KEY,
    artistid INT,
    title VARCHAR(255) NOT NULL,
    duration INTERVAL,
    release_date DATE,
    track_count INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO artist (name, genre, country, formed_year, label)
VALUES
  ('Red Hot Chili Peppers', 'Funk Rock', 'USA', 1983, 'Warner Bros'),
  ('Coldplay', 'Alternative Rock', 'UK', 1996, 'Parlophone'),
  ('Imagine Dragons', 'Pop Rock', 'USA', 2008, 'Interscope'),
  ('Adele', 'Soul / Pop', 'UK', 2006, 'XL Recordings'),
  ('Burna Boy', 'Afro-fusion', 'Nigeria', 2010, 'Spaceship Entertainment'),
  ('Taylor Swift', 'Pop / Country', 'USA', 2006, 'Republic Records'),
  ('Ed Sheeran', 'Pop', 'UK', 2011, 'Asylum Records'),
  ('The Weeknd', 'R&B / Pop', 'Canada', 2010, 'XO / Republic'),
  ('Drake', 'Hip Hop', 'Canada', 2001, 'OVO Sound'),
  ('Wizkid', 'Afrobeats', 'Nigeria', 2010, 'Starboy Entertainment');


INSERT INTO albums (artistid, title, duration, release_date, track_count)
VALUES
  -- Red Hot Chili Peppers (artistid = 1)
  (1, 'Californication', '56:24', '1999-06-08', 15),
  (1, 'By the Way', '68:46', '2002-07-09', 16),
  (1, 'Stadium Arcadium', '122:00', '2006-05-09', 28),
  (1, 'Unlimited Love', '73:04', '2022-04-01', 17),

  -- Coldplay (artistid = 2)
  (2, 'Parachutes', '41:48', '2000-07-10', 10),
  (2, 'A Rush of Blood to the Head', '54:08', '2002-08-26', 11),
  (2, 'Viva la Vida or Death and All His Friends', '45:49', '2008-06-12', 10),
  (2, 'Music of the Spheres', '42:32', '2021-10-15', 12),

  -- Imagine Dragons (artistid = 3)
  (3, 'Night Visions', '53:44', '2012-09-04', 13),
  (3, 'Smoke + Mirrors', '50:55', '2015-02-17', 13),
  (3, 'Evolve', '43:15', '2017-06-23', 11),
  (3, 'Origins', '40:57', '2018-11-09', 12),

  -- Adele (artistid = 4)
  (4, '19', '43:00', '2008-01-28', 12),
  (4, '21', '48:12', '2011-01-24', 11),
  (4, '25', '48:25', '2015-11-20', 11),
  (4, '30', '58:15', '2021-11-19', 12),

  -- Burna Boy (artistid = 5)
  (5, 'African Giant', '63:15', '2019-07-26', 19),
  (5, 'Twice as Tall', '53:13', '2020-08-14', 15),
  (5, 'Love, Damini', '60:12', '2022-07-08', 19),

  -- Taylor Swift (artistid = 6)
  (6, '1989', '48:41', '2014-10-27', 13),
  (6, 'Reputation', '55:38', '2017-11-10', 15),
  (6, 'Lover', '61:48', '2019-08-23', 18),
  (6, 'Midnights', '44:08', '2022-10-21', 13),

  -- Ed Sheeran (artistid = 7)
  (7, 'Divide (÷)', '59:33', '2017-03-03', 16),
  (7, 'Equals (=)', '48:26', '2021-10-29', 14),
  (7, 'Subtract (-)', '47:20', '2023-05-05', 14),

  -- The Weeknd (artistid = 8)
  (8, 'Beauty Behind the Madness', '65:21', '2015-08-28', 14),
  (8, 'Starboy', '68:40', '2016-11-25', 18),
  (8, 'After Hours', '56:19', '2020-03-20', 14),
  (8, 'Dawn FM', '51:49', '2022-01-07', 16),

  -- Drake (artistid = 9)
  (9, 'Scorpion', '89:44', '2018-06-29', 25),
  (9, 'Certified Lover Boy', '86:02', '2021-09-03', 21),
  (9, 'Honestly, Nevermind', '52:32', '2022-06-17', 14),

  -- Wizkid (artistid = 10)
  (10, 'Made in Lagos', '52:29', '2020-10-30', 14),
  (10, 'More Love, Less Ego', '46:29', '2022-11-11', 13);
