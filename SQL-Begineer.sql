-- Q1. Who is the senior most employee based on job title?

Select * from employee
order by levels desc
limit 1

--2. Which countries have the most Invoices?
Select COUNT(*) as c, billing_country
from invoice
group by billing_country
Order by c desc

--3. What are top 3 values of total invoice?
Select total  from invoice
order by total desc
limit 3

/*4. Which city has the best customers? We would like to throw a promotional Music
Festival in the city we made the most money. Write a query that returns one city that
has the highest sum of invoice totals. Return both the city name & sum of all invoice
totals*/

Select sum(total) as invoice_total, billing_city 
from invoice
group by billing_city
order by invoice_total desc


/*5. Who is the best customer? The customer who has spent the most money will be
declared the best customer. Write a query that returns the person who has spent the
most money*/

Select customer.customer_id, customer.first_name, customer.last_name, SUM(invoice.total) as total
from customer
JOin invoice ON customer.customer_id = invoice.customer_id
group by customer.customer_id
order by total desc
limit 1















