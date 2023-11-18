-- accounts 

-- Convert 'id' column to UUID type
ALTER TABLE public.accounts ALTER COLUMN id TYPE uuid USING id::uuid::uuid;

-- Convert 'user_id' column to UUID type
ALTER TABLE public.accounts ALTER COLUMN user_id TYPE uuid USING user_id::uuid::uuid;

-- Convert 'currency' column to varchar(20)
ALTER TABLE public.accounts ALTER COLUMN currency TYPE varchar(20) USING currency::varchar(20);

-- Convert 'status' column to varchar(20)
ALTER TABLE public.accounts ALTER COLUMN status TYPE varchar(20) USING status::varchar(20);

-- Convert 'iban' column to varchar(80)
ALTER TABLE public.accounts ALTER COLUMN iban TYPE varchar(80) USING iban::varchar(80);

-- Convert 'balance' column to decimal
ALTER TABLE public.accounts ALTER COLUMN balance TYPE decimal USING balance::decimal;

-- Convert 'created' column to bigint
ALTER TABLE public.accounts ALTER COLUMN created TYPE bigint USING created::bigint;

-- Convert 'updated' column to bigint
ALTER TABLE public.accounts ALTER COLUMN updated TYPE bigint USING updated::bigint;

-- Add a generated column 'created_at_datetime' with timestamp type
ALTER TABLE accounts ADD column created_at_datetime timestamp generated always as (to_timestamp(created  / 1000)) stored;

-- Add a generated column 'updated_at_datetime' with timestamp type
ALTER TABLE accounts ADD column updated_at_datetime timestamp generated always as (to_timestamp(updated  / 1000)) stored;

-- Add primary key constraint on 'id' column
ALTER TABLE public.accounts ADD CONSTRAINT accounts_pk PRIMARY KEY (id);
