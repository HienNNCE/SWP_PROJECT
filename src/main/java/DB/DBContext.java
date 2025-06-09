package DB;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBContext {
    
    private static final String URL = "jdbc:sqlserver://LAPTOP-FT0Q1NI1\\SQLEXPRESS:1433;databaseName=DriveXO;encrypt=true;trustServerCertificate=true";
    private static final String USER = "sa";
    private static final String PASSWORD = "123456";

    static {
        //Try to connect database and check exception
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Unable to load SQLServer JDBC Driver", e);
        }
    }

    //Sting connect by url database, acc,pass
    public Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
    
    //Test 
    public static void main(String[] args) {
        DBContext db = new DBContext();
        try (Connection conn = db.getConnection()) {
            if (conn != null && !conn.isClosed()) {
                System.out.println("Kết nối thành công đến DB!");
            } else {
                System.out.println("Kết nối thất bại!");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


}
