-- Adding a foreign key constraint on the 'user_id' column in the 'accounts' table
-- This constraint references the 'id' column in the 'users' table
ALTER TABLE accounts 
ADD CONSTRAINT user_id_transactions_fk FOREIGN KEY (user_id) REFERENCES users(id);
