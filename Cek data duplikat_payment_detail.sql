select
    id,payment_method,
 	count (*) as jumlah_duplikat
from payment_detail
group by
 	id,payment_method
having count (*)>1;