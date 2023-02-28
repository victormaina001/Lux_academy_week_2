with t as (
select submission_date,
       h.hacker_id,
       name,
       count( submission_id) as sb, 
       dense_rank() over (partition by h.hacker_id order by submission_date) as sd,
       dense_rank() over (partition by submission_date order by count(*) desc,h.hacker_id ) as hd1   
from hackers h inner join submissions s on h.hacker_id=s.hacker_id
group by submission_date,h.hacker_id,name
    ),
t1 as (
select t.*,
       dense_rank() over (partition by submission_date order by sb desc,hacker_id ) as hd2,
       count( hacker_id) over (partition by submission_date) as psd
from t where sd=datediff(day,'2016-03-01',submission_date)+1
        )
select t.submission_date,t1.psd,t.hacker_id,t.name from t inner join t1 on t.submission_date=t1.submission_date
where t1.hd2=1 and t.hd1=1
order by 1;