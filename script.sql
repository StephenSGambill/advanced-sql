

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