
--Total Revenue

SELECT SUM(total_price) AS Total_Revenue
FROM dbo.pizza_sales

--Average Order Value

SELECT SUM(total_price) AS Total_Revenue, COUNT(DISTINCT(order_id)) AS Total_Order
, (SUM(total_price)/COUNT(DISTINCT(order_id))) AS Average_Order_Value
FROM pizza_sales

SELECT 
 (SUM(total_price)/COUNT(DISTINCT(order_id))) AS Average_Order_Value
FROM pizza_sales

--Total Pizzas Sold


SELECT SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales


--Total Order Placed

SELECT COUNT(DISTINCT order_id) AS Total_Order_Placed
FROM pizza_sales


--Average Pizzas Per Order

SELECT CAST(CAST(SUM(quantity)AS Decimal(10,2))/CAST(COUNT(DISTINCT order_id)AS Decimal(10,2)) AS decimal(10,2)) AS Average_Pizza_Per_Order
FROM pizza_sales



--Hourly Trend for Total Orders

SELECT DATEPART(HOUR, order_time) AS Order_Hour, COUNT(DISTINCT order_id) AS Total_Order
FROM pizza_sales
GROUP BY DATEPART(HOUR, order_time)
ORDER BY DATEPART(HOUR, order_time)

--Daily Trend for Total Orders

SELECT DATENAME(DW, order_date) AS Order_Day, COUNT(DISTINCT order_id) AS Total_Daily_Orders
FROM pizza_sales
GROUP BY DATENAME(DW, order_date)
ORDER BY Total_Daily_Orders desc

--Monthly Trend for Total Orders

SELECT DATENAME(MONTH, order_date) AS Month_Name, COUNT(DISTINCT order_id) AS Total_Monthly_Orders
FROM pizza_sales
GROUP BY DATENAME(MONTH, order_date)
ORDER BY Total_Monthly_Orders desc


--Percentage of Sales by Pizza Category

SELECT pizza_category, SUM(total_price) AS Total_Sales, SUM(total_price) * 100 
/ (SELECT (SUM(total_price) FROM pizza_sales AS WHERE MONTH(order_date) = 1) 
AS Percent_Sales_by_Category
FROM pizza_sales
WHERE MONTH(order_date) = 1
GROUP BY pizza_category


--Percentage of Sales by Pizza Size

SELECT pizza_size, CAST(SUM(total_price) AS decimal(10,2)) AS Total_Sales, CAST(SUM(total_price) * 100 
/ (SELECT SUM(total_price) FROM pizza_sales WHERE DATEPART(QUARTER, order_date) =1 ) AS decimal(10,2))
AS Percent_Sales_by_Pizza_Size
FROM pizza_sales
WHERE DATEPART(QUARTER, order_date) =1 
GROUP BY pizza_size
ORDER BY Percent_Sales_by_Pizza_Size desc


--Top 5 Best Sellers by Revenue, Total Quantity and Total Orders

SELECT TOP 5 pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
Order BY Total_Revenue DESC


SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Quantity
FROM pizza_sales
GROUP BY pizza_name
Order BY Total_Quantity DESC


SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
Order BY Total_Orders DESC


--Bottom 5 Worse Sellers by Revenue, Total Quantity and Total Orders


SELECT TOP 5 pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
Order BY Total_Revenue ASC




SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Quantity
FROM pizza_sales
GROUP BY pizza_name
Order BY Total_Quantity ASC


SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
Order BY Total_Orders ASC

