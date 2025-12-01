with reg as (
    select
        customer_id,
        registration_channel,
        date_trunc('month', registration_date)::date as reg_month
    from customer_detail
    where registration_date between '2024-01-01'::date
      and '2025-01-01'::date
),
first_tx as (
    select
        od.customer_id,
        min(od.order_date)::date as first_order_date
    from order_detail od
    where od.is_valid = 1
    group by od.customer_id
)
select
    r.reg_month as tanggal_registrasi,
    r.registration_channel as channel_registrasi,
    count(distinct r.customer_id) as Pelanggan_baru,
    round(
        avg((f.first_order_date - r.reg_month)::numeric),
        2
    ) as avg_days_to_first_order
from reg r
join first_tx f
    on r.customer_id = f.customer_id
group by r.reg_month, r.registration_channel
order by r.reg_month, r.registration_channel;