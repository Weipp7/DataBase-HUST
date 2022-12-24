-- 12) 综合客户表(client)、资产表(property)、理财产品表(finances_product)、保险表(insurance)和

--     基金表(fund)，列出客户的名称、身份证号以及投资总金额（即投资本金，

--     每笔投资金额=商品数量*该产品每份金额)，注意投资金额按类型需要查询不同的表，

--     投资总金额是客户购买的各类资产(理财,保险,基金)投资金额的总和，总金额命名为total_amount。

--     查询结果按总金额降序排序。

-- 请用一条SQL语句实现该查询：

-- 把资产表作为基表和其他表合并，之后再查询算总和

-- SELECT c_name,c_id_card,

-- SUM((SELECT f_amount FROM fund,property

-- WHERE pro_pif_id = f_id

-- AND pro_type = 3) *

-- (SELECT pro_quantity FROM property

-- WHERE pro_type = 3)

-- +

-- (SELECT i_amount FROM insurance,property

-- WHERE pro_pif_id = i_id

-- AND pro_type = 2) *

-- (SELECT pro_quantity FROM property

-- WHERE pro_type = 2)

-- +

-- (SELECT p_amount FROM finances_product,property

-- WHERE pro_pif_id = p_id

-- AND pro_type = 1) *

-- (SELECT pro_quantity FROM property

-- WHERE pro_type = 1))

-- AS total_amount

-- FROM client,property,finances_product,insurance,fund

-- WHERE c_id = pro_c_id

-- GROUP BY pro_c_id

-- ORDER BY total_amount DESC;

-- SELECT i1*i2 AS i

-- FROM

-- (SELECT i_amount AS i1 FROM insurance,property

-- WHERE pro_pif_id = i_id

-- AND pro_type = 2) AS I1,

-- (SELECT pro_quantity AS i2 FROM property

-- WHERE pro_type = 2) AS I2

-- ;

--     SELECT f1*f2 AS f,pro_c_id

-- FROM

-- (SELECT f_amount AS f1 FROM fund,property

-- WHERE pro_pif_id = f_id

-- AND pro_type = 3) AS F1,

-- (SELECT pro_quantity AS f2 FROM property

-- WHERE pro_type = 3 ) AS F2,property

-- AS F;

--     SELECT i1*i2 AS i,pro_c_id

-- FROM

-- (SELECT i_amount AS i1 FROM insurance,property

-- WHERE pro_pif_id = i_id

-- AND pro_type = 2) AS I1,

-- (SELECT pro_quantity AS i2 FROM property

-- WHERE pro_type = 2) AS I2,property

-- AS I;

-- SELECT COUNT(f),COUNT(i) FROM property

-- LEFT JOIN F,I

-- ON F.pro_c_id = pro_c_id

-- AND I.pro_c_id = pro_c_id;

-- SELECT pro_id,p_amount FROM property LEFT JOIN  finances_product

-- ON pro_pif_id = p_id

-- AND pro_type = 1;

select
    c_name,
    c_id_card,
    ifnull(sum(pro_amount), 0) as total_amount
from client
    left join (
        select
            pro_c_id,
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
            pro_quantity * f_amount as pro_amount
        from property, fund
        where
            pro_pif_id = f_id
            and pro_type = 3
    ) pro on pro.pro_c_id = c_id
group by c_id
order by total_amount desc;

/*  end  of  your code  */