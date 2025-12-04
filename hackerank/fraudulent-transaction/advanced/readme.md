# Fraudulent Transactions Report — Simplified Requirements

## Overview
This report identifies users who perform multiple transactions within any rolling 1-hour period, which may indicate suspicious or fraudulent activity. This rule uses a continuous 60-minute sliding window to detect abnormal transaction frequency.

## Fraud Detection Rule
A transaction is considered **fraudulent** if:
- There exists at least one **prior** transaction by the same user within the preceding 60 minutes.

In other words, the **first transaction** in any time cluster is considered legitimate (potentially the user's normal behavior), but any **subsequent transactions** within 60 minutes of a prior transaction are flagged as suspicious.

## Report Output
The final report must return only the following fields:

| Field | Description |
|-------|-------------|
| user_id | Identifier of the user involved in fraudulent activity. |
| fraudulent_transaction_count | Total number of transactions that have at least one prior transaction within 60 minutes. |

No timestamps, total amounts, or cluster details are included in this simplified version.

## Behavior & Rules

### Rolling 1-Hour Lookback Window
For each user:
1. Sort transactions by timestamp (ascending).
2. For each transaction, look back at all prior transactions.
3. If any prior transaction occurred within the preceding 60 minutes, mark the current transaction as fraudulent.

### Counting Logic
- A transaction is fraudulent if: `current_timestamp - any_prior_timestamp ≤ 60 minutes`
- The `fraudulent_transaction_count` represents the total number of transactions that meet this criterion.
- **The first transaction in any cluster is NOT counted** as fraudulent, since it has no prior transaction to compare against within the window.

### Inclusion Criteria
A user appears in the report if:
- They have at least 1 transaction that has a prior transaction within 60 minutes (i.e., at least 2 transactions within a 1-hour window, with the first one excluded from the count).

Users with only normal activity (no transactions within 60 minutes of each other) are excluded.

## Examples

### Example 1: Simple Cluster
```
user_id | timestamp           | Status
--------|---------------------|------------------
101     | 2024-01-01 10:00:00 | ✅ Legitimate (first)
101     | 2024-01-01 10:15:00 | ❌ Fraudulent (15 min after prior)
101     | 2024-01-01 10:30:00 | ❌ Fraudulent (30 min after first, 15 min after prior)
101     | 2024-01-01 10:45:00 | ❌ Fraudulent (45 min after first)
```
**fraudulent_transaction_count = 3** (excludes the first transaction at 10:00)

### Example 2: Multiple Separate Clusters
```
user_id | timestamp           | Status
--------|---------------------|------------------
202     | 2024-01-01 09:00:00 | ✅ Legitimate (isolated)
202     | 2024-01-01 10:30:00 | ✅ Legitimate (>60 min gap, starts new cluster)
202     | 2024-01-01 10:50:00 | ❌ Fraudulent (20 min after 10:30)
```
**fraudulent_transaction_count = 1** (only the 10:50 transaction)

### Example 3: No Fraud
```
user_id | timestamp           | Status
--------|---------------------|------------------
303     | 2024-01-01 11:00:00 | ✅ Legitimate
303     | 2024-01-01 13:00:00 | ✅ Legitimate (>60 min gap)
```
**User 303 is excluded** from the report (no fraudulent transactions)

## Notes
- This document only describes the report requirements, not the SQL query.
- The interpretation of "fraudulent transactions" is based strictly on having a prior transaction within 60 minutes.
- Timestamp granularity should be at least to the minute.
- The lookback window is always **preceding** 60 minutes, not following.