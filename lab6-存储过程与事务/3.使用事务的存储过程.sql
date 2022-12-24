use finance1;

-- 在金融应用场景数据库中，编程实现一个转账操作的存储过程sp_transfer_balance，实现从一个帐户向另一个帐户转账。

-- 请补充代码完成该过程：

delimiter $$

CREATE PROCEDURE SP_TRANSFER(IN APPLICANT_ID INT, IN 
SOURCE_CARD_ID CHAR(30), IN RECEIVER_ID INT, IN DEST_CARD_ID 
CHAR(30), IN AMOUNT NUMERIC(10, 2), OUT RETURN_CODE 
INT) BEGIN 
	set autocommit = OFF;
	start transaction;
	update bank_card
	set
	    b_balance = b_balance - amount
	where
	    b_c_id = applicant_id
	    and b_number = source_card_id
	    and b_type = "储蓄卡";
	update bank_card
	set
	    b_balance = b_balance + amount
	where
	    b_c_id = receiver_id
	    and b_number = dest_card_id
	    and b_type = "储蓄卡";
	update bank_card
	set
	    b_balance = b_balance - amount
	where
	    b_c_id = receiver_id
	    and b_number = dest_card_id
	    and b_type = "信用卡";
	IF NOT EXISTS(
	    SELECT *
	    from bank_card
	    where
	        b_c_id = applicant_id
	        and b_number = source_card_id
	        and b_type = "储蓄卡"
	        and b_balance >= 0
	) then
	set return_code = 0;
	rollback;
	ELSEIF NOT EXISTS(
	    SELECT *
	    from bank_card
	    where
	        b_c_id = receiver_id
	        and b_number = dest_card_id
	) then
	set return_code = 0;
	rollback;
	else set return_code = 1;
	commit;
	END IF;
END$ 

$ 

delimiter ;

/*  end  of  your code  */