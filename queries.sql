--1
select t.name as "Track", al.title as "Album" , ar.name as "Artist", sum(il.quantity) as total_sold from track t
join invoice_line il on il.track_id =t.track_id
join album al on t.album_id =al.album_id 
join artist ar on al.artist_id =ar.artist_id 
group by t.track_id, t.name, al.title, ar.name
order by total_sold desc
limit 10

--2
select i.billing_country as country, sum(i.total) as Total_revenue from invoice i
group by i.billing_country
order by Total_revenue desc 

--3
select c.customer_id as ID, c.first_name ||' '||c.last_name as CustomerName,
c.address||', '||c.country||' '||c.postal_code as Address,c.phone ,c.fax, c.email 
from customer c where c.phone is null

--4
select t.name as Track, al.title as album, a.name as artist,
div(t.milliseconds,60000)||':'||lpad((mod(t.milliseconds,60000)/1000)::text,2,'0') as length from track t
join album al on al.album_id =t.album_id 
join artist a on a.artist_id=al.artist_id 
where t.milliseconds >300000

--5
select a.title as album , ar.name as artist from album a join artist ar on a.artist_id =ar.artist_id 
where ar.name ='Aerosmith'

--6
select g.name as genre, count(t.track_id ) as track_count from genre g join track t on g.genre_id = t.genre_id 
group by  g.name
order by track_count desc 

--7
select c.customer_id, c.first_name || ' ' || c.last_name as full_name, c.email
from customer c
left join invoice i on i.customer_id = c.customer_id
where i.invoice_id is null
order by c.last_name;
