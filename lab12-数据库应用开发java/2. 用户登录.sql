import java.sql.*;

import java.util.Scanner;

public class Login{public static void main(String [] args){Connection connection = null;

/ / 申明下文中的resultSet,
statement PreparedStatement statement = null;

// Statement statement = null;

ResultSet resultSet = null;

Scanner input = new Scanner(System.in);

System.out.print("请输入用户名：");

String loginName = input.nextLine();

System.out.print("请输入密码：");

String loginPass = input.nextLine();

try { Class.forName("com.mysql.cj.jdbc.Driver");

String userName = "root";

String passWord = "123123";

String url = "jdbc:mysql://127.0.0.1:3306/finance?useUnicode=true&characterEncoding=UTF8&useSSL=false&serverTimezone=UTC";

connection = DriverManager.getConnection(url, userName, passWord);

/ / 补充实现代码: String sql = "select * from client where c_mail = ? and c_password = ?;";

statement = connection.prepareStatement(sql);

statement.setString(1,loginName);

statement.setString(2,loginPass);

resultSet = statement.executeQuery();

// resultSet.next();

// System.out.print(resultSet.getString("c_name"));

if(resultSet.next()){System.out.print("登录成功。\n");

} else System.out.print("用户名或密码错误！\n");

}catch (ClassNotFoundException e){e.printStackTrace();

}catch (SQLException throwables){throwables.printStackTrace();

}finally{try{if (resultSet != null){resultSet.close();

}if (statement != null){statement.close();

}if (connection != null){connection.close();

}}catch (SQLException throwables){throwables.printStackTrace();

} } } } 