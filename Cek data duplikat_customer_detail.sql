select
    customer_id, registration_date, customer_name, customer_type, dob,
 	province, registration_channel,
 	count (*) as jumlah_duplikat
from customer_detail
group by
 	customer_id, registration_date, customer_name, customer_type, dob,
 	province, registration_channel
having count (*)>1;