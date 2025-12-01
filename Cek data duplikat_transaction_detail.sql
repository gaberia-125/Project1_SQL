select
    transaction_id, transaction_date, customer_id, payment_method,
 	before_tax, tax, after_tax, shipping_cost, transaction_discount,
 	total_paid,
 	count (*) as jumlah_duplikat
from transaction_detail
group by
 	transaction_id, transaction_date, customer_id, payment_method,
 	before_tax, tax, after_tax, shipping_cost, transaction_discount,
 	total_paid
having count (*)>1;