# 请在以下适当的空白处填写SQL语句，完成任务书的要求。空白行可通过回车换行添加。 drop database TesbDb;

CREATE database TesbDb;

use TestDb;

CREATE TABLE
    t_emp (
        id INT PRIMARY KEY,
        name VARCHAR(32),
        deptId INT,
        salary FLOAT
    );

/* *********** 结束 ************* */