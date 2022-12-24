import java.sql.*;

import java.util.Scanner;

public class Transfer{static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";

static final String DB_URL = "jdbc:mysql://127.0.0.1:3306/finance?allowPublicKeyRetrieval=true&useUnicode=true&characterEncoding=UTF8&useSSL=false&serverTimezone=UTC";

static final String USER = "root";

static final String PASS = "123123";

/**
 * 转账操作
 *
 * @param connection 数据库连接对象
 * @param sourceCard 转出账号
 * @param destCard 转入账号
 * @param amount  转账金额
 * @return boolean
 *   true  - 转账成功
 *   false - 转账失败
 */

public static boolean transferBalance(
    Connection connection,
    String sourceCard,
    String destCard,
    double amount
){PreparedStatement pps = null;

ResultSet resultSet = null;

boolean n = true;

try{ connection.setAutoCommit(false);

String SQL = "UPDATE bank_card SET b_balance = b_balance - ? WHERE b_number = ? AND b_type='储蓄卡';";

pps=connection.prepareStatement(SQL);

pps.setDouble(1,amount);

pps.setString(2,sourceCard);

pps.executeUpdate();

SQL = "UPDATE bank_card SET b_balance = b_balance + ? WHERE b_number = ? AND b_type='储蓄卡' ;";

pps=connection.prepareStatement(SQL);

pps.setDouble(1,amount);

pps.setString(2,destCard);

pps.executeUpdate();

SQL = "UPDATE bank_card SET b_balance = b_balance - ? WHERE b_number = ? AND b_type='信用卡' ;";

pps=connection.prepareStatement(SQL);

pps.setDouble(1,amount);

pps.setString(2,destCard);

pps.executeUpdate();

SQL = "SELECT * FROM bank_card WHERE b_number=? AND b_type='储蓄卡' ;";

pps=connection.prepareStatement(SQL);

pps.setString(1,sourceCard);

resultSet = pps.executeQuery();

if(!resultSet.next()){ n=false;

connection.rollback();

}
else{/ / 存在转出卡 if(
    resultSet.getDouble("b_balance") < 0
){/ / 当前b_balance为转出的状态 n = false;

connection.rollback();

}
else{/ / 判断转出卡是否存在 SQL = "SELECT * FROM bank_card WHERE b_number=? ;";

pps=connection.prepareStatement(SQL);

pps.setString(1,destCard);

resultSet = pps.executeQuery();

                    if(!resultSet.next()){
                        n=false;

connection.rollback();

} else connection.commit();

}}}catch (SQLException throwables){throwables.printStackTrace();

n = false;

}finally{try{if (pps != null){pps.close();

}if (resultSet != null){resultSet.close();

}}catch (SQLException throwables){throwables.printStackTrace();

n = false;

} } return n;

}/ / 不要修改main() public static void main(String [] args) throws Exception{Scanner sc = new Scanner(System.in);

Class.forName(JDBC_DRIVER);

Connection connection = DriverManager.getConnection(DB_URL, USER, PASS);

while
(sc.hasNext()){String input = sc.nextLine();

if(input.equals("")) break;

String[]commands = input.split(" ");

if(commands.length ==0) break;

String payerCard = commands[0];

String payeeCard = commands[1];

double amount = Double.parseDouble(commands[2]);

if (
    transferBalance(
        connection,
        payerCard,
        payeeCard,
        amount
    )
){System.out.println("转账成功。");

}
else{System.out.println("转账失败,请核对卡号，卡类型及卡余额!");

} } } } 