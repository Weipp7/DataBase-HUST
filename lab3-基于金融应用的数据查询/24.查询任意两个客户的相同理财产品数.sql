-- 5) 查询任意两个客户的相同理财产品数

--   请用一条SQL语句实现该查询：

-- select t1.pro_c_id,t2.pro_c_id from property t1,property t2

-- where t1.pro_c_id != t2.pro_c_id

-- and t1.pro_type = 1

-- and t2.pro_type = 1

-- and t1.pro_pif_id = t2.pro_pif_id

-- and ((t1.pro_c_id = 600 and t2.pro_c_id = 1000) or (t2.pro_c_id = 600 and t1.pro_c_id = 1000))

-- ;

select
    distinct t3.id111 as pro_c_id,
    t3.id222 as pro_c_id,
    t5.num as total_count
from (
        select
            t1.pro_c_id as id111,
            t2.pro_c_id as id222
        from property t1, property t2
        where
            t1.pro_c_id != t2.pro_c_id
            and t1.pro_type = 1
            and t2.pro_type = 1
            and t1.pro_pif_id = t2.pro_pif_id
            and ( (
                    t1.pro_c_id = 600
                    and t2.pro_c_id = 1000
                )
                or (
                    t2.pro_c_id = 600
                    and t1.pro_c_id = 1000
                )
            )
    ) t3, (
        select
            distinct count(t4.id111) as num
        from (
                select
                    t1.pro_c_id as id111,
                    t2.pro_c_id as id222
                from property t1, property t2
                where
                    t1.pro_c_id != t2.pro_c_id
                    and t1.pro_type = 1
                    and t2.pro_type = 1
                    and t1.pro_pif_id = t2.pro_pif_id
                    and ( (
                            t1.pro_c_id = 600
                            and t2.pro_c_id = 1000
                        )
                        or (
                            t2.pro_c_id = 600
                            and t1.pro_c_id = 1000
                        )
                    )
            ) t4
        group by t4.id111
    ) t5
where t5.num > 1
order by t3.id111;

-- where (

--     select distinct count(t4.id111) from

--     (

--        select t1.pro_c_id as id111,t2.pro_c_id as id222 from property t1,property t2

-- where t1.pro_c_id != t2.pro_c_id

-- and t1.pro_type = 1

-- and t2.pro_type = 1

-- and t1.pro_pif_id = t2.pro_pif_id

-- and ((t1.pro_c_id = 600 and t2.pro_c_id = 1000) or (t2.pro_c_id = 600 and t1.pro_c_id = 1000))

--     ) t4

--      group by t4.id111

-- ) > 1

;

-- select t3.id1 as id11,t3.id2 as id22,t4.num

-- from (

--     select t1.pro_c_id as id1,t2.pro_c_id as id2 from property t1,property t2

-- where t1.pro_c_id != t2.pro_c_id

-- and t1.pro_type = 1

-- and t2.pro_type = 1

-- and t1.pro_pif_id = t2.pro_pif_id

-- ) t3 left join

-- (

--     select count(t4.id111) as num,t4.id111 from

--     (

--        select t1.pro_c_id as id111,t2.pro_c_id as id222 from property t1,property t2

-- where t1.pro_c_id != t2.pro_c_id

-- and t1.pro_type = 1

-- and t2.pro_type = 1

-- and t1.pro_pif_id = t2.pro_pif_id

-- and ((t1.pro_c_id = 600 and t2.pro_c_id = 1000) or (t2.pro_c_id = 600 and t1.pro_c_id = 1000))

--     )

-- ) t4

-- on t4.id111 = t3.id111

-- ;

-- select count(pro_pif_id) from property

-- group by pro_c_id;

/*  end  of  your code  */