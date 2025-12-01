select
    extract(month from transaction_date) as bulan,
    sum(total_paid) as total_sales
from transaction_detail
where extract(year from transaction_date) = 2024
group by extract(month from transaction_date)
order by bulan;