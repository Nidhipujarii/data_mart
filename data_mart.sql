use case1;
select * from weekly_sales limit 10;

-- data cleaning
-- Adding week_number, month_number and calendar_year columns 

create table clean_weekly_sales1 as
select week_date,
week(week_date) as 'week_number',
month(week_date) as 'month_number',
year(week_date) as 'calendar_year',
region, platform,
-- handling nulls
case
    when segment = null then 'unknown'
    else segment
    end as segment,
	
-- Adding a new column called age_band after the original segment
case 
    when right(segment,1) = '1' then 'young_adults'
	when right(segment,1) = '2' then 'middle aged'
	when right(segment,1) in ('3','4')  then 'retires'
    else 'unknown'
    end as age_band,
	
-- adding demographic column to specify couples and families
case
    when left(segment,1) = 'C' then 'couples'
    when left(segment,1) = 'F' then 'families'
    else 'unknown'
    end as demographic,
customer_type, transactions, sales,
	
-- Generate a new avg_transaction column as the sales value divided
-- by transactions rounded to 2 decimal places
round(sales/transactions,2) as 'avg_transaction'
from weekly_sales;
 
 select * from clean_weekly_sales1 limit 10;

-- Which week numbers are missing from the dataset?

create table seq100
(x int not null auto_increment primary key);
insert into seq100 values (),(),(),(),(),(),(),(),(),();
insert into seq100 values (),(),(),(),(),(),(),(),(),();
insert into seq100 values (),(),(),(),(),(),(),(),(),();
insert into seq100 values (),(),(),(),(),(),(),(),(),();
insert into seq100 values (),(),(),(),(),(),(),(),(),();
insert into seq100 select x + 50 from seq100;
select * from seq100;
create table seq52 as (select x from seq100 limit 52);
select distinct x as week_day from seq52 where x not in(select distinct week_number from clean_weekly_sales); 
select calendar_year, sum(transactions) as total_transactions
from clean_weekly_sales1
group by calendar_year;
select * from clean_weekly_sales1 limit 10;

-- What are the total sales for each region for each month? 

select sum(sales) as total_sales, region, month_number
from clean_weekly_sales1
group by region, month_number;

-- How many total transactions were there for each year in the dataset?

select platform, count(transactions)
from clean_weekly_sales1
group by platform;

-- What is the total count of transactions for each platform

select paltform, sum(transcactions) as total_transactions from clean_weekly_sales;

-- What is the percentage of sales for Retail vs Shopify for each month?

WITH cte_monthly_platform_sales AS (
  SELECT
    month_number,calendar_year,
    platform,
    SUM(sales) AS monthly_sales
  FROM clean_weekly_sales
  GROUP BY month_number,calendar_year, platform
)
SELECT
  month_number,calendar_year,
  ROUND(
    100 * MAX(CASE WHEN platform = 'Retail' THEN monthly_sales ELSE NULL END) /
      SUM(monthly_sales),
    2
  ) AS retail_percentage,
  ROUND(
    100 * MAX(CASE WHEN platform = 'Shopify' THEN monthly_sales ELSE NULL END) /
      SUM(monthly_sales),
    2
  ) AS shopify_percentage
FROM cte_monthly_platform_sales
GROUP BY month_number,calendar_year
ORDER BY month_number,calendar_year;

-- What is the percentage of sales by demographic for each year in the dataset?

SELECT
  calendar_year,
  demographic,
  SUM(SALES) AS yearly_sales,
  ROUND(
    (
      100 * SUM(sales)/
        SUM(SUM(SALES)) OVER (PARTITION BY demographic)
    ),
    2
  ) AS percentage
FROM clean_weekly_sales
GROUP BY
  calendar_year,
  demographic
ORDER BY
  calendar_year,
  demographic;
  
-- Which age_band and demographic values contribute the most to Retail sales?

SELECT
  age_band,
  demographic,
  SUM(sales) AS total_sales
FROM clean_weekly_sales
WHERE platform = 'Retail'
GROUP BY age_band, demographic
ORDER BY total_sales DESC;




select * from weekly_sales limit 10;
create view view2 AS 
select count(platform) as platform, region
from weekly_sales
group by region;

select * from view2;


