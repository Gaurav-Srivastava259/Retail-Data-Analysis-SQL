Create Database [Case Study Basic]
Use [Case Study Basic]

Select * from Customer
Select * from Prod_Cat_info
Select* from Transactions 

Ans 1- Select Count(customer_id) As Total_Num_Rows
     From Customer

Select Count(Prod_cat) As Total_Num_Rows
From Prod_cat_info

Select Count(Transaction_id) As Total_Num_Rows
From Transactions

Ans 2- Select Count(Transaction_id) As Total_Transactions
From Transactions Where Qty < 0

Ans 3 - Select *, 
Convert(date,tran_date,105) as Date1 
from Transactions

Ans 4-SELECT DATEDIFF(DAY, MIN(CONVERT(DATE, TRAN_DATE, 105)), MAX(CONVERT(DATE, TRAN_DATE, 105))) AS DIFF_DAYS, 
DATEDIFF(MONTH, MIN(CONVERT(DATE, TRAN_DATE, 105)), MAX(CONVERT(DATE, TRAN_DATE, 105))) AS DIFF_MONTHS,  
DATEDIFF(YEAR, MIN(CONVERT(DATE, TRAN_DATE, 105)), MAX(CONVERT(DATE, TRAN_DATE, 105))) AS DIFF_YEARS 
FROM TRANSACTIONS

Ans 5 - Select prod_cat
  From prod_cat_info
  where prod_subcat = 'DIY'

-- Data Analysis
Ans 1- Select count(Store_type)as count_store, Store_type
  From Transactions
  Group by Store_type
  Order by Count_store Desc

Ans 2 - SELECT GENDER, COUNT(CUSTOMER_ID) AS COUNT_GENDER
FROM CUSTOMER
WHERE GENDER IN ('M' , 'F')
GROUP BY GENDER

Ans 3 - SELECT
CITY_CODE, COUNT(CUSTOMER_ID) CUST_CNT
FROM CUSTOMER
GROUP BY CITY_CODE
ORDER BY CUST_CNT DESC

Ans 4 - SELECT COUNT(PROD_SUBCAT) AS SUBCAT_CNT
FROM PROD_CAT_INFO
WHERE PROD_CAT = 'BOOKS'
GROUP BY PROD_CAT

Ans 5 - Select MAX (QTY) As Max_Qty
From Transactions
Where QTY > 0

Ans 6 - SELECT PROD_CAT, SUM(TOTAL_AMT) AMOUNT
FROM TRANSACTIONS X
INNER JOIN PROD_CAT_INFO Y 
ON X.PROD_CAT_CODE = Y.PROD_CAT_CODE 
AND X.PROD_SUBCAT_CODE = Y.PROD_SUB_CAT_CODE
WHERE PROD_CAT IN ('BOOKS' , 'ELECTRONICS')
GROUP BY PROD_CAT

Ans 7 - Select cust_id AS Customer_id, COUNT(transaction_id) as Transaction_Count
From Transactions
WHERE Qty > 0
Group By cust_id
Having Count(transaction_id) > 10

Ans 8 - Select prod_cat, SUM(total_amt) as Total_Sales
 From Transactions as X
 INNER JOIN prod_cat_info as Y
 ON X.prod_cat_code = Y.prod_cat_code 
 AND X.prod_subcat_code = Y.prod_sub_cat_code
WHERE store_type = 'flagship store' and prod_cat in ('electronics', 'clothing')
GROUP BY prod_cat

Ans 9 - Select prod_cat, Gender, prod_subcat, SUM(total_amt) AS Total_Revenue
from Customer AS X
INNER JOIN Transactions AS Y
On X.customer_id = cust_id
INNER JOIN prod_cat_info AS Z
ON Y.prod_cat_code = Z.prod_cat_code AND Y.prod_subcat_code = Z.prod_sub_cat_code
Where Gender = 'M' and prod_cat = 'Electronics'
GROUP BY prod_subcat, prod_cat, Gender

Ans 10 - Select TOP 5 prod_subcat, Round(SUM(Cast(total_amt As Float)),2) as Total_Sales
From Transactions AS X
INNER JOIN prod_cat_info AS Y
ON X.prod_cat_code = Y.prod_cat_code 
AND X.prod_subcat_code = Y.prod_sub_cat_code
GROUP By prod_subcat
ORDER BY Total_Sales Desc

Ans 11 -SELECT customer_Id X, DATEDIFF(YEAR, DOB, tran_date) as [age], 
(SELECT ROUND(SUM(total_amt),2)) as total_revenue
from Transactions Y INNER JOIN Customer X
on X.customer_Id = Y.cust_id
WHERE DATEDIFF(YEAR, DOB, tran_date) between 25 and 35
GROUP BY customer_Id, DOB, tran_date
HAVING DATEDIFF(DAY, Y.tran_date, (SELECT MAX(tran_date) FROM Transactions)) <=30
ORDER BY [age]

ANS 12- SELECT TOP 1 prod_cat Z, 
SUM(CASE WHEN total_amt<0 THEN total_amt ELSE 0 END) [return value]
FROM Transactions Y 
INNER JOIN prod_cat_info Z 
on Y.prod_cat_code = Z.prod_cat_code
GROUP BY Z.prod_cat, tran_date
HAVING tran_date > DATEADD(month, -3, (SELECT MAX(tran_date) FROM Transactions))
ORDER BY [return value] ASC


ANS 13 - SELECT TOP 1 Store_type,
SUM(Qty) AS QTY_SOLD,
(SELECT ROUND(SUM(total_amt),2)) AS SALES_AMT
FROM Transactions
GROUP BY Store_type
ORDER BY SALES_AMT DESC, QTY_SOLD DESC


ANS 14 - SELECT prod_cat, AVG(total_amt) AS AVG_REVENUE
FROM Transactions Y 
INNER JOIN prod_cat_info Z 
on Y.prod_cat_code = Z.prod_cat_code 
GROUP BY prod_cat
HAVING AVG(total_amt) > (SELECT AVG(total_amt) FROM Transactions)

ANS 15 - SELECT prod_cat, prod_subcat, AVG(total_amt) AVG_REVENUE, SUM(total_amt) TOTAL_REVENUE
FROM Transactions Y 
INNER JOIN prod_cat_info Z 
ON Y.prod_cat_code = Z.prod_cat_code AND Y.prod_subcat_code = Z.prod_sub_cat_code
WHERE Z.prod_cat_code in
(SELECT TOP 5 prod_cat_code FROM Transactions 
GROUP BY prod_cat_code
ORDER BY (SELECT SUM(CASE WHEN Qty >0 THEN Qty ELSE 0 END)) DESC)
GROUP BY prod_cat, prod_subcat