package DB;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DBContext {


    // Sửa DB_URL, DB_USER và DB_PWD cho phù hợp với Azure SQL
    private static final String DB_URL = "jdbc:sqlserver://dbswp.database.windows.net:1433;databaseName=DriveXO;encrypt=true;trustServerCertificate=false;hostNameInCertificate=*.database.windows.net;loginTimeout=30;";
    private static final String DB_USER = "sqladmin@dbswp";  // Tên người dùng Azure SQL
    private static final String DB_PWD = "admin@123";       // Mật khẩu của người dùng Azure SQL


    private Connection conn;

//    private static final String DB_URL = "jdbc:sqlserver://localhost:1433;databaseName=DriveXO;trustServerCertificate=true;";
//    private static final String DB_USER = "sa";
//    private static final String DB_PWD = "1234";
    public DBContext() {
        try {
            // Load the SQLServer driver
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            // Establish the connection
            this.conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PWD);
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        
    }

    // Getter method to return the connection
//    public Connection getConnection() {
//        return conn;
//    }
    public Connection getConnection() {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            return DriverManager.getConnection(DB_URL, DB_USER, DB_PWD);
        } catch (Exception e) {
            throw new RuntimeException("JDBC Driver not found", e);
        }
    }

    // Method to execute INSERT, UPDATE, DELETE queries
    public int execQuery(String query, Object[] params) throws SQLException {
        PreparedStatement pStatement = conn.prepareStatement(query);
        if (params != null) {
            // Set parameters in the prepared statement
            for (int i = 0; i < params.length; i++) {
                pStatement.setObject(i + 1, params[i]);
            }
        }
        // Execute the update (INSERT, UPDATE, DELETE)
        return pStatement.executeUpdate();
    }

    // Method to execute SELECT queries
    public ResultSet execSelectQuery(String query, Object[] params) throws SQLException {
        PreparedStatement pStatement = conn.prepareStatement(query);
        if (params != null) {
            // Set parameters in the prepared statement
            for (int i = 0; i < params.length; i++) {
                pStatement.setObject(i + 1, params[i]);
            }
        }
        // Execute the query and return the result set
        return pStatement.executeQuery();
    }

    // Overloaded method to execute SELECT queries without parameters
    public ResultSet execSelectQuery(String query) throws SQLException {
        return this.execSelectQuery(query, null);
    }
}
