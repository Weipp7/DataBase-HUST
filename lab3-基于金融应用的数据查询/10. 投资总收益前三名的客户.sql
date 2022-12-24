-- 10) 查询当前总的可用资产收益(被冻结的资产除外)前三名的客户的名称、身份证号及其总收益，按收益降序输出，总收益命名为total_income。不考虑并列排名情形。

--    请用一条SQL语句实现该查询：

SELECT
    c_name,
    c_id_card,
    SUM(pro_income) AS total_income
FROM client, property
WHERE
    c_id = pro_c_id
    AND pro_status = '可用'
GROUP BY pro_c_id
ORDER BY SUM(pro_income) DESC
LIMIT 3;

-- SELECT SUM(pro_income) FROM property

-- WHERE pro_status = '可用'

-- GROUP BY pro_c_id

-- ORDER BY SUM(pro_income) DESC

-- LIMIT 3

-- ;

/*  end  of  your code  */