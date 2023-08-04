
-- ===========================================================================
-- Book 1 NSS Advanced SQL 

-- 

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

-- Ch.1 - Query Fundamentals

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





