-- SQL Server schema
CREATE TABLE customers (
    customer_id VARCHAR(20) PRIMARY KEY,
    segment VARCHAR(30),
    region VARCHAR(30),
    acquisition_channel VARCHAR(30),
    plan VARCHAR(20),
    signup_date DATE,
    status VARCHAR(20),
    churn_date DATE NULL,
    churn_reason VARCHAR(50) NULL
);

CREATE TABLE orders (
    order_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20),
    order_date DATE,
    product_category VARCHAR(50),
    gross_amount DECIMAL(12,2),
    discount_pct DECIMAL(5,2),
    net_amount DECIMAL(12,2),
    order_status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE customer_engagement (
    customer_id VARCHAR(20),
    month DATE,
    sessions INT,
    support_tickets INT,
    active_flag BIT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
