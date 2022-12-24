use finance1;

drop trigger if exists before_property_inserted;

-- 请在适当的地方补充代码，完成任务要求：

delimiter $$

CREATE TRIGGER BEFORE_PROPERTY_INSERTED BEFORE INSERT 
ON PROPERTY FOR EACH ROW BEGIN 
	DECLARE msg varchar(50);
	if new.pro_type != 1
	and new.pro_type != 2
	and new.pro_type != 3 then
	SET
	    msg = concat(
	        'type ',
	        new.pro_type,
	        ' is illegal!'
	    );
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
	end if;
	IF new.pro_type = 1
	AND NOT EXISTS(
	    SELECT p_id
	    FROM finances_product
	    WHERE
	        p_id = new.pro_pif_id
	) THEN
	SET
	    msg = concat(
	        'finances product #',
	        new.pro_pif_id,
	        ' not found!'
	    );
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
	END IF;
	IF new.pro_type = 2
	AND NOT EXISTS(
	    SELECT i_id
	    FROM insurance
	    WHERE
	        i_id = new.pro_pif_id
	) THEN
	SET
	    msg = concat(
	        'insurance #',
	        new.pro_pif_id,
	        ' not found!'
	    );
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
	END IF;
	IF new.pro_type = 3
	AND NOT EXISTS(
	    SELECT f_id
	    FROM fund
	    WHERE
	        f_id = new.pro_pif_id
	) THEN
	SET
	    msg = concat(
	        'fund #',
	        new.pro_pif_id,
	        ' not found!'
	    );
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
	END IF;
END$ 

$ 

delimiter ;