/*1. Write query to return the email, first name, last name, & Genre of all Rock Music
listeners. Return your list ordered alphabetically by email starting with A*/

Select distinct email, first_name, last_name
from customer
Join invoice ON customer.customer_id = invoice.customer_id
Join invoice_line ON invoice.invoice_id = invoice_line.invoice_id
where track_id IN(
	Select track_id from track
	Join genre ON track.genre_id = genre.genre_id
	where genre.name = 'Rock'
)
Order by email;

/*2. Let's invite the artists who have written the most rock music in our dataset. Write a
query that returns the Artist name and total track count of the top 10 rock bands*/

Select artist.artist_id, artist.name,Count(artist.artist_id) As number_of_songs
from track
join album on album.album_id = track.album_id
Join artist ON artist.artist_id = album.artist_id
Join genre ON genre.genre_id = track.genre_id
Where genre.name Like 'Rock'
Group By artist.artist_id
Order By number_of_songs Desc
Limit 10;

/*3. Return all the track names that have a song length longer than the average song length.
Return the Name and Milliseconds for each track. Order by the song length with the
longest songs listed first*/

Select name,milliseconds
from track
where milliseconds>(
	Select avg(milliseconds) as avg_track_length
	from track
)
Order by milliseconds Desc;
















