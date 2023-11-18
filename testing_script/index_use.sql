-- Use below query to validate whether index(round_amount_idx_partition_name) is getting used or not

explain SELECT id, account_id , amount,  created_datetime 
FROM transactions
WHERE account_id = '1e3b2691-43bb-4825-b0b1-85380be9512d'
  AND amount::numeric % 1 = 0  -- Checks for perfectly round amounts
ORDER BY created_datetime  DESC  -- Considers the last transactions
LIMIT 10; 
