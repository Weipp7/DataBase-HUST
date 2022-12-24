-- 4) 	查找相似的理财产品

--   请用一条SQL语句实现该查询：

-- select pro_c_id

-- from property

-- where pro_type = 1

-- and pro_pif_id = 14

-- ;

-- select pro_pif_id from property

-- where pro_c_id = 200

-- and pro_type = 1

-- ;

-- select distinct pro_pif_id from property

-- where pro_c_id in (

--     select pro_c_id

-- from property

-- where pro_type = 1

-- and pro_pif_id = 14

-- )

-- and pro_type = 1

-- ;

select
    pro_pif_id,
    count(pro_c_id) as cc,
    dense_rank() over(
        order by
            count(pro_c_id) desc
    ) as prank
from property
where pro_pif_id in (
        select distinct pro_pif_id
        from property
        where pro_c_id in (
                select pro_c_id
                from property
                where
                    pro_type = 1
                    and pro_pif_id = 14
            )
            and pro_type = 1
    )
    and pro_type = 1
    and pro_pif_id != 14
group by pro_pif_id
order by pro_pif_id;

/*  end  of  your code  */