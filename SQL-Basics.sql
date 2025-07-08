/*1. Find how much amount spent by each customer on artists? Write a query to return
customer name, artist name and total spent*/

WITH best_selling_artist AS(
	Select artist.artist_id AS artist_id, artist.name AS artist_name,
	SUM(invoice_line.unit_price*invoice_line.quantity) AS total_sales
	from invoice_line
	Join track On track.track_id = invoice_line.track_id
	Join album ON album.album_id = track.album_id
	JOin artist ON artist.artist_id = album.artist_id
	group by 1
	order by 3 desc
	limit 1
)

Select c.customer_id, c.first_name, c.last_name, bsa.artist_name,
Sum(il.unit_price*il.quantity) AS amount_spent
from invoice i
Join customer c ON c.customer_id =i.customer_id
Join invoice_line il ON il.invoice_id = i.invoice_id
Join track t ON t.track_id = il.track_id
Join album alb ON alb.album_id = t.album_id
Join best_selling_artist bsa On bsa.artist_id = alb.artist_id
Group By 1,2,3,4
Order by 5 Desc;

/*2. We want to find out the most popular music Genre for each country. We determine the
most popular genre as the genre with the highest amount of purchases. Write a query
that returns each country along with the top Genre. For countries where the maximum
number of purchases is shared return all Genres*/

With popular_genre AS
(
	Select Count(invoice_line.quantity) AS purchases, customer.country, genre.name, genre.genre_id,
	ROW_NUMBER() OVER(PARTITION BY customer.country ORDER BY COUNT(invoice_line.quantity) DESC) AS RowNo
	FROM invoice_line
	Join invoice ON invoice.invoice_id=invoice_line.invoice_id
	Join customer ON customer.customer_id = invoice.customer_id
	Join track ON track.track_id= invoice_line.track_id
	Join genre ON genre.genre_id = track.genre_id
	Group By 2,3,4
	order by 2 ASC, 1 DESC
	
)
Select * from popular_genre Where RowNo <=1

/*3. Write a query that determines the customer that has spent the most on music for each
country. Write a query that returns the country along with the top customer and how
much they spent. For countries where the top amount spent is shared, provide all
customers who spent this amount*/

WITH RECURSIVE
	customer_with_country AS(
		SELECT customer.customer_id,first_name, last_name,billing_country,SUM(total) AS total_spending
		FROM invoice
		JOin customer ON customer.customer_id = invoice.customer_id
		Group by 1,2,3,4
		Order by 1,5 DESC),

	country_max_spending AS(
		Select billing_country,MAX(total_spending) AS max_spending
		FROM customer_with_country
		GRoup BY billing_country)
SELECT cc.billing_country, cc.total_spending, cc.first_name, cc.last_name, cc.customer_id
FROM customer_with_country cc
JOIN country_max_spending ms
ON cc.billing_country = ms.billing_country
	
















