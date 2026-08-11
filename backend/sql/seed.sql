CREATE EXTENSION IF NOT EXISTS pgcrypto;
INSERT INTO users (name,email,password_hash,role) VALUES
('Admin User','admin@example.com',crypt('Password@123',gen_salt('bf')),'Admin'),
('Sales User','sales@example.com',crypt('Password@123',gen_salt('bf')),'Sales'),
('Warehouse User','warehouse@example.com',crypt('Password@123',gen_salt('bf')),'Warehouse'),
('Accounts User','accounts@example.com',crypt('Password@123',gen_salt('bf')),'Accounts')
ON CONFLICT (email) DO NOTHING;
INSERT INTO customers (name,mobile,email,business_name,gst_number,customer_type,status,address,follow_up_date,notes)
VALUES ('Ramesh Kumar','9876543210','ramesh@abc.com','ABC Retailers','24ABCDE1234F1Z5','Retail','Active','Vadodara, Gujarat',CURRENT_DATE + 7,'Priority customer');
INSERT INTO products (name,sku,category,unit_price,current_stock,min_stock_qty,warehouse_location)
VALUES ('Premium Notebook','NB-1001','Stationery',120,100,20,'WH-A1'),('Ball Pen Box','BP-2001','Stationery',250,50,10,'WH-A2'),('Packing Tape','PT-3001','Packaging',90,12,15,'WH-B1')
ON CONFLICT (sku) DO NOTHING;
