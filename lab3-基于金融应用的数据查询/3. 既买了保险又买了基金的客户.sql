-- 3) 查询既买了保险又买了基金的客户的名称、邮箱和电话。结果依c_id排序

-- 请用一条SQL语句实现该

SELECT c_name, c_mail, c_phone
FROM client
WHERE c_id in(
        SELECT distinct pro_c_id
        FROM property
        WHERE pro_c_id in(
                SELECT
                    distinct pro_c_id
                FROM property
                WHERE
                    pro_type = 2
            )
            and pro_type = 3
    );

-- SELECT pro_type,pro_c_id FROM property;

-- SELECT distinct pro_c_id FROM property WHERE pro_c_id in(

--         SELECT distinct pro_c_id FROM property WHERE pro_type = 2

--     ) and pro_type =3;

-- SELECT pro_type,pro_c_id FROM property;

/*  end  of  your code  */