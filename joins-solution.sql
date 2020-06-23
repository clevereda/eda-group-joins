
-- Get all customers and their addresses
SELECT * FROM "customers" 
JOIN "addresses" 
ON "addresses"."customer_id" = "customers"."id";

--Get all orders and their line items (orders, quantity and product)
SELECT "orders"."id", "orders"."order_date", "products"."description","line_items"."quantity"
FROM "line_items" 
JOIN "products" ON "line_items"."product_id"="products"."id"
JOIN "orders" ON "orders"."id"="line_items"."order_id";

--Which warehouses have cheetos?
SELECT "warehouse"."warehouse", "products"."description"
FROM "warehouse_product"
JOIN "warehouse" ON "warehouse"."id" = "warehouse_product"."warehouse_id"
JOIN "products" ON "products"."id" = "warehouse_product"."product_id"
WHERE "products"."description" = 'cheetos';

-- Which warehouses have diet pepsi?
 SELECT "warehouse"."warehouse", "products"."description"
FROM "warehouse_product"
JOIN "warehouse" ON "warehouse"."id" = "warehouse_product"."warehouse_id"
JOIN "products" ON "products"."id" = "warehouse_product"."product_id"
WHERE "products"."description" = 'diet pepsi';

--Get the number of orders for each customer
SELECT "customers".*, count("orders") as "total_orders"
FROM "addresses"
JOIN "customers" ON "customers"."id" = "addresses"."customer_id"
JOIN "orders" ON "orders"."address_id" = "addresses"."id"
GROUP BY "customers"."id";


--How many customers do we have
SELECT count("customers") FROM "customers";


--How many products do we carry?
SELECT count("products") FROM "products";

--What is the total available on-hand quantity of diet pepsi?
SELECT "products"."description",  SUM("warehouse_product"."on_hand") 
FROM "products"
JOIN "warehouse_product" ON "products"."id" ="warehouse_product"."product_id"
WHERE "products"."description" = 'diet pepsi'
GROUP BY "products"."description";


--How much was the total cost for each order
SELECT "orders"."id", "orders"."order_date", ("line_items"."quantity" *"products"."unit_price") as "total_price"
FROM "line_items"
JOIN "products" ON "line_items"."product_id" = "products"."id"
JOIN "orders" ON "orders"."id" = "line_items"."order_id";


--How much has each customer spent in total?
SELECT "customers"."first_name", "customers"."last_name", 
FROM "addresses"
JOIN "customers" ON "addresses".