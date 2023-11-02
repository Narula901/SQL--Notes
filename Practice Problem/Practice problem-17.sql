CREATE TABLE rental_amenities (
    rental_id INT,
    amenity VARCHAR(255)
);

INSERT INTO rental_amenities (rental_id, amenity) VALUES
(1, 'WiFi'),
(1, 'Air Conditioning'),
(2, 'WiFi'),
(2, 'Swimming Pool'),
(3, 'WiFi'),
(3, 'Air Conditioning'),
(4, 'Swimming Pool'),
(5, 'Air Conditioning'),
(5, 'Parking'),
(6, 'WiFi');

select * from rental_amenities

WITH grouped_detail AS (
    SELECT rental_id, STRING_AGG(amenity, ',') AS combine_detail
    FROM rental_amenities
    GROUP BY rental_id
)

SELECT COUNT(*) AS matching_airbnb
FROM grouped_detail a
JOIN grouped_detail b
ON a.rental_id < b.rental_id
AND a.combine_detail = b.combine_detail;


WITH grouped_detail AS (
    SELECT combine_detail, COUNT(*) AS rental_count
    FROM (
        SELECT rental_id, STRING_AGG(amenity, ',') AS combine_detail
        FROM rental_amenities
        GROUP BY rental_id
    ) amenity_details
    GROUP BY combine_detail
    HAVING COUNT(*) > 1
)

SELECT SUM(rental_count) AS matching_airbnb
FROM grouped_detail;

go
with CTE as
(
select rental_id,
STRING_AGG(amenity, ', ') as Amenity
from rental_amenities
group by rental_id
),
CTE_1 as
(
select  rental_id, 
count(Amenity) over(partition by Amenity) as cnt
from CTE
)
select cnt
from CTE_1
where cnt = 2







