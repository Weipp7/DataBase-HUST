-- 2) 投资积极且偏好理财类产品的客户

--   请用一条SQL语句实现该查询：

-- select pro_c_id from property

-- where  (

--   select count(pro_pif_id) from property

--   where pro_type = 1

--   group by pro_c_id

-- ) >3;

select
    t1.id as pro_c_id
from (
        select
            count(pro_pif_id) as num,
            pro_c_id as id
        from property
        where pro_type = 1
        group by pro_c_id
    ) t1, (
        select
            count(pro_pif_id) as num,
            pro_c_id as id
        from property
        where pro_type = 3
        group by pro_c_id
    ) t2
where
    t1.num > 3
    and t1.id = t2.id
    and t1.num > t2.num;

/*  end  of  your code  */