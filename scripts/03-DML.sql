INSERT INTO customers (first_name, last_name, age, email, country, postal_code, pet_type, pet_name, pet_breed)
SELECT DISTINCT customer_first_name, customer_last_name, customer_age, customer_email, customer_country, customer_postal_code, customer_pet_type, customer_pet_name, customer_pet_breed
FROM data_raw;

INSERT INTO sellers (first_name, last_name, email, country, postal_code)
SELECT DISTINCT seller_first_name, seller_last_name, seller_email, seller_country, seller_postal_code
FROM data_raw;

INSERT INTO products (name, category, price, weight, color, size, brand, material, description, rating, reviews, release_date, expiry_date)
SELECT DISTINCT product_name, product_category, product_price, product_weight, product_color, product_size, product_brand, product_material, product_description, product_rating, product_reviews, product_release_date, product_expiry_date
FROM data_raw;

INSERT INTO stores (name, location, city, state, country, phone, email)
SELECT DISTINCT store_name, store_location, store_city, store_state, store_country, store_phone, store_email
FROM data_raw;

INSERT INTO suppliers (name, contact, email, phone, address, city, country)
SELECT DISTINCT supplier_name, supplier_contact, supplier_email, supplier_phone, supplier_address, supplier_city, supplier_country
FROM data_raw;

INSERT INTO fact_sales (customer_id, seller_id, product_id, store_id, supplier_id, sale_date, quantity, total_price)
SELECT 
    c.customer_id, 
    s.seller_id, 
    p.product_id, 
    st.store_id, 
    sp.supplier_id, 
    d.sale_date, 
    d.sale_quantity, 
    d.sale_total_price
FROM data_raw d
JOIN customers c ON d.customer_email = c.email
JOIN sellers s ON d.seller_email = s.email
JOIN products p ON d.product_name = p.name AND d.product_category = p.category
JOIN stores st ON d.store_name = st.name AND d.store_city = st.city
JOIN suppliers sp ON d.supplier_name = sp.name AND d.supplier_email = sp.email
LIMIT 1000;

DROP TABLE data_raw;
