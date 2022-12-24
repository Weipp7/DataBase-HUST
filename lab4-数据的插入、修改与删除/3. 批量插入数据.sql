use finance1;

-- 已知表new_client保存了一批新客户信息，该表与client表结构完全相同。请用一条SQL语句将new_client表的全部客户信息插入到客户表(client):

--  c_id	INTEGER	PRIMARY KEY	客户编号

-- c_name	VARCHAR(100)	NOT NULL	客户名称

-- c_mail	CHAR(30)	UNIQUE	客户邮箱

-- c_id_card	CHAR(20)	UNIQUE NOT NULL	客户身份证

-- c_phone	CHAR(20)	UNIQUE NOT NULL	客户手机号

-- c_password

insert into
    client (
        c_id,
        c_name,
        c_mail,
        c_id_card,
        c_phone,
        c_password
    )
select
    c_id,
    c_name,
    c_mail,
    c_id_card,
    c_phone,
    c_password
from new_client;

/* the end of your code */