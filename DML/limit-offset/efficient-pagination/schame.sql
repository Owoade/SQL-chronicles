-- With constraints and indexes
CREATE TABLE transactions (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    amount DECIMAL(10, 2) NOT NULL CHECK (amount > 0),
    type VARCHAR(50) NOT NULL CHECK (type IN ('deposit', 'withdrawal', 'transfer', 'refund')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
