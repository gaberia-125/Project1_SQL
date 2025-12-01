with revenue_summary as (
    select
        extract(year from order_date) as tahun,
        extract(month from order_date) as bulan,
        channel_type,
        count(distinct order_id) as total_orders,
        sum(after_discount) as revenue
    from order_detail
    where extract(year from order_date) in (2023, 2024)
      and is_valid = 1
    group by extract(year from order_date), extract(month from order_date), channel_type
)

select
    a.bulan,
    a.channel_type,
	b.total_orders as total_orders_2023,
    b.revenue as revenue_2023,
    a.total_orders as total_orders_2024,
    a.revenue as revenue_2024,
    case 
        when b.revenue = 0 or b.revenue is null then null
        else round(((a.revenue::numeric - b.revenue::numeric) / b.revenue::numeric) * 100, 2)
    end as mom_growth_pct
from revenue_summary a
left join revenue_summary b
    on a.bulan = b.bulan
   and a.channel_type = b.channel_type
   and b.tahun = 2023
where a.tahun = 2024
  and a.channel_type in ('Website', 'App Store', 'Offline Store')
order by a.bulan, a.channel_type;