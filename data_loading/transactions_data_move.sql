-- Insertion Script

-- Populate the 'transactions2' table by selecting and converting data from the 'transactions' table.
-- It casts columns from 'transactions' into appropriate types and inserts them into 'transactions2'.

INSERT INTO transactions2 
SELECT 
    CAST(id AS UUID), 
    CAST(card_id AS UUID), 
    CAST(account_id AS UUID), 
    CAST(amount AS DECIMAL), 
    CAST(created AS BIGINT) 
FROM transactions;

