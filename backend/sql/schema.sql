CREATE TABLE IF NOT EXISTS users (
 id SERIAL PRIMARY KEY,
 name VARCHAR(120) NOT NULL,
 email VARCHAR(180) UNIQUE NOT NULL,
 password_hash TEXT NOT NULL,
 role VARCHAR(20) NOT NULL CHECK (role IN ('Admin','Sales','Warehouse','Accounts')),
 created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE TABLE IF NOT EXISTS customers (
 id SERIAL PRIMARY KEY,
 name VARCHAR(160) NOT NULL,
 mobile VARCHAR(30) NOT NULL,
 email VARCHAR(180),
 business_name VARCHAR(180) NOT NULL,
 gst_number VARCHAR(30),
 customer_type VARCHAR(30) NOT NULL CHECK (customer_type IN ('Retail','Wholesale','Distributor')),
 address TEXT NOT NULL,
 status VARCHAR(20) NOT NULL DEFAULT 'Lead' CHECK (status IN ('Lead','Active','Inactive')),
 follow_up_date DATE,
 notes TEXT,
 created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(), updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE TABLE IF NOT EXISTS products (
 id SERIAL PRIMARY KEY,
 name VARCHAR(180) NOT NULL,
 sku VARCHAR(80) UNIQUE NOT NULL,
 category VARCHAR(100) NOT NULL,
 unit_price NUMERIC(12,2) NOT NULL CHECK (unit_price >= 0),
 current_stock INTEGER NOT NULL DEFAULT 0 CHECK (current_stock >= 0),
 min_stock_qty INTEGER NOT NULL DEFAULT 0 CHECK (min_stock_qty >= 0),
 warehouse_location VARCHAR(120) NOT NULL,
 created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(), updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE TABLE IF NOT EXISTS stock_movements (
 id SERIAL PRIMARY KEY,
 product_id INTEGER NOT NULL REFERENCES products(id),
 quantity_changed INTEGER NOT NULL,
 movement_type VARCHAR(3) NOT NULL CHECK (movement_type IN ('IN','OUT')),
 reason VARCHAR(255) NOT NULL,
 created_by INTEGER NOT NULL REFERENCES users(id),
 created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE TABLE IF NOT EXISTS challans (
 id SERIAL PRIMARY KEY,
 challan_number VARCHAR(40) UNIQUE NOT NULL,
 customer_id INTEGER NOT NULL REFERENCES customers(id),
 total_quantity INTEGER NOT NULL DEFAULT 0,
 total_value NUMERIC(14,2) NOT NULL DEFAULT 0,
 status VARCHAR(20) NOT NULL DEFAULT 'Draft' CHECK (status IN ('Draft','Confirmed','Cancelled')),
 created_by INTEGER NOT NULL REFERENCES users(id),
 created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE TABLE IF NOT EXISTS challan_items (
 id SERIAL PRIMARY KEY,
 challan_id INTEGER NOT NULL REFERENCES challans(id) ON DELETE CASCADE,
 product_id INTEGER NOT NULL REFERENCES products(id),
 product_name VARCHAR(180) NOT NULL,
 sku VARCHAR(80) NOT NULL,
 unit_price NUMERIC(12,2) NOT NULL,
 quantity INTEGER NOT NULL CHECK (quantity > 0)
);
CREATE INDEX IF NOT EXISTS idx_customers_search ON customers(name, mobile, business_name);
CREATE INDEX IF NOT EXISTS idx_products_sku ON products(sku);
CREATE INDEX IF NOT EXISTS idx_stock_movements_product ON stock_movements(product_id);
