CREATE TABLE car_booking (
    id SERIAL PRIMARY KEY,
    car_id INT NOT NULL,
    user_id INT NOT NULL,
    cancelled BOOLEAN NOT NULL DEFAULT FALSE,
    reserved_during TSTZRANGE NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    EXCLUDE USING GIST (
        car_id WITH =,
        reserved_during WITH &&
    ) WHERE (NOT cancelled)
)

-- ✅ First booking (Car 1)
INSERT INTO car_booking (car_id, user_id, reserved_during)
VALUES (
  1,
  10,
  tstzrange('2025-11-03 08:00+01', '2025-11-03 10:00+01', '[)')
);

-- ✅ Second booking (Car 1, non-overlapping range)
INSERT INTO car_booking (car_id, user_id, reserved_during)
VALUES (
  1,
  11,
  tstzrange('2025-11-03 10:00+01', '2025-11-03 12:00+01', '[)')
);

-- ✅ Third booking (Car 2, any time range)
INSERT INTO car_booking (car_id, user_id, reserved_during)
VALUES (
  2,
  12,
  tstzrange('2025-11-03 09:00+01', '2025-11-03 11:00+01', '[)')
);

-- ❌ Overlapping booking for the same car
INSERT INTO car_booking (car_id, user_id, reserved_during)
VALUES (
  1,
  13,
  tstzrange('2025-11-03 09:30+01', '2025-11-03 11:30+01', '[)')
);
