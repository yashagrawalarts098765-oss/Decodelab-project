-- -------------------------------------------------------------
-- Creating database
-- -------------------------------------------------------------

create database ecommerce_db;
use ecommerce_db;

-- -------------------------------------------------------------
-- view data
-- -------------------------------------------------------------

SELECT * FROM ecommerce_db.cleaned_eco;

describe cleaned_eco;


-- changing date datatype from text to date


select `Date`,
str_to_date (`Date` , '%y/%m/%d') 
from cleaned_eco;

update cleaned_eco
SET `Date` = STR_TO_DATE(`Date`, '%d-%m-%Y');

alter table cleaned_eco
modify column `Date` date ;
-- -------------------------------------------------------------
-- High Value Order 
-- -------------------------------------------------------------

select * 
from cleaned_eco
where TotalPrice > 1000;

-- -------------------------------------------------------------
-- Specific Payment method
-- -------------------------------------------------------------

select * from cleaned_eco
where PaymentMethod = 'Credit Card';

-- -------------------------------------------------------------
-- Higher order first 
-- -------------------------------------------------------------

select * from cleaned_eco
order by TotalPrice desc;

-- -------------------------------------------------------------
-- Total Revenue
-- -------------------------------------------------------------

select round(sum(TotalPrice), 2) TotalRevenue
from cleaned_eco;

-- 1264761.96

-- -------------------------------------------------------------
-- Average Ordre value 
-- -------------------------------------------------------------

select round(avg(TotalPrice),2) avg_or_val
from cleaned_eco;

-- 1053.97

-- -------------------------------------------------------------
-- Orders count
-- -------------------------------------------------------------

select count(*) total_orders 
from cleaned_eco;

-- 1200

-- ------------------------------------------------------------
-- Revenue By Product
-- -------------------------------------------------------------

select Product , sum(TotalPrice) as revenue
from cleaned_eco
group by product 
order by revenue desc;

-- -------------------------------------------------------------
-- Total spending per customer
-- -------------------------------------------------------------

select CustomerID , sum(TotalPrice) as total_spent
from cleaned_eco 
group by CustomerID
order by total_spent desc;

-- -------------------------------------------------------------
-- number of orders per customer 
-- -------------------------------------------------------------

select customerID , count(*) as total_count
from cleaned_eco
group by CustomerID;

-- -------------------------------------------------------------
-- revenue By payment method
-- -------------------------------------------------------------

select PaymentMethod , sum(TotalPrice) as revenue
from cleaned_eco
group by PaymentMethod;

-- -------------------------------------------------------------
-- Most used payment method
-- -------------------------------------------------------------

select PaymentMethod, count(*) as usage_count
from cleaned_eco
group by PaymentMethod
order by usage_count desc; 

-- -------------------------------------------------------------
-- Order status count 
-- -------------------------------------------------------------

select OrderStatus , count(*) as total_orders
from cleaned_eco
group by OrderStatus;

-- -------------------------------------------------------------
-- coupon usage 
-- -------------------------------------------------------------

select CouponCode , count(*) as usage_count
from cleaned_eco
group by CouponCode;

-- -------------------------------------------------------------
-- Average Order value by Coupon 
-- -------------------------------------------------------------

select CouponCode , round(avg(TotalPrice), 2) as avg_or_val
from cleaned_eco
group by CouponCode;

-- -------------------------------------------------------------
-- Revenue by Source
-- -------------------------------------------------------------

select ReferralSource , sum(TotalPrice) as rev
from cleaned_eco
group by ReferralSource;


-- -------------------------------------------------------------
-- Monthly sales 
-- -------------------------------------------------------------

select month(`Date`) as mon , sum(TotalPrice) as sales 
from cleaned_eco
group by mon
order by mon;

-- -------------------------------------------------------------
-- top 5 customers 
-- -------------------------------------------------------------

select CustomerID , sum(TotalPrice) as t
from cleaned_eco
group by CustomerID 
order by t desc
limit 5;


-- -------------------------------------------------------------
-- Top selling products 
-- -------------------------------------------------------------

select Product , sum(Quantity) as sold
from cleaned_eco
group by Product 
order by sold desc 
limit 10;

-- -------------------------------------------------------------
-- products with revenue > 5000
-- -------------------------------------------------------------

select Product , sum(TotalPrice) as rev
from cleaned_eco
group by Product 
having rev >5000;
