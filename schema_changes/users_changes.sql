-- Altering data types and removing duplicate address columns from 'users' table
ALTER TABLE public.users ALTER COLUMN created TYPE bigint USING created::bigint;
ALTER TABLE public.users ALTER COLUMN updated TYPE bigint USING updated::bigint;

-- Removing redundant address columns from 'users' table. Make sure you move data into address_type table before continuing with below steps(Execute address_type.sql script)
ALTER TABLE users DROP COLUMN street, DROP COLUMN house_number_block, DROP COLUMN zip_code, DROP COLUMN city, DROP COLUMN country;

-- Adding new address columns to 'users' table
ALTER TABLE users ADD COLUMN address_shipping INT;
ALTER TABLE users ADD COLUMN address_working INT;
ALTER TABLE users ADD COLUMN address_passport INT;
ALTER TABLE users ADD COLUMN address_emergency INT;

-- Establishing relationships with 'address_type' table
ALTER TABLE users ADD CONSTRAINT address_id_shipping_fk FOREIGN KEY (address_shipping) REFERENCES address_type(id);
ALTER TABLE users ADD CONSTRAINT address_id_working_fk FOREIGN KEY (address_working) REFERENCES address_type(id);
ALTER TABLE users ADD CONSTRAINT address_id_passport_fk FOREIGN KEY (address_passport) REFERENCES address_type(id);
ALTER TABLE users ADD CONSTRAINT address_id_emergency_fk FOREIGN KEY (address_emergency) REFERENCES address_type(id);

-- Modifying data types and generating timestamp columns based on existing epoch values
ALTER TABLE public.users
    ALTER COLUMN id TYPE uuid USING id::uuid::uuid,
    ALTER COLUMN first_name TYPE varchar(50) USING first_name::varchar,
    ALTER COLUMN last_name TYPE varchar(50) USING last_name::varchar,
    ALTER COLUMN birth_date TYPE bigint USING birth_date::bigint,
    ALTER COLUMN birth_place TYPE varchar(50) USING birth_place::varchar,
    ALTER COLUMN gender TYPE bool USING gender::bool,
    ALTER COLUMN nationality TYPE varchar(10) USING nationality::varchar,
    ALTER COLUMN email TYPE varchar(200) USING email::varchar,
    ALTER COLUMN mobile_phone_number TYPE varchar(20) USING mobile_phone_number::varchar;

-- Adding generated timestamp columns based on epoch values
ALTER TABLE users ADD COLUMN created_datetime TIMESTAMP GENERATED ALWAYS AS (TO_TIMESTAMP(created / 1000)) STORED;
ALTER TABLE users ADD COLUMN updated_datetime TIMESTAMP GENERATED ALWAYS AS (TO_TIMESTAMP(updated / 1000)) STORED;
ALTER TABLE users ADD COLUMN birth_date_datetime TIMESTAMP GENERATED ALWAYS AS (TO_TIMESTAMP(birth_date / 1000)) STORED;

-- Adding a primary key constraint to the 'id' column in the 'users' table
ALTER TABLE public.users 
ADD CONSTRAINT users_pk PRIMARY KEY (id);


