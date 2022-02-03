/*Schema SQL Query SQL ResultsEdit on DB Fiddle
CREATE SCHEMA dannys_diner;
SET search_path = dannys_diner;

CREATE TABLE sales (
  "customer_id" VARCHAR(1),
  "order_date" DATE,
  "product_id" INTEGER
);

INSERT INTO sales
  ("customer_id", "order_date", "product_id")
VALUES
  ('A', '2021-01-01', '1'),
  ('A', '2021-01-01', '2'),
  ('A', '2021-01-07', '2'),
  ('A', '2021-01-10', '3'),
  ('A', '2021-01-11', '3'),
  ('A', '2021-01-11', '3'),
  ('B', '2021-01-01', '2'),
  ('B', '2021-01-02', '2'),
  ('B', '2021-01-04', '1'),
  ('B', '2021-01-11', '1'),
  ('B', '2021-01-16', '3'),
  ('B', '2021-02-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-07', '3');
 

CREATE TABLE menu (
  "product_id" INTEGER,
  "product_name" VARCHAR(5),
  "price" INTEGER
);

INSERT INTO menu
  ("product_id", "product_name", "price")
VALUES
  ('1', 'sushi', '10'),
  ('2', 'curry', '15'),
  ('3', 'ramen', '12');
  

CREATE TABLE members (
  "customer_id" VARCHAR(1),
  "join_date" DATE
);

INSERT INTO members
  ("customer_id", "join_date")
VALUES
  ('A', '2021-01-07'),
  ('B', '2021-01-09');*/
  
  
  /*Case Study Questions
What is the total amount each customer spent at the restaurant?
How many days has each customer visited the restaurant?
What was the first item from the menu purchased by each customer?
What is the most purchased item on the menu and how many times was it purchased by all customers?
Which item was the most popular for each customer?
Which item was purchased first by the customer after they became a member?
Which item was purchased just before the customer became a member?
What is the total items and amount spent for each member before they became a member?
If each $1 spent equates to 10 points and sushi has a 2x points multiplier — how many points would each customer have?
In the first week after a customer joins the program (including their join date) they earn 2x points on all items, 
not just sushi — how many points do customer A and B have at the end of January?*/

/*1st Answer */
SELECT SUM(M.PRICE) FROM SALES S , MENU M 
WHERE S.PRODUCT_ID = M.PRODUCT_ID
GROUP BY S.CUSTOMER_ID;

/*2nd Answer*/
SELECT CUSTOMER_ID , COUNT(DISTINCT ORDER_DATE) FROM SALES GROUP BY CUSTOMER_ID;

/*3rd customer*/
WITH CTE AS (SELECT CUSTOMER_ID , ORDER_DATE , PRODUCT_NAME , DENSE_RANK()
 OVER (PARTITION BY CUSTOMER_ID ORDER BY ORDER_DATE ) AS RNK 
 FROM SALES S JOIN MENU M ON S.PRODUCT_ID = M.PRODUCT_ID)
 SELECT CUSTOMER_ID , PRODUCT_NAME 
 FROM CTE WHERE RNK = 1 
 GROUP BY CUSTOMER_ID, PRODUCT_NAME;
 
 /*4th Answer*/
WITH CTE AS (
SELECT PRODUCT_ID , COUNT(*) AS "COUNT_ITEMS"
FROM SALES
GROUP BY PRODUCT_ID )
SELECT M.PRODUCT_NAME , MAX(C.COUNT_ITEMS) 
FROM CTE C , MENU M 
WHERE C.PRODUCT_ID = M.PRODUCT_ID ;

/*5th Answer*/
WITH CTE AS (
SELECT S.CUSTOMER_ID , M.PRODUCT_NAME ,
COUNT(M.PRODUCT_ID) AS CNT,
DENSE_RANK() OVER (PARTITION BY S.CUSTOMER_ID ORDER BY COUNT(M.PRODUCT_ID) DESC ) RNK
FROM SALES S , MENU M 
WHERE S.PRODUCT_ID = M.PRODUCT_ID 
GROUP BY S.CUSTOMER_ID , M.PRODUCT_NAME )
SELECT CUSTOMER_ID , PRODUCT_NAME  , CNT
FROM CTE WHERE RNK =1 

/*6th Answer*/
WITH CTE AS ( SELECT S.* , DENSE_RANK() OVER (PARTITION BY CUSTOMER_ID ORDER BY ORDER_DATE) RNK
FROM 
SALES S  , MEMBERS M 
WHERE M.CUSTOMER_ID = S.CUSTOMER_ID 
AND S.ORDER_DATE >= M.JOIN_DATE )
SELECT CUSTOMER_ID , ORDER_DATE , M.PRODUCT_NAME
FROM CTE C , MENU M 
WHERE M.PRODUCT_ID = C.PRODUCT_ID
AND RNK = 1

/*7th Answer*/

WITH CTE AS ( SELECT S.* , DENSE_RANK() OVER (PARTITION BY CUSTOMER_ID ORDER BY ORDER_DATE desc) RNK
FROM 
SALES S  , MEMBERS M 
WHERE M.CUSTOMER_ID = S.CUSTOMER_ID 
AND S.ORDER_DATE < M.JOIN_DATE )
SELECT CUSTOMER_ID , ORDER_DATE , M.PRODUCT_NAME
FROM CTE C , MENU M 
WHERE M.PRODUCT_ID = C.PRODUCT_ID
AND RNK = 1

/*8th Answer*/
SELECT S.CUSTOMER_ID , COUNT(DISTINCT S.PRODUCT_ID) , SUM(MM.PRICE)
FROM SALES S , MEMBERS M , MENU MM
WHERE S.ORDER_DATE < M.JOIN_DATE
AND S.CUSTOMER_ID = M.CUSTOMER_ID 
AND S.PRODUCT_ID = MM.PRODUCT_ID 
GROUP BY S.CUSTOMER_ID

/*9th Answer*/
SELECT S.CUSTOMER_ID , SUM( CASE WHEN LOWER(PRODUCT_NAME) = 'sushi' THEN PRICE * 20 ELSE PRICE * 10  END) "DOLLAR"
FROM SALES S , MENU M 
WHERE S.PRODUCT_ID = M.PRODUCT_ID  
GROUP BY S.CUSTOMER_ID

/*10th Answer*/
 WITH CTE AS (
SELECT M.* , DATE_ADD(JOIN_DATE , INTERVAL 6 DAY) VALID_DATE,
STR_TO_DATE('2021-01-31','%Y-%m-%d') AS LAST_DATE
FROM MEMBERS)
SELECT CTE.customer_id, s.order_date, CTE.join_date, 
 CTE.valid_date, CTE.last_date, m.product_name, m.price,
, SUM (CASE WHEN M.PRODUCT_NAME = 'sushi' THEN 2 * 10 * M.PRICE 
     WHEN S.ORDER_DATE BETWEEEN CTE.JOIN_DATE AND CTE.VALID_DATE THEN 2 * 10 * M.PRICE
     ELSE 10* M.PRICE
     END) AS POINTS
FROM CTE 
JOIN SALES S
ON CTE.CUSTOMER_ID = S.CUSTOMER_ID
JOIN MENU M
ON S.PRODUCT_ID = M.PRODUCT_ID 
WHERE S.ORDER_DATE < CTE.LAST_DATE 
GROUP BY CTE.customer_id, s.order_date, CTE.join_date, 
 CTE.valid_date, CTE.last_date, m.product_name, m.price





