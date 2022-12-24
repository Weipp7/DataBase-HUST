-- 3) 查询购买了所有畅销理财产品的客户

--   请用一条SQL语句实现该查询：

-- select  t1.pro_pif_id from

-- (select count(pro_c_id) as num,pro_pif_id  from property

-- where pro_type = 1

-- group by pro_pif_id) t1

-- where t1.num >2

-- ;

select c.pro_c_id
from (
        select
            a.pro_c_id,
            a.pro_pif_id
        from(
                select
                    pro_c_id,
                    pro_pif_id
                from property
                where
                    pro_pif_id = 14
                    and pro_type = 1
            ) a
            inner join (
                select
                    pro_c_id,
                    pro_pif_id
                from property
                where
                    pro_pif_id = 5
                    and pro_type = 1
            ) b on a.pro_c_id = b.pro_c_id
    ) c
    inner join(
        select
            pro_c_id,
            pro_pif_id
        from property
        where
            pro_pif_id = 4
            and pro_type = 1
    ) d on c.pro_c_id = d.pro_c_id;

-- select pro_c_id from property

-- where pro_pif_id = 4;

-- select pro_c_id from property

-- where pro_pif_id = 5;

-- select pro_c_id from property

-- where pro_pif_id = 14;

/*  end  of  your code  */