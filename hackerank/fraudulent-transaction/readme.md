# Fraudulent Transactions Detection

## Problem Statement
You are given a database table named `transaction` with the following schema:

- **id**: Primary key for the transaction (integer).
- **user_id**: Identifier for the user performing the transaction.
- **timestamp**: Date and time when the transaction occurred.
- **amount**: Value of the transaction.

The goal is to detect **fraudulent transactions** based on the following criteria:

- A transaction is considered **fraudulent** if **multiple transactions occur within the same hour by the same user**.

## Expected Output
For each fraudulent case, return the following fields:

- **user_id**: The identifier of the user.
- **transaction_count**: The number of transactions made by the user within that hour.
- **total_amount**: The total sum of the transaction amounts within that hour.
- **start_time**: The timestamp of the first transaction within the hour.
- **end_time**: The timestamp of the last transaction within the hour.

## Example
Given a dataset, the output should highlight only those users who made multiple transactions within the same hour, along with their aggregated details.

---
⚠️ **Note:** You are expected to write the SQL query yourself. No solution is provided in this README.
