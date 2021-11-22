
-------Number of weekly active users for the latest full week (Monday – Sunday). WAU is calculated by counting registered users with > 60 seconds dwell time between Monday-Sunday.

with cte as (

select distinct Ads_User_id, sum(Dwell_Time) as dt

from Ad_Service_Interaction_Data

where datepart(week,Timestamp) = datepart(week,current_date)

and datepart(year,Timestamp) = datepart(year,current_date)

group by Ads_User_id

having dt>60.0

)

 

select count(Ads_User_id) from cte;