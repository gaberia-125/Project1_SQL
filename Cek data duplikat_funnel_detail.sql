select
    funnel_id, channel_source, customer_id, sku_id, funnel_date,
 	status, event, order_id,
 	count (*) as jumlah_duplikat
from funnel_detail
group by
 	funnel_id, channel_source, customer_id, sku_id, funnel_date,
 	status, event, order_id
having count (*)>1;