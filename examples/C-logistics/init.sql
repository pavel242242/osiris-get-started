-- Initialize the logistics database with sample data

-- Create shipments table (bronze layer)
CREATE TABLE IF NOT EXISTS shipments_bronze (
    shipment_id VARCHAR(50) PRIMARY KEY,
    order_date DATE NOT NULL,
    customer_id VARCHAR(50) NOT NULL,
    origin VARCHAR(100) NOT NULL,
    destination VARCHAR(100) NOT NULL,
    weight_kg DECIMAL(10,2) NOT NULL,
    status VARCHAR(50) NOT NULL,
    carrier VARCHAR(50) NOT NULL,
    tracking_number VARCHAR(100) NOT NULL
);

-- Create customers table (bronze layer)
CREATE TABLE IF NOT EXISTS customers_bronze (
    customer_id VARCHAR(50) PRIMARY KEY,
    customer_name VARCHAR(255) NOT NULL,
    customer_type VARCHAR(50) NOT NULL,
    registration_date DATE NOT NULL,
    account_status VARCHAR(50) NOT NULL,
    credit_limit DECIMAL(10,2) NOT NULL
);

-- Create shipping costs table (bronze layer)
CREATE TABLE IF NOT EXISTS shipping_costs (
    id SERIAL PRIMARY KEY,
    carrier VARCHAR(50) NOT NULL,
    weight_tier VARCHAR(20) NOT NULL,
    base_cost DECIMAL(10,2) NOT NULL,
    cost_per_kg DECIMAL(10,2) NOT NULL
);

-- Insert shipments data
INSERT INTO shipments_bronze (shipment_id, order_date, customer_id, origin, destination, weight_kg, status, carrier, tracking_number) VALUES
('SH001', '2024-01-15', 'C101', 'New York', 'Los Angeles', 25.5, 'delivered', 'FedEx', 'FDX123456'),
('SH002', '2024-01-16', 'C102', 'Chicago', 'Miami', 15.2, 'delivered', 'UPS', 'UPS789012'),
('SH003', '2024-01-17', 'C103', 'Seattle', 'Boston', 32.1, 'in_transit', 'DHL', 'DHL345678'),
('SH004', '2024-01-18', 'C101', 'Dallas', 'Atlanta', 18.7, 'delivered', 'FedEx', 'FDX234567'),
('SH005', '2024-01-19', 'C104', 'Phoenix', 'Denver', 22.3, 'delivered', 'UPS', 'UPS890123'),
('SH006', '2024-01-20', 'C105', 'Portland', 'Houston', 28.9, 'in_transit', 'FedEx', 'FDX345678'),
('SH007', '2024-01-21', 'C102', 'San Francisco', 'New York', 35.4, 'delivered', 'DHL', 'DHL456789'),
('SH008', '2024-01-22', 'C106', 'Austin', 'Seattle', 19.8, 'delivered', 'UPS', 'UPS901234'),
('SH009', '2024-01-23', 'C103', 'Boston', 'Chicago', 24.6, 'cancelled', 'FedEx', 'FDX456789'),
('SH010', '2024-01-24', 'C107', 'Miami', 'Portland', 31.2, 'delivered', 'DHL', 'DHL567890'),
('SH011', '2024-01-25', 'C101', 'Los Angeles', 'Dallas', 27.3, 'delivered', 'FedEx', 'FDX567890'),
('SH012', '2024-01-26', 'C108', 'Denver', 'Phoenix', 16.5, 'in_transit', 'UPS', 'UPS012345');

-- Insert customers data
INSERT INTO customers_bronze (customer_id, customer_name, customer_type, registration_date, account_status, credit_limit) VALUES
('C101', 'Acme Corp', 'enterprise', '2023-01-15', 'active', 50000),
('C102', 'Best Buy LLC', 'enterprise', '2023-02-20', 'active', 75000),
('C103', 'Corner Store', 'small_business', '2023-03-10', 'active', 10000),
('C104', 'Delta Industries', 'enterprise', '2023-04-05', 'active', 100000),
('C105', 'Echo Retail', 'small_business', '2023-05-12', 'active', 15000),
('C106', 'Fusion Co', 'enterprise', '2023-06-18', 'active', 60000),
('C107', 'Global Goods', 'small_business', '2023-07-22', 'inactive', 5000),
('C108', 'Harbor Trading', 'enterprise', '2023-08-30', 'active', 80000);

-- Insert shipping costs data
INSERT INTO shipping_costs (carrier, weight_tier, base_cost, cost_per_kg) VALUES
('FedEx', '0-20', 15.00, 1.50),
('FedEx', '20-30', 20.00, 1.25),
('FedEx', '30+', 25.00, 1.00),
('UPS', '0-20', 14.00, 1.40),
('UPS', '20-30', 19.00, 1.20),
('UPS', '30+', 24.00, 0.95),
('DHL', '0-20', 16.00, 1.60),
('DHL', '20-30', 21.00, 1.30),
('DHL', '30+', 26.00, 1.05);

-- Create indexes for better query performance
CREATE INDEX idx_shipments_customer_id ON shipments_bronze(customer_id);
CREATE INDEX idx_shipments_status ON shipments_bronze(status);
CREATE INDEX idx_shipments_carrier ON shipments_bronze(carrier);
CREATE INDEX idx_customers_account_status ON customers_bronze(account_status);
CREATE INDEX idx_shipping_costs_carrier_tier ON shipping_costs(carrier, weight_tier);
