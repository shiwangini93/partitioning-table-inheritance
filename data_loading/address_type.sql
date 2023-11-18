-- Inserting shipping address details from users into address_type table
INSERT INTO address_type (type, street, house_number_block, zip_code, city, country, created_datetime, updated_datetime)
SELECT 'shipping', street, house_number_block, zip_code, city, country, 
       TO_TIMESTAMP(CAST(created AS BIGINT) / 1000), TO_TIMESTAMP(CAST(updated AS BIGINT) / 1000)
FROM users;

