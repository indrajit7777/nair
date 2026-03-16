// OP1: insertMany() — insert all 3 documents from sample_documents.json
db.products.insertMany([
  {
    "_id": "prod_elec_001",
    "category": "Electronics",
    "name": "Gaming Laptop",
    "price": 85000,
    "warranty_years": 2,
    "voltage": "220V",
    "specs": { "ram": "16GB", "storage": "1TB SSD", "gpu": "RTX 3060" },
    "in_stock": true
  },
  {
    "_id": "prod_cloth_001",
    "category": "Clothing",
    "name": "Premium Denim Jeans",
    "price": 2500,
    "size": "32",
    "material": "100% Cotton",
    "color": "Blue",
    "available_sizes": ["30", "32", "34"]
  },
  {
    "_id": "prod_groc_001",
    "category": "Groceries",
    "name": "Organic Milk 1L",
    "price": 120,
    "expiry_date": "2024-12-15",
    "nutrition": { "calories": 150, "protein": 8, "fat": 5 },
    "stock": 450
  }
]);

// OP2: find() — retrieve all Electronics products with price > 20000
db.products.find({ category: "Electronics", price: { $gt: 20000 } });

// OP3: find() — retrieve all Groceries expiring before 2025-01-01
db.products.find({ category: "Groceries", expiry_date: { $lt: "2025-01-01" } });

// OP4: updateOne() — add a "discount_percent" field to a specific product
db.products.updateOne(
  { name: "Gaming Laptop" },
  { $set: { discount_percent: 15 } }
);

// OP5: createIndex() — create an index on category field and explain why
db.products.createIndex({ category: 1 });
// Reason: Category is used in frequent filter queries (OP2 and OP3). An index makes these searches O(log n) instead of full collection scan, improving performance as the catalog grows to thousands of products.
