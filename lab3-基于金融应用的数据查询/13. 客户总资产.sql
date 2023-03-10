-- 13) 综合客户表(client)、资产表(property)、理财产品表(finances_product)、

--     保险表(insurance)、基金表(fund)和投资资产表(property)，

--     列出所有客户的编号、名称和总资产，总资产命名为total_property。

--     总资产为储蓄卡余额，投资总额，投资总收益的和，再扣除信用卡透支的金额

--     (信用卡余额即为透支金额)。客户总资产包括被冻结的资产。

--    请用一条SQL语句实现该查询：

select
    c_id,
    c_name,
    ifnull(
        total_amount + total_income + table2.t2,
        0
    ) as total_property
from (
        select
            c_name,
            c_id,
            ifnull(sum(pro_amount), 0) as total_amount,
            sum(pro_income) as total_income
        from client
            left join (
                select
                    pro_c_id,
                    pro_income,
                    pro_quantity * p_amount as pro_amount
                from
                    property,
                    finances_product
                where
                    pro_pif_id = p_id
                    and pro_type = 1
                union all
                select
                    pro_c_id,
                    pro_income,
                    pro_quantity * i_amount as pro_amount
                from
                    property,
                    insurance
                where
                    pro_pif_id = i_id
                    and pro_type = 2
                union all
                select
                    pro_c_id,
                    pro_income,
                    pro_quantity * f_amount as pro_amount
                from property, fund
                where
                    pro_pif_id = f_id
                    and pro_type = 3
            ) pro on pro.pro_c_id = c_id
        group by c_id
    ) AS table1
    left join(
        select
            b1.b_c_id,
            b1.tadd - IFNULL(b2.tsub, 0) AS t2
        from(
                select
                    b_c_id,
                    sum(b_balance) as tadd
                from bank_card
                where b_type = '储蓄卡'
                group by b_c_id
            ) b1
            left join (
                select
                    b_c_id,
                    sum(b_balance) as tsub
                from bank_card
                where b_type = '信用卡'
                group by
                    b_c_id
            ) b2 on b1.b_c_id = b2.b_c_id
    ) AS table2 on table1.c_id = table2.b_c_id;

/*  end  of  your code  */