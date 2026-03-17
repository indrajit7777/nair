-- Star Schema with cleaned data (10+ fact rows)

CREATE TABLE dim_date (
    date_key INTEGER PRIMARY KEY,
    full_date DATE NOT NULL,
    year INTEGER NOT NULL,
    month INTEGER NOT NULL,
    day INTEGER NOT NULL
);

CREATE TABLE dim_store (
    store_key INTEGER PRIMARY KEY,
    store_name VARCHAR(100) NOT NULL,
    store_city VARCHAR(50) NOT NULL
);

CREATE TABLE dim_product (
    product_key INTEGER PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL
);

CREATE TABLE fact_sales (
    transaction_id VARCHAR(10) PRIMARY KEY,
    date_key INTEGER NOT NULL,
    store_key INTEGER NOT NULL,
    product_key INTEGER NOT NULL,
    units_sold INTEGER NOT NULL,
    revenue DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (date_key) REFERENCES dim_date(date_key),
    FOREIGN KEY (store_key) REFERENCES dim_store(store_key),
    FOREIGN KEY (product_key) REFERENCES dim_product(product_key)
);

-- Cleaned Dimension Data
INSERT INTO dim_date VALUES 
(20230113, '2023-01-13', 2023, 1, 13),
(20230118, '2023-01-18', 2023, 1, 18),
(20230220, '2023-02-20', 2023, 2, 20),
(20230815, '2023-08-15', 2023, 8, 15),
(20230829, '2023-08-29', 2023, 8, 29),
(20231020, '2023-10-20', 2023, 10, 20),
(20231029, '2023-10-29', 2023, 10, 29),
(20231212, '2023-12-12', 2023, 12, 12);

INSERT INTO dim_store VALUES 
(1, 'Chennai Anna', 'Chennai'),
(2, 'Delhi South', 'Delhi'),
(3, 'Bangalore MG', 'Bangalore'),
(4, 'Mumbai Central', 'Mumbai'),
(5, 'Unknown', 'Unknown');

INSERT INTO dim_product VALUES 
(1, 'Speaker', 'Electronics'),
(2, 'Tablet', 'Electronics'),
(3, 'Smartwatch', 'Electronics'),
(4, 'Jeans', 'Clothing'),
(5, 'Saree', 'Clothing'),
(6, 'Atta 10kg', 'Groceries');

-- Cleaned Fact Data (10 rows - all dates standardized, categories fixed, revenue = units_sold * unit_price)
INSERT INTO fact_sales VALUES 
('TXN5000', 20230829, 1, 1, 3, 147788.34),   -- Speaker
('TXN5001', 20231212, 1, 2, 11, 255487.32),  -- Tablet (serial 45272 cleaned)
('TXN5003', 20230220, 2, 2, 14, 325165.68),  -- Tablet
('TXN5009', 20230815, 3, 3, 3, 176553.03),   -- Smartwatch
('TXN5011', 20231020, 4, 4, 13, 30127.11),   -- Jeans
('TXN5015', 20230118, 4, 5, 15, 531777.15),  -- Saree
('TXN5021', 20230113, 4, 4, 16, 37079.52),   -- Jeans
('TXN5027', 20230220, 1, 4, 12, 27809.64),   -- Jeans
('TXN5033', 20231029, 5, 6, 8, 419712.00),   -- Atta (city was empty → Unknown)
('TXN5005', 20230806, 3, 6, 12, 629568.00);  -- Atta (serial 45144 cleaned)
