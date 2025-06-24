//package DB;
//
//import java.sql.Connection;
//import java.sql.DriverManager;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//import java.sql.SQLException;
//import java.util.logging.Level;
//import java.util.logging.Logger;
//
//public class DBContext {
//    
//    // Declare the connection variable
//    private Connection conn;
//
//    // Database connection details (Root) do not edit
//    // Just comment when connect db local
//    private static final String DB_URL = "jdbc:sqlserver://localhost:1433;databaseName=DriveXO;encrypt=true;trustServerCertificate=true";
//    private static final String DB_USER = "sa";
//    private static final String DB_PWD = "Admin@123";
//
 ////    // Use this to connect database, not change string above
////     // after done, comment again
////    private static final String DB_URL = "jdbc:sqlserver://LAPTOP-FT0Q1NI1\\SQLEXPRESS;databaseName=DriveXO;encrypt=true;";
////    private static final String DB_USER = "sa";
////    private static final String DB_PWD = "123456";
//    
//    // Constructor to initialize the connection
//    public DBContext() {
//        try {
//            // Load the SQLServer driver
//            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
//            // Establish the connection
//            this.conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PWD);
//        } catch (ClassNotFoundException | SQLException ex) {
//            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
//        }
//    }
//
//    // Getter method to return the connection
//    public Connection getConnection() {
//        return conn;
//    }
//
//    // Method to execute INSERT, UPDATE, DELETE queries
//    public int execQuery(String query, Object[] params) throws SQLException {
//        PreparedStatement pStatement = conn.prepareStatement(query);
//        if (params != null) {
//            // Set parameters in the prepared statement
//            for (int i = 0; i < params.length; i++) {
//                pStatement.setObject(i + 1, params[i]);
//            }
//        }
//        // Execute the update (INSERT, UPDATE, DELETE)
//        return pStatement.executeUpdate();
//    }
//
//    // Method to execute SELECT queries
//    public ResultSet execSelectQuery(String query, Object[] params) throws SQLException {
//        PreparedStatement pStatement = conn.prepareStatement(query);
//        if (params != null) {
//            // Set parameters in the prepared statement
//            for (int i = 0; i < params.length; i++) {
//                pStatement.setObject(i + 1, params[i]);
//            }
//        }
//        // Execute the query and return the result set
//        return pStatement.executeQuery();
//    }
//
//    // Overloaded method to execute SELECT queries without parameters
//    public ResultSet execSelectQuery(String query) throws SQLException {
//        return this.execSelectQuery(query, null);
//    }
//}
package DB;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBContext {

    // Database config (modify if needed)
    private static final String DB_URL = "jdbc:sqlserver://DESKTOP-AM5VNJP\\SQLEXPRESS;databaseName=DriveXO;encrypt=true;trustServerCertificate=true;";
    private static final String DB_USER = "sa";
    private static final String DB_PWD = "1";

    // Get a new connection each time
    public Connection getConnection() throws SQLException {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("JDBC Driver not found", e);
        }
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PWD);
    }
}
