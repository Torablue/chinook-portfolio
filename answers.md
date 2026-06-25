# Analysis Result

## 1. Find the 10 most purchased tracks by total quantity sold.

Two approaches were used to analyze track sales.

### Track + Album Analysis

When tracks were grouped by track, album, and artist, no single track clearly dominated sales. More than 10 tracks shared the highest sales quantity, with each track being purchased only two times.

This indicates that sales are relatively evenly distributed across the catalog.

### Track + Artist Analysis

When tracks with the same name and artist were combined across different albums, one track emerged as the top-selling track.

This suggests that some songs appear on multiple albums, such as studio albums, compilations, or live albums. Aggregating these versions produces different results compared to treating each album track separately.

### Conclusion

The result depends on the business definition of a "track."

* If each album version is considered a separate product, there is no clear best-selling track.
* If tracks with the same title and artist are treated as the same song, one song becomes the top seller.

This analysis demonstrates how different grouping methods can lead to different business insights.




## 2. Calculate total invoice revenue for each billing country.
### Revenue by Country

The United States generated the highest total revenue, exceeding the second-ranked country by more than 200.

Canada ranked second, with a gap of more than 100 compared to the third-ranked country. The remaining countries showed relatively small differences in revenue.

This indicates that revenue is heavily concentrated in the United States and Canada, while other markets contribute considerably less to total sales.

Further analysis would be needed to determine whether this concentration is caused by customer preferences, market size, or differences in market presence across countries.


## 3. List all customers where the phone field is NULL.
### Missing Customer Phone Numbers

Only one customer record does not contain a phone number.

However, the customer's email address is available, providing an alternative communication channel if contact is required.

This suggests that missing phone information is not currently a significant data quality issue within the customer database.


## 4. Find all tracks with a duration over 300,000 milliseconds.
## 5. Retrieve all albums for Aerosmith.
## 6. Count how many tracks belong to each genre and sort descending
## 7. Find customers who have no records in the Invoice table.
