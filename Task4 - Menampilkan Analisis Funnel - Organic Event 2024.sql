select
    f.channel_source,
    count(*) as total_events,
    count(distinct f.order_id) as total_orders,
    round(count(distinct f.order_id)::numeric / count(*)::numeric * 100, 2) 
	as conversion_rate
from funnel_detail f
where f.event = 'Organic'
  and f.funnel_date between '2024-01-01' and '2024-12-31'
group by f.channel_source
order by conversion_rate desc;