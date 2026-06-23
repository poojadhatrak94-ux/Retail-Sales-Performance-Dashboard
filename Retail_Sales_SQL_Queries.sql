-- Query 1: View First 10 Records

SELECT *
FROM `pooja-data-analytics.retail_analytics.retail_sales_orders`
LIMIT 10;

-- Query 2: Total Sales

SELECT
    SUM(Sales) AS Total_Sales
FROM `pooja-data-analytics.retail_analytics.retail_sales_orders`;

-- Query 3: Total Profit

SELECT
    SUM(Profit) AS Total_Profit
FROM `pooja-data-analytics.retail_analytics.retail_sales_orders`;

-- Query 4: Sales by Region

SELECT
    Region,
    SUM(Sales) AS Total_Sales
FROM `pooja-data-analytics.retail_analytics.retail_sales_orders`
GROUP BY Region
ORDER BY Total_Sales DESC;

-- Query 5: Profit by Region

SELECT
    Region,
    SUM(Profit) AS Total_Profit
FROM `pooja-data-analytics.retail_analytics.retail_sales_orders`
GROUP BY Region
ORDER BY Total_Profit DESC;

-- Query 6: Category Performance

SELECT
    Category,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM `pooja-data-analytics.retail_analytics.retail_sales_orders`
GROUP BY Category
ORDER BY Total_Sales DESC;

-- Query 7: Top 10 Customers by Sales

SELECT
    `Customer Name`,
    SUM(Sales) AS Total_Sales
FROM `pooja-data-analytics.retail_analytics.retail_sales_orders`
GROUP BY `Customer Name`
ORDER BY Total_Sales DESC
LIMIT 10;

-- Query 8: Top 10 Products by Sales

SELECT
    `Product Name`,
    SUM(Sales) AS Total_Sales
FROM `pooja-data-analytics.retail_analytics.retail_sales_orders`
GROUP BY `Product Name`
ORDER BY Total_Sales DESC
LIMIT 10;

-- Query 9: Discount vs Profit

SELECT
    Discount,
    SUM(Profit) AS Total_Profit
FROM `pooja-data-analytics.retail_analytics.retail_sales_orders`
GROUP BY Discount
ORDER BY Discount;

-- Query 10: Products with Loss

SELECT
    `Product Name`,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM `pooja-data-analytics.retail_analytics.retail_sales_orders`
GROUP BY `Product Name`
HAVING Total_Profit < 0
ORDER BY Total_Profit ASC;

-- Query 11: Profit Status using CASE WHEN

SELECT
    CASE
        WHEN Profit > 0 THEN 'Profit'
        WHEN Profit < 0 THEN 'Loss'
        ELSE 'No Profit No Loss'
    END AS Profit_Status,
    COUNT(*) AS Total_Orders,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM `pooja-data-analytics.retail_analytics.retail_sales_orders`
GROUP BY Profit_Status
ORDER BY Total_Profit DESC;

-- Query 11: Profit Status using CASE WHEN

SELECT
    CASE
        WHEN Profit > 0 THEN 'Profit'
        WHEN Profit < 0 THEN 'Loss'
        ELSE 'No Profit No Loss'
    END AS Profit_Status,
    COUNT(*) AS Total_Orders,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM `pooja-data-analytics.retail_analytics.retail_sales_orders`
GROUP BY Profit_Status
ORDER BY Total_Profit DESC;


-- Query 12: Top Customers using RANK

SELECT
    Customer_Name,
    Total_Sales,
    RANK() OVER (ORDER BY Total_Sales DESC) AS Sales_Rank
FROM (
    SELECT
        `Customer Name` AS Customer_Name,
        SUM(Sales) AS Total_Sales
    FROM `pooja-data-analytics.retail_analytics.retail_sales_orders`
    GROUP BY `Customer Name`
)
ORDER BY Sales_Rank
LIMIT 10;

-- Query 13: Region Performance using CTE

WITH Region_Performance AS (
    SELECT
        Region,
        SUM(Sales) AS Total_Sales,
        SUM(Profit) AS Total_Profit
    FROM `pooja-data-analytics.retail_analytics.retail_sales_orders`
    GROUP BY Region
)
SELECT
    Region,
    Total_Sales,
    Total_Profit
FROM Region_Performance
ORDER BY Total_Sales DESC;