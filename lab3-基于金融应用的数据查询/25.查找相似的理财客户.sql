-- 6) 查找相似的理财客户

--   请用一条SQL语句实现该查询：

-- 6) 查找相似的理财客户

--   请用一条SQL语句实现该查询：

SELECT
    pac,
    pbc,
    common,
    crank
FROM(
        SELECT
            pac,
            pbc,
            common,
            rank() over(
                partition by pac
                order by
                    common desc,
                    pbc
            ) as crank
        FROM(
                SELECT
                    R1.pro_c_id pac,
                    R2.pro_c_id pbc,
                    COUNT(*) common
                FROM(
                        SELECT
                            pro_c_id,
                            pro_pif_id
                        FROM property
                        WHERE
                            pro_type = 1
                    ) AS R1, (
                        SELECT
                            pro_c_id,
                            pro_pif_id
                        FROM property
                        WHERE
                            pro_type = 1
                    ) AS R2
                WHERE
                    R1.pro_pif_id = R2.pro_pif_id
                    AND R1.pro_c_id <> R2.pro_c_id
                GROUP BY
                    R1.pro_c_id,
                    R2.pro_c_id
                ORDER BY
                    R1.pro_c_id
            ) AS R1(pac, pbc, common)
    ) AS R2(pac, pbc, common, crank)
WHERE
    R2.crank < 3
    /*  end  of  your code  */
    /*  end  of  your code  */