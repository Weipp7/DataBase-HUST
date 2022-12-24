-- 4) 查询办理了储蓄卡的客户名称、手机号、银行卡号。 查询结果结果依客户编号排序。

--    请用一条SQL语句实现该查询：

-- SELECT distinct c_name,c_phone,b_number,c_id

-- FROM client,bank_card

-- WHERE c_id in (

--     SELECT b_c_id FROM bank_card WHERE b_type = '储蓄卡' ORDER BY b_c_id DESC

-- )

-- AND b_c_id = c_id

-- AND b_type = '储蓄卡'

-- ORDER BY c_id,b_number ASC;

-- SELECT b_c_id FROM bank_card WHERE b_type = '储蓄卡';

-- SELECT b_type FROM bank_card WHERE b_c_id = 1600;

/*  end  of  your code  */

-- SELECT c_name,c_phone,b_number

-- FROM bank_card

-- INNER JOIN client

-- ON client.c_id = bank_card.b_c_id

-- WHERE b_type = '储蓄卡'

-- order by c_id,b_balance DESC;

select
    c_name,
    c_phone,
    b_number
from client, bank_card
where
    c_id = b_c_id
    and b_type = "储蓄卡"
order by c_id;