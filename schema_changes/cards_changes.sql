-- Alter columns in 'cards' table

-- Convert 'id' column to UUID type
ALTER TABLE public.cards ALTER COLUMN id TYPE uuid USING id::uuid::uuid;

-- Convert 'account_id' column to UUID type
ALTER TABLE public.cards ALTER COLUMN account_id TYPE uuid USING account_id::uuid::uuid;

-- Convert 'type' column to varchar(20)
ALTER TABLE public.cards ALTER COLUMN "type" TYPE varchar(20) USING "type"::varchar;

-- Convert 'expiration_date' column to bigint
ALTER TABLE public.cards ALTER COLUMN expiration_date TYPE bigint USING expiration_date::bigint;

-- Convert 'masked_card_number' column to varchar(50)
ALTER TABLE public.cards ALTER COLUMN masked_card_number TYPE varchar(50) USING masked_card_number::varchar;

-- Convert 'created' column to bigint
ALTER TABLE public.cards ALTER COLUMN created TYPE bigint USING created::bigint;

-- Convert 'updated' column to bigint
ALTER TABLE public.cards ALTER COLUMN updated TYPE bigint USING updated::bigint;

-- Add a generated column 'created_at_datetime' with timestamp type
ALTER TABLE cards ADD column created_at_datetime timestamp generated always as (to_timestamp(created / 1000)) stored;

-- Add a generated column 'updated_at_datetime' with timestamp type
ALTER TABLE cards ADD column updated_at_datetime timestamp generated always as (to_timestamp(updated / 1000)) stored;

-- Add a generated column 'expiration_date_datetime' with timestamp type
ALTER TABLE cards ADD column expiration_date_datetime timestamp generated always as (to_timestamp(expiration_date / 1000)) stored;

-- Add primary key constraint on 'id' column
ALTER TABLE public.cards ADD CONSTRAINT cards_pk PRIMARY KEY (id);

-- Add foreign key constraint 'account_id_fk' referencing 'accounts' table
ALTER TABLE cards ADD CONSTRAINT account_id_fk FOREIGN KEY (account_id) REFERENCES accounts (id);

