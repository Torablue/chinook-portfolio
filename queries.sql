--1a
select t.name as "Track", al.title as "Album" , ar.name as "Artist", sum(il.quantity) as total_sold from track t
join invoice_line il on il.track_id =t.track_id
join album al on t.album_id =al.album_id 
join artist ar on al.artist_id =ar.artist_id 
group by t.track_id, t.name, al.title, ar.name
order by total_sold desc
limit 10

--1b
select t.name as "Track" , ar.name as "Artist", sum(il.quantity) as total_sold from track t
join invoice_line il on il.track_id =t.track_id
join album al on t.album_id =al.album_id 
join artist ar on al.artist_id =ar.artist_id 
group by t.name, ar.name
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
order by t.milliseconds desc 

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

--8
select to_char(i.invoice_date,'YYYY-MM' ) AS year_month, sum(i.total) as total_revenue
from invoice i
group by year_month 
order by year_month

--9
with ranked_customer as (select c.first_name ||' '||c.last_name as "customer_name", c.country, sum(i.total) as total_spending,
rank() over(
	partition by c.country  
	order by sum(i.total) desc
) as ranking
from invoice i
join customer c on c.customer_id=i.customer_id
group by c.customer_id, c.country
order by c.country asc,sum(i.total) desc)
select r.customer_name, r.country, r.total_spending from ranked_customer r where ranking =1
order by r.country 

--10
select e.first_name ||' '||e.last_name as employee_name, round(avg(i.total),2) as avg_invoice_value from invoice i
join customer c on i.customer_id =c.customer_id 
join employee e on c.support_rep_id =e.employee_id 
group by e.employee_id 
order by avg_invoice_value 

--11
with genre_ranking as(select c.country as "country", g.name as "genre", count(il.invoice_line_id) as purchase_count,
rank()over(
	partition by c.country
	order by count(g.genre_id) desc)as ranking
from invoice i
join customer c on i.customer_id =c.customer_id
join invoice_line il on il.invoice_id =i.invoice_id 
join track t on t.track_id =il.track_id 
join genre g on g.genre_id =t.genre_id 
group by c.country, g.genre_id )
select r.country as "country", r."genre", r.purchase_count from genre_ranking r
where r.ranking =1
order by r.country asc

--12
select t.name as track_name, ar."name" as artist, a.title as album from invoice_line il right join track t on t.track_id =il.track_id
join album a on a.album_id =t.album_id 
join artist ar on a.artist_id =ar.artist_id 
where il.track_id is null
order by t.name

--13
select e.first_name ||' ' ||e.last_name as employee_name, sum(i.total ) as total_revenue from invoice i
join customer c on i.customer_id =c.customer_id 
join employee e on c.support_rep_id =e.employee_id 
group by e.employee_id 
order by total_revenue desc 

--14
with year_sort as (select c.customer_id, c.first_name, extract(year from i.invoice_date) as cohort_year,
	row_number()over(partition by c.customer_id
	order by i.invoice_date) as rn
	from customer c join invoice i on c.customer_id = i.customer_id),
get_id as (select ys.customer_id, ys.cohort_year
	from year_sort ys
	where ys.rn =1)
select gi.cohort_year, sum(i.total) as total_rev, count(gi.customer_id ) as customer_count,
round(sum(i.total)/count(gi.customer_id ),2)as avg_revenue_per_customer
from get_id gi join invoice i on gi.customer_id = i.customer_id
group by gi.cohort_year 
order by cohort_year asc 

--15
with daily_rev as(
	select to_char(i.invoice_date,'dd-mm-yyyy') as buy_date,
	sum(i.total) as daily_revenue, i.invoice_date 
from invoice i 
group by i.invoice_date )
select dr.buy_date, dr.daily_revenue,
sum(dr.daily_revenue) over(order by dr.invoice_date) as cumulative_rev
from daily_rev dr
order by dr.invoice_date 
