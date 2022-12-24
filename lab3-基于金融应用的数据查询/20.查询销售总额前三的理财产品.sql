-- 1) 查询销售总额前三的理财产品

--   请用一条SQL语句实现该查询：

-- SELECT YEAR(pro_purchase_time) as  pyear,p_id,sum(p_amount) as sumamount from property,finances_product

-- where pro_type=1

-- and (YEAR(pro_purchase_time) = 2010 or YEAR(pro_purchase_time) = 2011)

-- and pro_pif_id = p_id

-- ;

-- SELECT rank() over(order by sum(p_amount * pro_quantity) desc) as rk,p_id,sum(p_amount * pro_quantity) as sumamount from property

-- left join finances_product

-- on pro_pif_id = p_id

-- where (YEAR(pro_purchase_time) = 2010 )

-- and pro_type = 1

-- group by p_id

-- -- order by sumamount desc

-- union all

-- (SELECT rank() over(order by sum(p_amount * pro_quantity) desc) as rk,p_id,sum(p_amount * pro_quantity) as sumamount from property

-- left join finances_product

-- on pro_pif_id = p_id

-- where (YEAR(pro_purchase_time) = 2011 )

-- and pro_type = 1

-- group by p_id

-- -- order by sumamount desc

-- limit 3)

-- ;

SELECT
    distinct t2.year as pyear,
    t1.rk,
    t1.p_id,
    t1.sumamount
from (
        SELECT rank() over(
                order by
                    sum(p_amount * pro_quantity) desc
            ) as rk,
            p_id,
            sum(p_amount * pro_quantity) as sumamount
        from property
            left join finances_product on pro_pif_id = p_id
        where (YEAR(pro_purchase_time) = 2010)
            and pro_type = 1
        group by
            p_id --   order by sumamount desc
            -- union all
            -- (SELECT rank() over(order by sum(p_amount * pro_quantity) desc) as rk,p_id,sum(p_amount * pro_quantity) as sumamount from property
            -- left join finances_product
            -- on pro_pif_id = p_id
            -- where (YEAR(pro_purchase_time) = 2011 )
            -- and pro_type = 1
            -- group by p_id
            --   order by sumamount desc
            -- limit 3)
    ) t1
    left join (
        SELECT
            YEAR(pro_purchase_time) as year,
            pro_pif_id as id
        from property
        where
            YEAR(pro_purchase_time) = 2010
    ) t2 on t1.p_id = t2.id
union all
SELECT
    distinct t4.year as pyear,
    t3.rk,
    t3.p_id,
    t3.sumamount
from (
        -- SELECT rank() over(order by sum(p_amount * pro_quantity) desc) as rk,p_id,sum(p_amount * pro_quantity) as sumamount from property
        -- left join finances_product
        -- on pro_pif_id = p_id
        -- where (YEAR(pro_purchase_time) = 2010 )
        -- and pro_type = 1
        -- group by p_id
        --   order by sumamount desc
        -- union all (
            SELECT rank() over(
                    order by
                        sum(p_amount * pro_quantity) desc
                ) as rk,
                p_id,
                sum(p_amount * pro_quantity) as sumamount
            from property
                left join finances_product on pro_pif_id = p_id
            where (YEAR(pro_purchase_time) = 2011)
                and pro_type = 1
            group by p_id
            order by sumamount desc
            limit 3
        )
    ) t3
    left join (
        SELECT
            YEAR(pro_purchase_time) as year,
            pro_pif_id as id
        from property
        where
            YEAR(pro_purchase_time) = 2011
    ) t4 on t3.p_id = t4.id;

-- SELECT YEAR(pro_purchase_time) as year,pro_pif_id as id from property

-- where YEAR(pro_purchase_time) = 2010;

/*  end  of  your code  */