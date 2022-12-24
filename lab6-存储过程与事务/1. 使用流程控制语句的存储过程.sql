use fib;

-- 创建存储过程`sp_fibonacci(in m int)`，向表fibonacci插入斐波拉契数列的前m项，及其对应的斐波拉契数。fibonacci表初始值为一张空表。请保证你的存储过程可以多次运行而不出错。

drop procedure if exists sp_fibonacci;

delimiter $$

CREATE PROCEDURE SP_FIBONACCI(IN M INT) BEGIN 
	######## 请补充代码完成存储过程体 ######## DECLARE fib0,fib1,fibn,n int;
	set fib0=0,fib1=1,n=2;
	if m>=1 then insert into fibonacci values (0,0);
	end if;
	if m>=2 then insert into fibonacci values (1,1);
	end if;
	while m>n do set fibn = fib0 + fib1;
	insert into fibonacci values (n,fibn);
	set fib0 = fib1;
	set fib1 = fibn;
	set n=n+1;
	end while;
	end 
$ 

$ 

delimiter ;