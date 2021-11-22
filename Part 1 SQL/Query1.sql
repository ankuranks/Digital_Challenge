-------Top 5 most popular pieces of content consumed this week. 

select Content_id

, count(*) as Content_Count

, RANK() OVER (Order BY COUNT(*) DESC) as content_rank

from Page_Impression

where datepart(week,Timestamp) = datepart(week,current_date)

and datepart(year,Timestamp) = datepart(year,current_date)

group by Content_Id

order by count(*) desc

limit 5;