use finance1;

set global log_bin_trust_function_creators=1;

drop function IF EXISTS get_deposit;

/*
 用create function语句创建符合以下要求的函数：
 依据客户编号计算该客户所有储蓄卡的存款总额。
 函数名为：get_Records。函数的参数名可以自己命名:*/

delimiter $$

CREATE FUNCTION GET_DEPOSIT(CLIENT_ID INT) RETURNS 
NUMERIC(10, 2) BEGIN 
	declare deposit numeric(10,2);
	select
	    sum(b_balance) into deposit
	from bank_card
	where
	    b_type = '储蓄卡'
	    and b_c_id = client_id;
	return deposit;
END$ 

$ 

delimiter ;

/*  应用该函数查询存款总额在100万以上的客户身份证号，姓名和存储总额(total_deposit)，
 结果依存款总额从高到代排序  */

select
    c_id_card,
    c_name,
    get_deposit(c_id) as total_deposit
from client
where
    get_deposit(c_id) >= 1000000
order by
    get_deposit(c_id) desc;

/*  代码文件结束     */