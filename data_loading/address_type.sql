-- Insert shipping addresses from 'users' into 'address_type'
INSERT INTO address_type (type, street, house_number_block, zip_code, city, country, created_datetime, updated_datetime) 
SELECT 
    'shipping',                      -- Address type being inserted
    street,                          -- Street information from users table
    house_number_block,              -- House number or block from users table
    zip_code,                        -- ZIP code from users table
    city,                            -- City information from users table
    country,                         -- Country information from users table
    to_timestamp(created  / 1000),   -- Conversion of created timestamp from epoch to timestamp format
    to_timestamp(updated  / 1000)    -- Conversion of updated timestamp from epoch to timestamp format
FROM 
    users;                           -- Source table 'users' containing address information

