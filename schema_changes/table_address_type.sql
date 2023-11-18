-- Define an enumeration type for address categories
CREATE TYPE address_category AS ENUM('shipping','working','passport','emergency');

-- Create a table 'address_type' to store addresses
CREATE TABLE address_type (
    id serial primary key,               -- Primary key column
    type address_category,               -- Column to store the address category
    street varchar(100),                 -- Street information
    house_number_block varchar(50),      -- House number or block information
    zip_code varchar(10),                -- ZIP code information
    city varchar(60),                    -- City information
    country varchar(100),                -- Country information
    created_datetime timestamp,          -- Timestamp for creation
    updated_datetime timestamp           -- Timestamp for updates
);

