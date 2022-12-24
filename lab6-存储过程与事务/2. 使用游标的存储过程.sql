-- 编写一存储过程，自动安排某个连续期间的大夜班的值班表:

delimiter $$

CREATE PROCEDURE SP_NIGHT_SHIFT_ARRANGE(IN START_DATE 
DATE, IN END_DATE DATE) BEGIN 
	declare nowdate date;
	declare not_found_flag INT default FALSE;
	declare maindoc INT default FALSE;
	declare d_name,n_name1,n_name2 char(30);
	declare temp_name char(30);
	declare d_type int default(0);
	declare doc cursor for
	select e_name, e_type
	from employee
	where e_type != 3;
	declare nurse cursor for
	select e_name
	from employee
	where e_type = 3;
	declare continue handler for NOT FOUND set not_found_flag = TRUE;
	open doc;
	open nurse;
	fetch doc into d_name,d_type;
	fetch nurse into n_name1;
	fetch nurse into n_name2;
	set nowdate = start_date;
	while nowdate <= end_date
	do
	    if d_type = 1
	    and (
	        dayofweek(nowdate) = 1
	        or dayofweek(nowdate) = 7
	    ) then
	set temp_name = d_name;
	set maindoc = TRUE;
	fetch doc into d_name,d_type;
	if not_found_flag = TRUE then set not_found_flag = FALSE;
	close doc;
	open doc;
	fetch doc into d_name,d_type;
	end if;
	insert into
	    night_shift_schedule
	values
	(
	        nowdate,
	        d_name,
	        n_name1,
	        n_name2
	    );
	set nowdate = date_sub(nowdate,interval -1 day);
	fetch doc into d_name,d_type;
	if not_found_flag = TRUE then set not_found_flag = FALSE;
	close doc;
	open doc;
	fetch doc into d_name,d_type;
	end if;
	fetch nurse into n_name1;
	if not_found_flag = TRUE then set not_found_flag = FALSE;
	close nurse;
	open nurse;
	fetch nurse into n_name1;
	end if;
	fetch nurse into n_name2;
	if not_found_flag = TRUE then set not_found_flag = FALSE;
	close nurse;
	open nurse;
	fetch nurse into n_name2;
	end if;
	elseif dayofweek(nowdate) = 2
	and maindoc = TRUE then
	set maindoc = FALSE;
	insert into
	    night_shift_schedule
	values
	(
	        nowdate,
	        temp_name,
	        n_name1,
	        n_name2
	    );
	set nowdate = date_sub(nowdate,interval -1 day);
	fetch nurse into n_name1;
	if not_found_flag = TRUE then set not_found_flag = FALSE;
	close nurse;
	open nurse;
	fetch nurse into n_name1;
	end if;
	fetch nurse into n_name2;
	if not_found_flag = TRUE then set not_found_flag = FALSE;
	close nurse;
	open nurse;
	fetch nurse into n_name2;
	end if;
	else
	insert into
	    night_shift_schedule
	values
	(
	        nowdate,
	        d_name,
	        n_name1,
	        n_name2
	    );
	set nowdate = date_sub(nowdate,interval -1 day);
	fetch doc into d_name,d_type;
	if not_found_flag = TRUE then set not_found_flag = FALSE;
	close doc;
	open doc;
	fetch doc into d_name,d_type;
	end if;
	fetch nurse into n_name1;
	if not_found_flag = TRUE then set not_found_flag = FALSE;
	close nurse;
	open nurse;
	fetch nurse into n_name1;
	end if;
	fetch nurse into n_name2;
	if not_found_flag = TRUE then set not_found_flag = FALSE;
	close nurse;
	open nurse;
	fetch nurse into n_name2;
	end if;
	end if;
	end while;
	close doc;
	close nurse;
END$ 

$ 

delimiter ;

/*  end  of  your code  */