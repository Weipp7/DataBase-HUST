use finance1;

-- 请用一条SQL语句删除client表中没有银行卡的客户信息：

delete from client where c_id NOT IN(SELECT b_c_id FROM bank_card);

/* the end of your code */