-- Table Renaming Script

-- Renaming 'transactions' to 'transactions_old'.
ALTER TABLE transactions RENAME TO transactions_old;

-- Renaming 'transactions2' to 'transactions'.
ALTER TABLE transactions2 RENAME TO transactions;

-- Dropping the old 'transactions_old' table.
DROP TABLE transactions_old;

