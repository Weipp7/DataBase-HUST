-- 基于上一关创建的视图v_insurance_detail进行分组统计查询，列出每位客户的姓名，身份证号，保险投资总额(insurance_total_amount)和保险投资总收益(insurance_total_revenue),结果依保险投资总额降序排列。

--  请用一条SQL语句实现该查询：

select
    c_name,
    c_id_card,
    sum(i_amount * pro_quantity) as insurance_total_amount,
    sum(pro_income) as insurance_total_revenue
from v_insurance_detail
group by c_id_card
order by
    sum(i_amount * pro_quantity) desc;

-- select sum(i_amount) from v_insurance_detail group by c_id_card;

-- select sum(pro_income*pro_quantity) from v_insurance_detail group by c_id_card;

/*  end  of  your code  */

-- COLUMN_NAME	COLUMN_TYPE

-- c_id_card	char(18)

-- c_name	varchar(100)

-- i_amount	int

-- i_name	varchar(100)

-- i_project	varchar(200)

-- i_year	int

-- pro_income	int

-- pro_purchase_time	date

-- pro_quantity	int

-- pro_status	char(20)