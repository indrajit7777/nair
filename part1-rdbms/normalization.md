## Anomaly Analysis

**Insert Anomaly**  
Cannot add a new product or new customer without creating a fake order row.  
Example: There is no row that allows inserting just a new product (e.g., "Printer") or new customer without filling order_id, quantity, etc. Every row forces values in columns order_id, customer_id, product_id together.

**Update Anomaly**  
Same information repeated in many rows — changing it risks inconsistency.  
Example: Customer C001 "Rohan Mehta" (city = Mumbai) appears in rows 3, 11, 15, 22, 42, 95, 106, 132, 133, etc. (column customer_city).  
Also, sales rep SR01 office_address is written as "Nariman Point, Mumbai - 400021" in row 3 but inconsistently as "Nariman Pt, Mumbai - 400021" in row 39 (column office_address).

**Delete Anomaly**  
Deleting an order deletes the only record of a product.  
Example: Product P008 "Webcam" (category = Electronics, unit_price = 2100) appears **only** in row 13 (columns product_id, product_name, category, unit_price). Deleting that row loses the product forever.

## Normalization Justification
Your manager argues that keeping everything in one table is simpler and normalization is over-engineering. Using specific examples from the dataset, I strongly refute this position.

The flat file creates exactly the three classic anomalies we identified, making the data fragile and expensive to maintain.

1. **Update anomaly** — Rohan Mehta (C001) has his city duplicated in at least 12 rows (rows 3, 11, 15, 22, 42, etc.). If he moves to Pune, we must edit 12+ rows manually. One mistake and Q1 ("customers from Mumbai") shows wrong results. In 3NF we update only the customers table once.

2. **Delete anomaly** — Webcam (P008) exists only in row 13. If the customer returns the item and we delete the order row, the entire product record (name, category, price) disappears. In 3NF the products table keeps it safe.

3. **Insert anomaly** — We cannot add a new sales representative or a new product "Printer" until they have an order. This blocks normal business operations like onboarding or catalog updates.

The flat file also wastes space (customer names, rep emails, and addresses repeated 20–30 times) and prevents proper indexing. After normalizing to 3NF (see schema_design.sql), all anomalies are gone, storage is reduced, queries become faster, and the design scales. Keeping one table is only "simpler" for 10 rows — with 180+ orders it becomes a maintenance nightmare. Normalization is not over-engineering; it is professional data engineering.
