/*Schema SQL Query SQL ResultsEdit on DB Fiddle
CREATE SCHEMA pizza_runner;
SET search_path = pizza_runner;

DROP TABLE IF EXISTS runners;
CREATE TABLE runners (
  "runner_id" INTEGER,
  "registration_date" DATE
);
INSERT INTO runners
  ("runner_id", "registration_date")
VALUES
  (1, '2021-01-01'),
  (2, '2021-01-03'),
  (3, '2021-01-08'),
  (4, '2021-01-15');


DROP TABLE IF EXISTS customer_orders;
CREATE TABLE customer_orders (
  "order_id" INTEGER,
  "customer_id" INTEGER,
  "pizza_id" INTEGER,
  "exclusions" VARCHAR(4),
  "extras" VARCHAR(4),
  "order_time" TIMESTAMP
);

INSERT INTO customer_orders
  ("order_id", "customer_id", "pizza_id", "exclusions", "extras", "order_time")
VALUES
  ('1', '101', '1', '', '', '2020-01-01 18:05:02'),
  ('2', '101', '1', '', '', '2020-01-01 19:00:52'),
  ('3', '102', '1', '', '', '2020-01-02 23:51:23'),
  ('3', '102', '2', '', NULL, '2020-01-02 23:51:23'),
  ('4', '103', '1', '4', '', '2020-01-04 13:23:46'),
  ('4', '103', '1', '4', '', '2020-01-04 13:23:46'),
  ('4', '103', '2', '4', '', '2020-01-04 13:23:46'),
  ('5', '104', '1', 'null', '1', '2020-01-08 21:00:29'),
  ('6', '101', '2', 'null', 'null', '2020-01-08 21:03:13'),
  ('7', '105', '2', 'null', '1', '2020-01-08 21:20:29'),
  ('8', '102', '1', 'null', 'null', '2020-01-09 23:54:33'),
  ('9', '103', '1', '4', '1, 5', '2020-01-10 11:22:59'),
  ('10', '104', '1', 'null', 'null', '2020-01-11 18:34:49'),
  ('10', '104', '1', '2, 6', '1, 4', '2020-01-11 18:34:49');


DROP TABLE IF EXISTS runner_orders;
CREATE TABLE runner_orders (
  "order_id" INTEGER,
  "runner_id" INTEGER,
  "pickup_time" VARCHAR(19),
  "distance" VARCHAR(7),
  "duration" VARCHAR(10),
  "cancellation" VARCHAR(23)
);

INSERT INTO runner_orders
  ("order_id", "runner_id", "pickup_time", "distance", "duration", "cancellation")
VALUES
  ('1', '1', '2020-01-01 18:15:34', '20km', '32 minutes', ''),
  ('2', '1', '2020-01-01 19:10:54', '20km', '27 minutes', ''),
  ('3', '1', '2020-01-03 00:12:37', '13.4km', '20 mins', NULL),
  ('4', '2', '2020-01-04 13:53:03', '23.4', '40', NULL),
  ('5', '3', '2020-01-08 21:10:57', '10', '15', NULL),
  ('6', '3', 'null', 'null', 'null', 'Restaurant Cancellation'),
  ('7', '2', '2020-01-08 21:30:45', '25km', '25mins', 'null'),
  ('8', '2', '2020-01-10 00:15:02', '23.4 km', '15 minute', 'null'),
  ('9', '2', 'null', 'null', 'null', 'Customer Cancellation'),
  ('10', '1', '2020-01-11 18:50:20', '10km', '10minutes', 'null');


DROP TABLE IF EXISTS pizza_names;
CREATE TABLE pizza_names (
  "pizza_id" INTEGER,
  "pizza_name" TEXT
);
INSERT INTO pizza_names
  ("pizza_id", "pizza_name")
VALUES
  (1, 'Meatlovers'),
  (2, 'Vegetarian');


DROP TABLE IF EXISTS pizza_recipes;
CREATE TABLE pizza_recipes (
  "pizza_id" INTEGER,
  "toppings" TEXT
);
INSERT INTO pizza_recipes
  ("pizza_id", "toppings")
VALUES
  (1, '1, 2, 3, 4, 5, 6, 8, 10'),
  (2, '4, 6, 7, 9, 11, 12');


DROP TABLE IF EXISTS pizza_toppings;
CREATE TABLE pizza_toppings (
  "topping_id" INTEGER,
  "topping_name" TEXT
);
INSERT INTO pizza_toppings
  ("topping_id", "topping_name")
VALUES
  (1, 'Bacon'),
  (2, 'BBQ Sauce'),
  (3, 'Beef'),
  (4, 'Cheese'),
  (5, 'Chicken'),
  (6, 'Mushrooms'),
  (7, 'Onions'),
  (8, 'Pepperoni'),
  (9, 'Peppers'),
  (10, 'Salami'),
  (11, 'Tomatoes'),
  (12, 'Tomato Sauce');*/
  
  
 /*Cleaning DATABASE
 SELECT order_id, customer_id, pizza_id, 
  CASE 
    WHEN exclusions IS null OR exclusions LIKE 'null' THEN ' '
    ELSE exclusions
    END AS exclusions,
  CASE 
    WHEN extras IS NULL or extras LIKE 'null' THEN ' '
    ELSE extras 
    END AS extras, 
  order_time
INTO #customer_orders -- create TEMP TABLE
FROM customer_orders;

SELECT order_id, runner_id,
  CASE 
    WHEN pickup_time LIKE 'null' THEN ' '
    ELSE pickup_time 
    END AS pickup_time,
  CASE 
    WHEN distance LIKE 'null' THEN ' '
    WHEN distance LIKE '%km' THEN TRIM('km' from distance) 
    ELSE distance END AS distance,
  CASE 
    WHEN duration LIKE 'null' THEN ' ' 
    WHEN duration LIKE '%mins' THEN TRIM('mins' from duration) 
    WHEN duration LIKE '%minute' THEN TRIM('minute' from duration)        
    WHEN duration LIKE '%minutes' THEN TRIM('minutes' from duration)       
    ELSE duration END AS duration,
  CASE 
    WHEN cancellation IS NULL or cancellation LIKE 'null' THEN ''
    ELSE cancellation END AS cancellation
INTO #runner_orders
FROM runner_orders;


ALTER TABLE #runner_orders
ALTER COLUMN pickup_time DATETIME,
ALTER COLUMN distance FLOAT, 
ALTER COLUMN duration INT;


*/

/*Questions*/

/* 1 . How many pizzas were ordered? */

SELECT COUNT(*) "PIZZA_ORDER_COUNT" FROM CUSTOMER_ORDERS_1

/*2 . How many unique customer orders were made? */

SELECT COUNT(DISTINCT ORDER_ID) "UNIQUE_ORDERS" FROM CUSTOMER_ORDERS_1


/*3 . How many successful orders were delivered by each runner? */

SELECT RUNNER_ID , COUNT(*) FROM RUNNER_ORDERS_1
WHERE DISTANCE!=0
GROUP BY RUNNER_ID

/*4 . How many of each type of pizza was delivered? */

SELECT P.PIZZA_NAME , COUNT(*) FROM 
CUSTOMER_ORDERS_1 C , RUNNER_ORDERS_1 R , PIZZA_NAMES P
WHERE C.ORDER_ID = R.ORDER_ID 
AND C.PIZZA_ID = P.PIZZA_ID
AND R.DISTANCE != 0
GROUP BY P.PIZZA_NAME

/*5 . How many Vegetarian and Meatlovers were ordered by each customer?*/

SELECT C.CUSTOMER_ID , P.PIZZA_NAME , COUNT(*) FROM CUSTOMER_ORDERS_1 C , PIZZA_NAMES P 
WHERE C.PIZZA_ID = P.PIZZA_ID
GROUP BY C.CUSTOMER_ID , P.PIZZA_NAME
ORDER BY C.CUSTOMER_ID

/*6 . What was the maximum number of pizzas delivered in a single order?*/

WITH CTE AS (SELECT C.ORDER_ID , COUNT(C.PIZZA_ID)  "TOTAL_PIZZA_COUNT_IN_SINGLE_ORDER" ,
DENSE_RANK() OVER ( ORDER BY COUNT(C.PIZZA_ID) DESC ) RNK FROM CUSTOMER_ORDERS_1 C , RUNNER_ORDERS_1 R 
WHERE C.ORDER_ID = R.ORDER_ID
AND R.DISTANCE != 0
GROUP BY C.ORDER_ID )
SELECT * FROM CTE WHERE RNK = 1 

/*7 . For each customer, how many delivered pizzas had at least 1 change and how many had no changes? */

SELECT C.CUSTOMER_ID ,
SUM (CASE WHEN C.EXCLUSIONS <> ' ' OR C.EXTRAS <> ' ' THEN 1 ELSE 0 END ) AS "ATLEAST_ONE_CHANGE" ,
SUM (CASE WHEN C.EXCLUSIONS = ' ' AND  C.EXTRAS = ' ' THEN 1 ELSE 0 END ) AS "NO_CHANGE"
FROM CUSTOMER_ORDERS_1 C , RUNNER_ORDERS_1 R 
WHERE C.ORDER_ID = R.ORDER_ID
AND R.DISTANCE != 0
GROUP BY C.CUSTOMER_ID

/*8 . How many pizzas were delivered that had both exclusions and extras*/

SELECT  
 SUM(CASE
  WHEN exclusions IS NOT NULL AND extras IS NOT NULL THEN 1
  ELSE 0
  END) AS pizza_count_w_exclusions_extras
FROM #customer_orders AS c
JOIN #runner_orders AS r
 ON c.order_id = r.order_id
WHERE r.distance >= 1 
 AND exclusions <> ' ' 
 AND extras <> ' ';
 
 /*9 . What was the total volume of pizzas ordered for each hour of the day?*/
 
SELECT  HOUR(ORDER_TIME) "HOUR_OF_DAY"  , COUNT(PIZZA_ID) 
FROM CUSTOMER_ORDERS_1 C
GROUP BY HOUR(ORDER_TIME)
ORDER BY HOUR_OF_DAY

/*10 . What was the volume of orders for each day of the week?*/

SELECT DAYNAME(ORDER_TIME) "EACH_DAY_OF_WEEK" , COUNT(*) 
FROM CUSTOMER_ORDERS_1 C 
GROUP BY DAYNAME(ORDER_TIME)
ORDER BY EACH_DAY_OF_WEEK

/*11 . How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)*/

SELECT WEEK(REGISTRATION_DATE) + 1 , COUNT(*) 
FROM RUNNERS R
GROUP BY WEEK(REGISTRATION_DATE) + 1
ORDER BY WEEK(REGISTRATION_DATE) + 1

/*12 . What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order*/

SELECT  RUNNER_ID ,AVG(TIMESTAMPDIFF(MINUTE,ORDER_TIME,PICKUP_TIME))
FROM CUSTOMER_ORDERS_1 C , RUNNER_ORDERS_1 R
WHERE C.ORDER_ID =  R.ORDER_ID
AND R.DISTANCE!=0
GROUP BY RUNNER_ID

/*13 . Is there any relationship between the number of pizzas and how long the order takes to prepare?*/

SELECT NUMBER_OF_PIZZAS_UNDER_EACH_ORDER , AVG(TIME_DIFF)
FROM (SELECT C.ORDER_ID , COUNT(C.PIZZA_ID) "NUMBER_OF_PIZZAS_UNDER_EACH_ORDER", C.ORDER_TIME , R.PICKUP_TIME , TIMESTAMPDIFF(MINUTE,ORDER_TIME,PICKUP_TIME) "TIME_DIFF"
FROM CUSTOMER_ORDERS_1 C , RUNNER_ORDERS_1 R
WHERE C.ORDER_ID = R.ORDER_ID
AND R.DISTANCE != 0
GROUP BY C.ORDER_ID , C.ORDER_TIME , R.PICKUP_TIME ) AS TEMP 
GROUP BY NUMBER_OF_PIZZAS_UNDER_EACH_ORDER


/*14 . What was the average distance travelled for each customer*/

SELECT C.CUSTOMER_ID , AVG(R.DISTANCE) "AVERAGE_DISTANCE_FOR_EACH_CUSTOMER" 
FROM CUSTOMER_ORDERS_1  C, RUNNER_ORDERS_1 R
WHERE C.ORDER_ID = R.ORDER_ID
AND R.DISTANCE!=0 
GROUP BY C.CUSTOMER_ID

/*15 . What was the difference between the longest and shortest delivery times for all orders*/

SELECT MAX(DURATION) - MIN(DURATION) AS TIME_DIFF
FROM CUSTOMER_ORDERS_1  C, RUNNER_ORDERS_1 R
WHERE C.ORDER_ID = R.ORDER_ID
AND R.DURATION != ' '

/*16 . What was the average speed for each runner for each delivery and do you notice any trend for these values*/

SELECT R.RUNNER_ID , R.ORDER_ID , C.CUSTOMER_ID , C.PIZZA_ID ,  R.DURATION ,  AVG(DURATION) "AVERAGE_TIME_FOR_EACH_DELIVERY"
FROM RUNNER_ORDERS_1 R , CUSTOMER_ORDERS_1 C
WHERE DURATION != ' '
AND R.ORDER_ID = C.ORDER_ID
GROUP BY R.RUNNER_ID , R.ORDER_ID
ORDER BY R.RUNNER_ID

/*17 . What is the successful delivery percentage for each runner*/

SELECT RUNNER_ID , ROUND((SUM(CASE WHEN DISTANCE = 0 THEN 0 ELSE 1 END ) / COUNT(*) ) * 100,0)  AS "SUCCESS_FACTOR"
FROM RUNNER_ORDERS_1
GROUP BY RUNNER_ID








