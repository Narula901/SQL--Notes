/*

The Chinook data set is a well-known sample database frequently used for learning and practicing SQL (Structured Query Language) concepts and database management. It is often used in database courses, tutorials, and demonstrations. The Chinook data set represents a fictional digital media store, containing information about artists, albums, tracks, customers, invoices, and employees.

Here's an overview of the tables included in the Chinook data set:

"Employees": Contains information about the employees working at the store, such as their names, job titles, birth dates, and contact details.

"Customers": Stores data about the store's customers, including their names, addresses, email addresses, and support representative.

"Invoices": Contains information about the invoices generated for each customer, such as invoice IDs, invoice dates, customer IDs, and billing details.

"InvoiceItems": Contains details about individual items within each invoice, such as track IDs, unit prices, quantities, and totals.

"Tracks": Contains information about each track available in the store, including track names, albums, genres, media types, durations, and file sizes.

"Albums": Stores data about the albums available in the store, such as album titles and the artist associated with each album.

"Artists": Contains details about the artists featured in the store, including their names.

"Genres": Stores information about different music genres available in the store.

"MediaTypes": Contains details about the different types of media available, such as MPEG audio file, AAC audio file, etc.

*/


select *,
ROW_NUMBER()over(order by Milliseconds desc) as Longest_Song_Rank
from [dbo].[Track]

-- I want a top 10 Longest_Song Length
select top 10* 
from [dbo].[Track]
order by Milliseconds desc

---Alternative
go
with Track_length as
(
		select *,
		ROW_NUMBER()over(order by Milliseconds desc) as Longest_Song_Rank
		from [dbo].[Track]
)
select * 
from Track_length
where Longest_Song_Rank>=0 and Longest_Song_Rank <=10


---- Suppose i Want an another 10 Longest_Track duration list, we can do in this Way.
Go
with Track_length as
(
		select *,
		ROW_NUMBER()over(order by Milliseconds desc) as Longest_Song_Rank
		from [dbo].[Track]
)
select * 
from Track_length
where Longest_Song_Rank>=10 and Longest_Song_Rank <=20 
---But this is not the dynamic way, because if i want another 10 Largest_Track Duration lis, i have to follow this code again
--- For that we use Procedure to do this activity.

---- Create Procedure 
Create procedure dbo.procGetTrackDuration
(
	@start as int,
	@step as int = 10
) as 
begin
	with Track_length as
		(
				select *,
				ROW_NUMBER()over(order by Milliseconds desc) as Longest_Song_Rank
				from [dbo].[Track]
		)
		select * 
		from Track_length
		where Longest_Song_Rank>=@start and Longest_Song_Rank <=@step
end
go


exec dbo.procGetTrackDuration 10,20
go
--- As we have seen that, Track_Duration is Changing Dynamically with the help of Procedure.

----With the help of Row Number we can find the duplicate values, in this case find the duplicate value on the basis of Name.

with Track_length as
(
		select *,
		ROW_NUMBER()over(Partition by Name order by Milliseconds desc) as RowNumber
		from [dbo].[Track]
)
select * 
from Track_length
where RowNumber = 1
---This Shows the Unique list of Name in Track Length



--- I want to check among Album ID which is having longest duration song
with Track_length as
(
		select *,
		ROW_NUMBER()over(Partition by AlbumID order by Milliseconds desc) as Longest_Song_Based_on_AlbumID
		from [dbo].[Track]
)
select * 
from Track_length
where Longest_Song_Based_on_AlbumID = 1

--- Give me the name of Top 5 Track Name based upon the Value of UnitPrice

---Give me the Top 5 title name based upon Highest duration of TrackId 
with Top_5_Title_Name as
(
		select *,
		DENSE_RANK()over(order by Milliseconds desc) as Title_Duration
		from [dbo].[Track]
)
select A.Title, T.Title_Duration, T.Milliseconds as Time_in_Milliseconds
from Top_5_Title_Name as T
inner join [dbo].[Album] as A
on T.AlbumId = A.AlbumId
where Title_Duration<=5

---
select * from [dbo].[InvoiceLine]
with Discount as
(
	select T.*, I.Quantity, NTILE(3) over(order by T.UnitPrice desc) as Category
	from [dbo].[Track] T
	inner Join [dbo].[InvoiceLine] I
	on T.TrackId = I.TrackId
	where GenreId in (12,13)
)
select *, 
    case
		when Category = 1 then (UnitPrice * Quantity - (0.5 * UnitPrice * Quantity))
		when Category = 2 then (UnitPrice * Quantity - (0.3 * UnitPrice * Quantity))
		when Category = 3 then (UnitPrice * Quantity - (0.1 * UnitPrice * Quantity))	
	end as Price_With_Discount
from Discount 

--- First create a 3 groups of Unit Price from High value to Low Value, after that give Discount According to Unit  Price

with Easy_listening_Track as
(
	select T.*, I.Quantity, NTILE(3) over(order by T.UnitPrice desc) as Price_Group
	from [dbo].[Track] T
	inner Join [dbo].[InvoiceLine] I
	on T.TrackId = I.TrackId
	where GenreId in (12,13)
)
select *, (60 - (Price_Group * 10)) as Discount_Percentage
from Easy_listening_Track 











