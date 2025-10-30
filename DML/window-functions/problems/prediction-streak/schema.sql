CREATE TABLE game_predictions (
    id SERIAL PRIMARY KEY,
    team TEXT CHECK (team IN ('MUN', 'CHE', 'ARS', 'MCI', 'LIV')),
    prediction TEXT CHECK (prediction IN ('W', 'D', 'L')),
    result TEXT CHECK (result IN ('hit', 'miss')),
    date DATE
);