--Rating_cabang
SELECT 
    branch_id,
    branch_category,
    branch_name,
    kota,
    provinsi,
    rating AS rating_cabang
FROM 
    `kimia_farma.kf_kantor_cabang`
ORDER BY 
    rating_cabang DESC;

--Customer_name
SELECT 
 transaction_id,
 customer_name,
 product_id,
 price
FROM 
    `kimia_farma.kf_final_transaction`

--Product_id dan product_name
SELECT
    product_id,
    product_name
FROM
    `kimia_farma.kf_inventory`

--Actual_price
SELECT
    product_id,
    product_name,
    price AS actual_price
FROM
    `kimia_farma.kf_product`

--Discount_percentage
SELECT
    transaction_id,
    customer_name,
    product_id,
    discount_percentage
FROM
    `kimia_farma.kf_final_transaction`
WHERE
    discount_percentage > 0.1;

--Persentase_gross_laba
SELECT 
    transaction_id,
    date,
    branch_id,
    customer_name,
    product_id,
    price,
    discount_percentage,
    rating,
    CASE
        WHEN price <= 50000 THEN '10%'
        WHEN price > 50000 AND price <= 100000 THEN '15%'
        WHEN price > 100000 AND price <= 300000 THEN '20%'
        WHEN price > 300000 AND price <= 500000 THEN '25%'
        WHEN price > 500000 THEN '30%'
    END AS persentase_gross_laba
FROM 
    `kimia_farma.kf_final_transaction`
WHERE
    price > 50000;

--Nett_sales
SELECT 
    transaction_id, 
    customer_name, 
    product_id, 
    price, 
    discount_percentage,
    CASE 
        WHEN price <= 50000 THEN 0.10
        WHEN price > 50000 AND price <= 100000 THEN 0.15
        WHEN price > 100000 AND price <= 300000 THEN 0.20
        WHEN price > 300000 AND price <= 500000 THEN 0.25
        ELSE 0.30
    END AS persentase_gross_laba,
    price * (1 - discount_percentage) AS nett_sales
FROM 
    `kimia_farma.kf_final_transaction`
WHERE
    price > 50000;

--Nett_profit
SELECT 
    transaction_id,  
    customer_name, 
    product_id, 
    price, 
    discount_percentage, 
    CASE 
        WHEN price <= 50000 THEN 0.10
        WHEN price > 50000 AND price <= 100000 THEN 0.15
        WHEN price > 100000 AND price <= 300000 THEN 0.20
        WHEN price > 300000 AND price <= 500000 THEN 0.25
        ELSE 0.30
    END AS persentase_gross_laba,
    price * (1 - discount_percentage) AS net_sales,
    (price * (1 - discount_percentage)) * 
    CASE 
        WHEN price <= 50000 THEN 0.10
        WHEN price > 50000 AND price <= 100000 THEN 0.15
        WHEN price > 100000 AND price <= 300000 THEN 0.20
        WHEN price > 300000 AND price <= 500000 THEN 0.25
        ELSE 0.30
    END AS nett_profit
FROM 
    `kimia_farma.kf_final_transaction`
WHERE
    price > 50000;

--Rating_transaksi
SELECT 
    transaction_id, 
    date, 
    branch_id, 
    customer_name, 
    product_id, 
    price, 
    discount_percentage, 
    rating,
    CASE 
        WHEN price <= 50000 THEN 0.10
        WHEN price > 50000 AND price <= 100000 THEN 0.15
        WHEN price > 100000 AND price <= 300000 THEN 0.20
        WHEN price > 300000 AND price <= 500000 THEN 0.25
        ELSE 0.30
    END AS persentase_gross_laba,
    price * (1 - discount_percentage) AS net_sales,
    (price * (1 - discount_percentage)) * 
    CASE 
        WHEN price <= 50000 THEN 0.10
        WHEN price > 50000 AND price <= 100000 THEN 0.15
        WHEN price > 100000 AND price <= 300000 THEN 0.20
        WHEN price > 300000 AND price <= 500000 THEN 0.25
        ELSE 0.30
    END AS nett_profit,
    CASE 
        WHEN rating >= 4.5 THEN 'Excellent'
        WHEN rating >= 3.5 THEN 'Good'
        WHEN rating >= 2.5 THEN 'Average'
        WHEN rating >= 1.5 THEN 'Below Average'
        ELSE 'Poor'
    END AS rating_transaksi
FROM 
    `kimia_farma.kf_final_transaction`
WHERE
    price > 50000;
