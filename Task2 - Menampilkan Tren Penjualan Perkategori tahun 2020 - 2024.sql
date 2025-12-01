select
    p.category,
    sum(case when extract(year from o.order_date) = 2020 then o.quantity else 0 end) as quantity_2020,
    sum(case when extract(year from o.order_date) = 2021 then o.quantity else 0 end) as quantity_2021,
    sum(case when extract(year from o.order_date) = 2022 then o.quantity else 0 end) as quantity_2022,
    sum(case when extract(year from o.order_date) = 2023 then o.quantity else 0 end) as quantity_2023,
    sum(case when extract(year from o.order_date) = 2024 then o.quantity else 0 end) as quantity_2024
from order_detail o
join product_detail p on o.sku_id = p.sku_id
where extract(year from o.order_date) between 2020 and 2024
  and o.is_valid = 1
group by p.category
order by p.category;