import java.sql.*;

public class Transform{static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";

static final String DB_URL = "jdbc:mysql://127.0.0.1:3306/sparsedb?allowPublicKeyRetrieval=true&useUnicode=true&characterEncoding=UTF8&useSSL=false&serverTimezone=UTC";

static final String USER = "root";

static final String PASS = "123123";

/**
 * 向sc表中插入数据
 *
 */

public static int insertSC(
    Connection connection,
    int sno,
    String col_name,
    String col_value
){PreparedStatement pps = null;

ResultSet resultSet = null;

try{String sql = "insert into sc (sno,col_name,col_value) values (?,?,?)";

pps = connection.prepareStatement(sql);

pps.setInt(1,sno);

pps.setString(2,col_name);

pps.setString(3,col_value);

pps.execute();

}catch (SQLException throwables){throwables.printStackTrace();

} return 0;

}public static void main(String [] args) throws Exception{Class.forName(JDBC_DRIVER);

Connection connection = DriverManager.getConnection(DB_URL, USER, PASS);

PreparedStatement pps = null;

ResultSet resultSet = null;

int sno=0;

String col_name;

String col_value;

try{ String sql = "select * from entrance_exam";

pps=connection.prepareStatement(sql);

resultSet = pps.executeQuery();

while
(resultSet.next()){/ / resultSet.getString("c_name") sno = resultSet.getInt("sno");

col_value = resultSet.getString("chinese");

if(col_value != null){/ / System.out.print(col_value);

insertSC(connection,sno,"chinese",col_value);

} sno = resultSet.getInt("sno");

col_value = resultSet.getString("math");

if(col_value != null) insertSC(
    connection,
    sno,
    "math",
    col_value
);

sno = resultSet.getInt("sno");

col_value = resultSet.getString("english");

if(col_value != null) insertSC(
    connection,
    sno,
    "english",
    col_value
);

sno = resultSet.getInt("sno");

col_value = resultSet.getString("physics");

if(col_value != null) insertSC(
    connection,
    sno,
    "physics",
    col_value
);

sno = resultSet.getInt("sno");

col_value = resultSet.getString("chemistry");

if(col_value != null) insertSC(
    connection,
    sno,
    "chemistry",
    col_value
);

sno = resultSet.getInt("sno");

col_value = resultSet.getString("biology");

if(col_value != null) insertSC(
    connection,
    sno,
    "biology",
    col_value
);

sno = resultSet.getInt("sno");

col_value = resultSet.getString("history");

if(col_value != null) insertSC(
    connection,
    sno,
    "history",
    col_value
);

sno = resultSet.getInt("sno");

col_value = resultSet.getString("geography");

if(col_value != null) insertSC(
    connection,
    sno,
    "geography",
    col_value
);

sno = resultSet.getInt("sno");

col_value = resultSet.getString("politics");

if(col_value != null) insertSC(
    connection,
    sno,
    "politics",
    col_value
);

}}catch (SQLException throwables){throwables.printStackTrace();

} } } 