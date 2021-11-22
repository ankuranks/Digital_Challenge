
-----Top 5 pieces of content from each content type consumed this week by only active users (using the above definition). 

with cte as (

select distinct a.Ads_User_id, sum(a.Dwell_Time) as dt, c.Content_id, c.Content_type

from Ad_Service_Interaction_Data a

left join Page_Impression p on a.Ads_User_id = p.Ads_User_id

left join Content_Metadata c on p.Content_Id = c.Content_Id

where datepart(week,a.Timestamp) = datepart(week,current_date)

and datepart(year,a.Timestamp) = datepart(year,current_date)

group by a.Ads_User_id, c.Content_id, c.Content_type

having dt>60.0

)

 

, cte2 as (

select Content_type, Content_id, count(Ads_User_id) as cnt

from cte

group by Content_type, Content_id

)

 

, cte3 as (

select Content_type, Content_id

, cnt, ROW_NUMBER() OVER(partition by Content_type ORDER BY cnt desc) as RowNumber

from cte

group by Content_type, Content_id,cnt

)

 

select Content_type, Content_id, cnt, RowNumber from cte3

where RowNumber <=5

order by Content_type, cnt;