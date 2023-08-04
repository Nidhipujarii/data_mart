# Data Mart Project

***Project Overview***
This Data Mart project aims to provide insights into weekly sales data, including sales figures, transactions, and customer demographics. The data has been cleaned and transformed to facilitate easy analysis.

***CONTENTS***

***Data Cleaning***

- The original weekly_sales table has been transformed into clean_weekly_sales1 with the following additional columns:

    - week_number: The week number extracted from the week_date.
    - month_number: The month number extracted from the week_date.
    - calendar_year: The year extracted from the week_date.
    - segment: The customer segment. Null values have been replaced with 'unknown'.
    - age_band: A new column derived from the original segment, categorizing customers based on their age.
    - demographic: A new column specifying whether the customer belongs to 'couples', 'families', or 'unknown'.
    - avg_transaction: A new column representing the average transaction value.

***Missing Week Numbers***
- To identify missing week numbers in the dataset, a sequence table seq100 has been created to generate a sequence of numbers from 1 to 100. This sequence is used to create another table seq52 with numbers from 1 to 52, representing the weeks in a year. A query is used to find the week numbers that are not present in the clean_weekly_sales1 table.

***Total Sales by Region and Month***
- The query calculates the total sales for each region and month, providing valuable insights into sales trends across regions over time.

***Total Transactions by Platform***
- This query shows the total count of transactions for each platform, helping to understand transaction distribution across different platforms.

***Percentage of Sales for Retail vs. Shopify***
- The query calculates the percentage of sales for the 'Retail' and 'Shopify' platforms for each month, highlighting the contribution of each platform to the overall sales.

***Percentage of Sales by Demographic***
- This query provides the percentage of sales attributed to different demographics for each year in the dataset.

***Top Age Band and Demographic Contributors to Retail Sales***
- The query identifies the age band and demographic values that contribute the most to 'Retail' sales, enabling a deeper understanding of customer preferences and behavior.

