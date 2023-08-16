
-- ===========================================================================
-- Book 1 NSS Advanced SQL 


-- INSERT statement to add a new sale:
INSERT INTO public.sales(sales_type_id, vehicle_id, employee_id, dealership_id, price, invoice_number)
VALUES (3, 21, 12, 7, 55999, 123477289);

-- INSERT statement to add a new sales type:
INSERT INTO public.salestypes(sales_type_name) VALUES ('Rent');

DELETE FROM public.salestypes 
WHERE sales_type_id  3;

INSERT INTO 
public.sales(sales_type_id, vehicle_id, employee_id, dealership_id, price, invoice_number)
VALUES 
(10, 21, 12, 7, 55999, 123477289),
(10, 14, 3, 7, 19999, 232727349),
(10, 6, 75, 7, 39500, 8635482010);

SELECT * FROM public.sales
WHERE sales_type_id = 10;

INSERT INTO 
public.customers(first_name, last_name, email, street, city, state, zipcode, company_name, phone_number)
VALUES 
('Kimberly', 'Gambill', 'kimberly@gambill.com', '625 Vantrease Rd.', 'Madison', 'TN', '37115', 'JECA', '555-555-5555'),
('Joshua', 'Gambill', 'joshua@gambill.com', '625 Vantrease Rd.', 'Madison', 'TN', '37115', 'JECA', '444-444-4444');

INSERT INTO public.vehicles 
VALUES (DEFAULT, '1C4SDTCH2CC004622', 'V6', 6, 'Black', 'Black', 20000, 25000, 210, 2023, FALSE, FALSE, 41 )

INSERT INTO public.employees 
VALUES (DEFAULT, 'Kennie', 'Maharg', 'kmaharge@com.com', '598-678-4885', 4)


-- LucidChart for Carnival
-- https://lucid.app/lucidchart/0efc8a34-ee1d-4b8d-b001-db9d900136de/edit?invitationId=inv_fefd4b5d-a2b7-457f-945f-0853b135bf1b&page=0_0#


-- ===========================================================================
-- Book 2 NSS Advanced SQL

-- 2.1 - Query Fundamentals

SELECT * FROM vehicles v;

SELECT 
	v.engine_type,
	v.floor_price,
	v.msr_price
FROM Vehicles v;

SELECT 
	d.business_name,
	d.city,
	d.state,
	d.website
FROM dealerships d;

SELECT 
	first_name,
	last_name ,
	email 
FROM customers

-- Ch.2 Filtering Data

SELECT
	last_name, first_name, city, state
FROM
	customers
WHERE
	state = 'TX';

SELECT
	c.last_name, c.first_name, c.city, c.state
FROM
	customers c
WHERE
	c.city = 'Houston' AND state = 'TX';


SELECT
	c.last_name, c.first_name, c.city, c.state
FROM
	customers c
WHERE
	c.state = 'TX' OR c.state = 'TN';


SELECT
	c.last_name, c.first_name, c.city, c.state
FROM
	customers c
WHERE
	c.state IN ('TX', 'TN', 'CA');

SELECT
	c.last_name, c.first_name, c.city, c.state
FROM
	customers c
WHERE
	c.state LIKE 'C%';

SELECT
	c.last_name, c.first_name
FROM
	customers c
WHERE
	LENGTH(c.last_name) > 5 AND LENGTH(c.first_name) <= 7;

SELECT
	c.last_name, c.first_name, c.company_name
FROM
	customers c
WHERE
	LENGTH(c.company_name) BETWEEN 10 AND 20;


SELECT
	c.last_name, c.first_name, c.company_name
FROM
	customers c
WHERE
	c.company_name = NULL;

SELECT
	c.last_name, c.first_name, c.company_name
FROM
	customers c
WHERE
	c.company_name IS NULL;

--Get a list of sales records where the sale was a lease.
SELECT *
FROM sales
WHERE sales_type_id = 2;

--Get a list of sales where the purchase date is within the last five years.
SELECT  * FROM sales
WHERE purchase_date > '2018-01-01';

--Get a list of sales where the deposit was above 5000 or the customer payed with American Express.
SELECT * FROM sales 
WHERE deposit > 5000 OR payment_method = 'americanexpress' ;

--Get a list of employees whose first names start with "M" or ends with "d".
SELECT * FROM employees
WHERE first_name LIKE 'M%' OR first_name LIKE '%d';

--Get a list of employees whose phone numbers have the 604 area code.
SELECT * FROM employees
WHERE phone LIKE '604-%';



-- 2.3 Joins

--Get a list of the sales that were made for each sales type.
SELECT 
	s.purchase_date ,
	s.invoice_number ,
	s.price ,
	st.sales_type_name 
FROM sales s
JOIN salestypes st
ON s.sales_type_id  = st.sales_type_id 
ORDER BY s.sales_type_id ;

--Get a list of sales with the VIN of the vehicle, the first name and last name of the customer, first name and last name of the employee who made the sale and the name, city and state of the dealership.
SELECT 
	v.vin,
	c.first_name,
	c.last_name,
	e.first_name ,
	e.last_name ,
	d.business_name ,
	d.city ,
	d.state 
FROM  sales s
JOIN vehicles v ON s.vehicle_id = v.vehicle_id 
JOIN employees e ON e.employee_id = s.employee_id 
JOIN dealerships d ON s.dealership_id = s.dealership_id
JOIN customers c ON c.customer_id = s.customer_id 
;

--Get a list of all the dealerships and the employees, if any, working at each one.
SELECT d.business_name , e.first_name , e.last_name 
FROM dealerships d 
JOIN dealershipemployees de ON de.dealership_id = d.dealership_id 
JOIN employees e ON de.employee_id = e.employee_id  
order BY d.business_name;

--Get a list of vehicles with the names of the body type, make, model and color.
SELECT v.vin, vt.body_type , vt.make, vt.model, v.exterior_color, v.interior_color
FROM vehicles v 
JOIN vehicletypes vt ON v.vehicle_type_id = vt.vehicle_type_id;




-- 2.4 - Aggregation and Grouping 
--MAX, MIN, SUM, COUNT, AVG, GROUP BY 

SELECT 
	max(price) max_price
	, min(price) min_price
	, round(avg(price), 2) avg_price
	, sum(price) sum_price
	, count(price) count
FROM sales s


SELECT 
	count(*), 
	vt.make, 
	vt.model, 
	vt.body_type
FROM vehicles v 
JOIN vehicletypes vt ON v.vehicle_type_id = vt.vehicle_type_id
GROUP BY vt.body_type, vt.make, vt.model
ORDER BY count(*) DESC;

SELECT engine_type , count(engine_type)
FROM vehicles v 
GROUP BY engine_type ;

SELECT avg(v.floor_price ), year_of_car 
FROM vehicles v 
GROUP BY year_of_car ;

SELECT count(c.zipcode), c.zipcode
FROM customers c
WHERE c.zipcode LIKE '4%'
GROUP BY c.zipcode;


-- 2.5 -  Complex Joins
-- Self - a regular join that joins a table to itself. In practice, you typically use a self-join to query hierarchical data or to compare rows within the same table.
-- Full Outer - combines the results of both the left join and the right join.
-- Cross - allows you to produce a Cartesian Product of rows in two or more tables.
-- Natural - A natural join is a join that creates an implicit join based on the same column names in the joined tables. However, you should avoid using the NATURAL JOIN whenever possible because sometimes it may cause an unexpected result

-- Examples

-- Find employees who haven't made any sales and the name of the dealership they work at.
SELECT
    e.first_name || ' ' || e.last_name AS name,
    d.business_name,
    s.price
FROM employees e
INNER JOIN dealershipemployees de ON e.employee_id = de.employee_id
INNER JOIN dealerships d ON d.dealership_id = de.dealership_id
LEFT JOIN sales s ON s.employee_id = e.employee_id
WHERE s.price IS NULL;

-- Get all the departments in the database,
-- all the employees in the database and the floor price of any vehicle they have sold.
SELECT
    d.business_name,
    e.first_name || ' ' || e.last_name AS employee_name,
    v.floor_price
FROM dealerships d
LEFT JOIN dealershipemployees de ON d.dealership_id = de.dealership_id
INNER JOIN employees e ON e.employee_id = de.employee_id
INNER JOIN sales s ON s.employee_id = e.employee_id
INNER JOIN vehicles v ON s.vehicle_id = v.vehicle_id;


-- Use a self join to list all sales that will be picked up on the same day,
-- including the full name of customer picking up the vehicle. .
SELECT
    CONCAT  (c.first_name, ' ', c.last_name) AS full_name,
    s1.invoice_number,
    s1.pickup_date
FROM sales s1
INNER JOIN sales s2
    ON s1.sale_id <> s2.sale_id 
    AND s1.pickup_date = s2.pickup_date
INNER JOIN customers c
   ON c.customer_id = s1.customer_id;
  

-- Get employees and customers who have interacted through a sale.
-- Include employees who may not have made a sale yet.
-- Include customers who may not have completed a purchase.

SELECT
    e.first_name AS employee_first_name,
    e.last_name AS employee_last_name,
    c.first_name AS customer_first_name,
    c.last_name AS customer_last_name
FROM employees e
FULL OUTER JOIN sales s ON e.employee_id = s.employee_id
FULL OUTER JOIN customers c ON s.customer_id = c.customer_id;
 

-- Get a list of all dealerships and which roles each of the employees hold.
SELECT
    d.business_name,
    et.employee_type_name 
FROM dealerships d
LEFT JOIN dealershipemployees de ON d.dealership_id = de.dealership_id
INNER JOIN employees e ON de.employee_id = e.employee_id
RIGHT JOIN employeetypes et ON e.employee_type_id = et.employee_type_id;

-- Practice

-- Produce a report that lists every dealership, the number of purchases done by each, and the number of leases done by each.
SELECT 
	d.business_name,
	count(s.sales_type_id),
	st.sales_type_name 
FROM dealerships d
JOIN sales s ON s.dealership_id = d.dealership_id
JOIN salestypes st ON s.sales_type_id = st.sales_type_id 
GROUP BY d.business_name , st.sales_type_id 
ORDER BY d.business_name, st.sales_type_id desc ; 

-- Alternate from Tim
SELECT
	d.business_name AS dealership,
	COUNT(s.sales_type_id)
		FILTER (WHERE s.sales_type_id=1) AS purchases,
	COUNT(s.sales_type_id)
		FILTER (WHERE s.sales_type_id=2) AS leases
FROM
	sales s
LEFT JOIN salestypes st
	ON s.sales_type_id = st.sales_type_id
Left JOIN dealerships d
	ON s.dealership_id = d.dealership_id
GROUP BY
	d.business_name
ORDER BY
	d.business_name;


-- Produce a report that determines the most popular vehicle model that is leased.
SELECT 
	count(s.sales_type_id),
	vt.model
FROM sales s
JOIN vehicles v ON s.vehicle_id = v.vehicle_id 
JOIN vehicletypes vt ON v.vehicle_type_id = vt.vehicle_type_id 
WHERE s.sales_type_id = 2
GROUP BY vt.model
ORDER BY count DESC 
LIMIT 1;

-- What is the most popular vehicle make in terms of number of sales?
SELECT 
	count(s.sales_type_id),
	vt.model
FROM sales s
JOIN vehicles v ON s.vehicle_id = v.vehicle_id 
JOIN vehicletypes vt ON v.vehicle_type_id = vt.vehicle_type_id 
WHERE s.sales_type_id = 1
GROUP BY 2
ORDER BY count DESC 
LIMIT 1;

-- Which employee type sold the most of that make? (Maxima)
-- get all sales, then sales related to Maxima, then employee
SELECT 
	count(vt.vehicle_type_id),
	e.first_name || ' ' || e.last_name AS name
FROM sales s
JOIN vehicles v ON s.vehicle_id = v.vehicle_id 
JOIN vehicletypes vt ON v.vehicle_type_id = vt.vehicle_type_id 
JOIN employees e  ON e.employee_id  = s.employee_id 
WHERE vt.vehicle_type_id = 12 AND sales_type_id = 1
GROUP BY vt.vehicle_type_id, name
ORDER BY count Desc;



-- 2.6 - Subqueries
--  can be nested inside a SELECT, INSERT, UPDATE, DELETE, SET, or DO statement or inside another subquery
-- is usually added within the WHERE Clause of another SQL SELECT statement
-- can use the comparison operators, such as >, <, or =
-- inner query executes first before its parent query 
-- good for doing an aggregate of an aggregate


-- 2.7 - CTE/Common Table Expressions
-- similar to temporary table that only runs when the query runs
-- It computes the aggregation once and allows us to reference it by its name
-- can be recursive, referring to itself - uses RECURSIVE key word
-- Also known as WITH cte_name AS ()


-- first solution, but includes all previous owners

INSERT INTO oilchangelogs
	(date_occured, vehicle_id)
VALUES
	('2020-01-09', 1),
	('2021-10-30', 2),
	('2019-02-20', 3),
	('2022-03-17', 4)
;

with vehicles_needing_service as
(
	select
		v.vehicle_id,
		v.year_of_car,
		v.miles_count,
		TO_CHAR(o.date_occured, 'YYYY-MM-DD') date_of_last_change
	from vehicles v

	join oilchangelogs o
		on v.vehicle_id = o.vehicle_id
	where o.date_occured < '2022-01-01'
)
select
	vs.vehicle_id,
	vs.miles_count,
	s.purchase_date,
	e.first_name || ' ' || e.last_name seller,
	c.first_name || ' ' || c.last_name purchaser,
	c.email
from vehicles_needing_service vs -- Use the CTE
join sales s
	on s.vehicle_id  = vs.vehicle_id
join employees e
	on s.employee_id = e.employee_id
join customers c
	on s.customer_id = c.customer_id
order by
	vs.vehicle_id,
	s.purchase_date desc
;


-- second solution, but includes only most recent owner
with vehicles_needing_service as
(
	select
		v.vehicle_id,
		v.year_of_car,
		v.miles_count,
		TO_CHAR(o.date_occured, 'YYYY-MM-DD') date_of_last_change
	from vehicles v

	join oilchangelogs o
		on v.vehicle_id = o.vehicle_id
	where o.date_occured < '2022-01-01'
),
last_purchase as (
	select
		s.vehicle_id,
		max(s.purchase_date) purchased
	from sales s
	group by s.vehicle_id
)

select
	vs.vehicle_id,       -- Get vehicle id from first CTE
	vs.miles_count,      -- Get miles from first CTE
	lp.purchased,        -- Get purchase date from second CTE
	e.first_name || ' ' || e.last_name seller,
	c.first_name || ' ' || c.last_name purchaser,
	c.email
from vehicles_needing_service vs
join last_purchase lp   -- Join the second CTE
	on lp.vehicle_id  = vs.vehicle_id
join sales s
	on lp.vehicle_id = s.vehicle_id
	and lp.purchased = s.purchase_date
join employees e
	on s.employee_id = e.employee_id
join customers c
	on s.customer_id = c.customer_id
;

-- For the top 5 dealerships, which employees made the most sales?
WITH top_5_dealers AS (
SELECT 
	sum(s.price) total_dealer_sales, 
	d.dealership_id,
	d.business_name 
FROM sales s 
JOIN dealerships d ON s.dealership_id = d.dealership_id 
GROUP BY d.dealership_id 
ORDER BY total_dealer_sales DESC
LIMIT 5
),

employee_rank AS (
SELECT
	s.dealership_id ,
	s.employee_id ,
	e.first_name || ' ' || e.last_name AS employee_name,
	sum(s.price) AS transactions,
	ROW_NUMBER() over(PARTITION BY s.dealership_id ORDER BY sum(s.price) DESC) AS rank
FROM 
	sales s
JOIN employees e ON s.employee_id = e.employee_id
GROUP BY s.dealership_id , s.employee_id , e.first_name, e.last_name 

)

SELECT
	t5d.business_name,
	er.employee_name,
	t5d.total_dealer_sales
FROM top_5_dealers t5d 
JOIN employee_rank er ON er.dealership_id = t5d.dealership_id
WHERE rank = 1
GROUP BY er.employee_name, t5d.dealership_id, t5d.business_name, t5d.total_dealer_sales
ORDER BY t5d.total_dealer_sales desc
;

-- For the top 5 dealerships, which vehicle models were the most popular in sales?
WITH top_5_dealers AS (
    SELECT 
        d.dealership_id, 
        d.business_name
    FROM dealerships d 
    JOIN sales s ON s.dealership_id = d.dealership_id 
    GROUP BY d.business_name, d.dealership_id 
    ORDER BY SUM(s.price) DESC 
    LIMIT 5
),

dealer_model_sales AS (
    SELECT 
        t5d.dealership_id,
        vt.model AS model,
        COUNT(vt.model) AS model_sales
    FROM sales s 
    JOIN top_5_dealers t5d ON t5d.dealership_id = s.dealership_id 
    JOIN vehicles v ON v.vehicle_id = s.vehicle_id 
    JOIN vehicletypes vt ON v.vehicle_type_id = vt.vehicle_type_id 
    GROUP BY t5d.dealership_id, vt.model
),

ranked_dealer_models AS (
    SELECT 
        dms.dealership_id,
        dms.model,
        dms.model_sales,
        RANK() OVER (PARTITION BY dms.dealership_id ORDER BY dms.model_sales DESC) AS model_rank
    FROM dealer_model_sales dms
)

SELECT 
    rdm.dealership_id,
    rdm.model,
    rdm.model_sales
FROM ranked_dealer_models rdm
WHERE rdm.model_rank = 1
ORDER BY rdm.dealership_id;


-- For the top 5 dealerships, were there more sales or leases?

WITH top_5_dealers AS (
    SELECT 
        d.dealership_id, 
        d.business_name
    FROM dealerships d 
    JOIN sales s ON s.dealership_id = d.dealership_id 
    GROUP BY d.business_name, d.dealership_id 
    ORDER BY SUM(s.price) DESC 
    LIMIT 5
)

SELECT 
    t5d.dealership_id,
	t5d.business_name,
    SUM(CASE WHEN s.sales_type_id = 1 THEN 1 ELSE 0 END) AS total_purchases,
    SUM(CASE WHEN s.sales_type_id = 2 THEN 1 ELSE 0 END) AS total_leases,
    CASE 
        WHEN SUM(CASE WHEN s.sales_type_id = 1 THEN 1 ELSE 0 END) >
             SUM(CASE WHEN s.sales_type_id = 2 THEN 1 ELSE 0 END) THEN 'Sales'
        WHEN SUM(CASE WHEN s.sales_type_id = 1 THEN 1 ELSE 0 END) <
             SUM(CASE WHEN s.sales_type_id = 2 THEN 1 ELSE 0 END) THEN 'Leases'
        ELSE 'Equal'
    END AS greater_category
FROM sales s 
JOIN top_5_dealers t5d ON t5d.dealership_id = s.dealership_id 
GROUP BY t5d.business_name, t5d.dealership_id
ORDER BY t5d.dealership_id ;


--2.8  Window Functions
select
	sales.employee_id,
	sum(sales.price) total_employee_sales
from
	employees
join
	sales
on
	sales.employee_id = employees.employee_id
group by
	sales.employee_id;



select distinct
	employees.last_name || ', ' || employees.first_name employee_name,
	sales.employee_id,
	sum(sales.price) over() total_sales,
	sum(sales.price) over(partition by employees.employee_id) total_employee_sales
from
	employees
join
	sales
on
	sales.employee_id = employees.employee_id
order by employee_name;


-- Practice

--Write a query that shows the total purchase sales income per dealership.
SELECT  distinct
	s.dealership_id
	, sum(s.price) over(PARTITION BY s.dealership_id) total_dealership_sales
FROM sales s
WHERE s.sales_type_id = 1
ORDER BY s.dealership_id 
;

--Write a query that shows the purchase sales income per dealership for July of 2020.
SELECT  distinct
	s.dealership_id
	, sum(s.price) over(PARTITION BY s.dealership_id) total_dealership_sales
FROM sales s
WHERE s.purchase_date >= '2020-07-01' AND s.purchase_date < '2020-08-01'
	AND s.sales_type_id = 1
ORDER BY s.dealership_id 
;

--Write a query that shows the purchase sales income per dealership for all of 2020.
SELECT
    s.dealership_id,
    SUM(s.price) AS total_dealership_sales
FROM sales s
WHERE EXTRACT(YEAR FROM s.purchase_date) = 2020 AND s.sales_type_id = 1
GROUP BY s.dealership_id
ORDER BY s.dealership_id;



-- 2.9

--Write a query that shows the total lease income per dealership.
SELECT  distinct
	s.dealership_id
	, sum(s.price) over(PARTITION BY s.dealership_id) total_dealership_leases
FROM sales s
WHERE s.sales_type_id = 2
ORDER BY s.dealership_id 
;

--Write a query that shows the lease income per dealership for Jan of 2020.
SELECT  distinct
	s.dealership_id
	, sum(s.price) over(PARTITION BY s.dealership_id) total_dealership_leases
FROM sales s
WHERE s.purchase_date >= '2020-01-01' AND s.purchase_date < '2020-02-01'
	AND s.sales_type_id = 2
ORDER BY s.dealership_id 
;

--Write a query that shows the lease income per dealership for all of 2019.
SELECT
    s.dealership_id,
    SUM(s.price) AS total_dealership_leases
FROM sales s
WHERE EXTRACT(YEAR FROM s.purchase_date) = 2019 AND s.sales_type_id = 1
GROUP BY s.dealership_id
ORDER BY s.dealership_id;

--Write a query that shows the total income (purchase and lease) per employee.
SELECT distinct s.employee_id
	, sum(s.price) OVER(PARTITION BY s.employee_id) total_employee_sales 
FROM sales s
ORDER BY s.employee_id 
;

--2.10

-- Which model of vehicle has the lowest current inventory? This will help dealerships know which models the purchase from manufacturers.
SELECT distinct
	 v.vehicle_type_id
	 , vt.model
	 , count(*) AS model_count	 
FROM vehicles v 
JOIN vehicletypes vt ON v.vehicle_type_id  = vt.vehicle_type_id 
WHERE v.is_sold = FALSE
GROUP BY v.vehicle_type_id , vt.model 
ORDER BY model_count ASC
LIMIT 1
;

-- with window function
SELECT
    vehicle_type_id,
    model,
    model_count
FROM (
    SELECT
        v.vehicle_type_id,
        vt.model,
        COUNT(*) AS model_count,
        ROW_NUMBER() OVER (ORDER BY COUNT(*) ASC) AS rn
    FROM vehicles v
    JOIN vehicletypes vt ON v.vehicle_type_id = vt.vehicle_type_id
    WHERE v.is_sold = FALSE
    GROUP BY v.vehicle_type_id, vt.model
) ranked_models
WHERE rn = 1;

-- Which model of vehicle has the highest current inventory? This will help dealerships know which models are, perhaps, not selling
SELECT distinct
	 v.vehicle_type_id
	 , vt.model
	 , count(*) AS model_count	 
FROM vehicles v 
JOIN vehicletypes vt ON v.vehicle_type_id  = vt.vehicle_type_id 
WHERE v.is_sold = FALSE
GROUP BY v.vehicle_type_id , vt.model 
ORDER BY model_count DESC 
LIMIT 1
;

-- with window function
SELECT
    vehicle_type_id,
    model,
    model_count
FROM (
    SELECT
        v.vehicle_type_id,
        vt.model,
        COUNT(*) AS model_count,
        MAX(COUNT(*)) OVER () AS max_model_count
    FROM vehicles v
    JOIN vehicletypes vt ON v.vehicle_type_id = vt.vehicle_type_id
    WHERE v.is_sold = FALSE
    GROUP BY v.vehicle_type_id, vt.model
) ranked_models
WHERE model_count = max_model_count;

-- Which dealerships are currently selling the highest number of vehicle models? This will let dealerships know which regions have either a high population, or less brand loyalty.


 


