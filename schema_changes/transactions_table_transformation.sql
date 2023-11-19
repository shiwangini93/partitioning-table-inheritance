-- Create a new table 'transactions2' with specific columns in the public schema

CREATE TABLE public.transactions2 (
    id uuid NULL,
    card_id uuid NULL,
    account_id uuid NULL,
    amount numeric NULL,
    created bigint NULL,
    created_datetime timestamp NULL
);

-- Define Primary Key for 'transactions2' table
ALTER TABLE public.transactions2 ADD CONSTRAINT transactions_pk PRIMARY KEY (id);

-- Add Foreign Key Constraint for 'account_id' referencing 'accounts' table
ALTER TABLE transactions2 ADD CONSTRAINT account_id_transactions_fk FOREIGN KEY (account_id) REFERENCES accounts(id);

-- Creating a foreign key constraint
ALTER TABLE transactions2 
ADD CONSTRAINT card_id_transactions_fk FOREIGN KEY (card_id) REFERENCES cards(id);

-- Adding index.
CREATE INDEX round_amount_idx ON transactions (account_id, amount) WHERE amount::numeric % 1 = 0; 

-- partition function 
CREATE OR REPLACE FUNCTION public.create_partition_table_month_transactions()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
DECLARE
    from_date DATE; -- Stores the last day of the current month
    end_date DATE; -- Stores the first day of the current month
    suffix VARCHAR(2000); -- Suffix for the table name (MM_YYYY)
    generate_query VARCHAR; -- Dynamic SQL query for table creation
    exist_check VARCHAR; -- Check for existing table
    check_query VARCHAR; -- Dynamic SQL query for table existence check
    table_name VARCHAR; -- Name of the partitioned table
    insert_query VARCHAR; -- Dynamic SQL query for data insertion
    id TEXT; -- Variables to store transaction data
    card_id TEXT;
    account_id TEXT;
    amount DECIMAL;
    created TEXT; 
    created_at TIMESTAMP;
BEGIN
    -- Calculate the dates and suffix for the new table
    from_date = (SELECT (DATE_TRUNC('MONTH', TO_TIMESTAMP(new.created ::NUMERIC / 1000)) + INTERVAL '1 MONTH' ) AS max_date);
    end_date = (SELECT (DATE_TRUNC('MONTH', TO_TIMESTAMP(new.created ::NUMERIC / 1000))) AS min_date);
    suffix = (SELECT TO_CHAR(TO_TIMESTAMP(new.created ::NUMERIC / 1000), 'MM_YYYY') AS suffix_date);
    created_at = (SELECT (TO_TIMESTAMP(new.created ::NUMERIC / 1000)) AS created_at);
    table_name = 'transactions_' || suffix;

    -- Store transaction data into variables
    SELECT new.id, new.card_id, new.account_id, new.amount, new.created INTO id, card_id, account_id, amount, created;

    -- Check if the table exists
    check_query = 'SELECT tablename FROM pg_tables WHERE tablename = ''' || table_name || '''';
    insert_query = 'INSERT INTO ' || table_name || ' VALUES (''' || id || ''', ''' || card_id || ''', ''' || account_id || ''', ' || amount || ', ' || created || ', ''' || created_at || ''')';

    EXECUTE check_query INTO exist_check;

    -- Create the new partitioned table and insert data if it doesn't exist
    IF exist_check IS NULL THEN
        generate_query = 'CREATE TABLE ' || table_name || ' (CHECK (created_datetime >= ''' || end_date || ''' AND created_datetime <= ''' || from_date || ''')) INHERITS (transactions2);ALTER TABLE '|| table_name ||' ADD CONSTRAINT '|| table_name || '_pk PRIMARY KEY (id);
ALTER TABLE '|| table_name || ' ADD CONSTRAINT account_id_'|| table_name || '_fk FOREIGN KEY (account_id) REFERENCES accounts(id); ALTER TABLE '|| table_name || ' ADD CONSTRAINT card_id_'|| table_name || '_fk FOREIGN KEY (card_id) REFERENCES cards(id); CREATE INDEX round_amount_idx_'|| table_name || ' ON ' || table_name || ' (account_id, amount) WHERE amount::NUMERIC % 1 = 0';
  
        EXECUTE generate_query;
        EXECUTE insert_query;
    ELSE
        EXECUTE insert_query;
    END IF;

    RETURN NULL;
END;
$function$
;




-- Trigger Definition

-- Create a trigger named 'insert_transactions_trigger' to execute before inserting into the 'transactions2' table.
-- It's configured to execute a function 'create_partition_table_month_transactions' for each inserted row.

CREATE TRIGGER insert_transactions_trigger 
BEFORE INSERT ON public.transactions2 
FOR EACH ROW 
EXECUTE FUNCTION create_partition_table_month_transactions();

