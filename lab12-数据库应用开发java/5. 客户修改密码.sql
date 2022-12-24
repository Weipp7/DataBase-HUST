import java.sql.*;

import java.util.Scanner;

public class ChangePass{static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";

static final String DB_URL = "jdbc:mysql://127.0.0.1:3306/finance?allowPublicKeyRetrieval=true&useUnicode=true&characterEncoding=UTF8&useSSL=false&serverTimezone=UTC";

static final String USER = "root";

static final String PASS = "123123";

/**
 * 修改客户密码
 *
 * @param connection 数据库连接对象
 * @param mail 客户邮箱,也是登录名
 * @param password 客户登录密码
 * @param newPass  新密码
 * @return
 *   1 - 密码修改成功
 *   2 - 用户不存在
 *   3 - 密码不正确
 *  -1 - 程序异常(如没能连接到数据库等）
 */

public static int passwd(
    Connection connection,
    String mail,
    String password,
    String newPass
){PreparedStatement statement = null;

ResultSet resultSet = null;

int n=0;

try{String sql1 = "update client set c_password = ? where c_mail = ? and c_password = ?";

String sql2 = "select * from client where c_mail = ?";

String sql3 = "select * from client where c_mail = ? and c_password = ?";

statement = connection.prepareStatement(sql2);

statement.setString(1,mail);

resultSet = statement.executeQuery();

if(resultSet.next()){statement = connection.prepareStatement(sql3);

statement.setString(1,mail);

statement.setString(2,password);

resultSet = statement.executeQuery();

if(resultSet.next()){statement = connection.prepareStatement(sql1);

statement.setString(1,newPass);

statement.setString(2,mail);

statement.setString(3,password);

statement.executeUpdate();

return 1;

} else return 3;

} else return 2;

}catch (SQLException throwables){throwables.printStackTrace();

return -1;

}}/ / 不要修改main() public static void main(String [] args) throws Exception{Scanner sc = new Scanner(System.in);

Class.forName(JDBC_DRIVER);

Connection connection = DriverManager.getConnection(DB_URL, USER, PASS);

while
(sc.hasNext()){String input = sc.nextLine();

if(input.equals("")) break;

String[]commands = input.split(" ");

if(commands.length ==0) break;

String email = commands[0];

String pass = commands[1];

String pwd1 = commands[2];

String pwd2 = commands[3];

if (pwd1.equals(pwd2)){int n = passwd(connection, email, pass, pwd1);

System.out.println("return: " + n);

} else { System.out.println("两次输入的密码不一样!");

} } } } 