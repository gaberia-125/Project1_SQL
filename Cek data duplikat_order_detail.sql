select
    transaction_id, order_id, order_date, customer_id, channel_type,
 	sku_id, quantity, price, discount_item, is_gross, is_valid,
    is_valid, is_net,
 	count (*) as jumlah_duplikat
from order_detail
group by
 	transaction_id, order_id, order_date, customer_id, channel_type,
 	sku_id, quantity, price, discount_item, is_gross, is_valid,
    is_valid, is_net
having count (*)>1;