package DB;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DBContext {
    private static final String DB_URL = "jdbc:sqlserver://dbswp.database.windows.net:1433;databaseName=DriveXO;encrypt=true;trustServerCertificate=false;hostNameInCertificate=*.database.windows.net;loginTimeout=30;";
    private static final String DB_USER = "sqladmin@dbswp";
    private static final String DB_PWD = "admin@123";

    public DBContext() {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public Connection getConnection() {
        try {
            return DriverManager.getConnection(DB_URL, DB_USER, DB_PWD);
        } catch (SQLException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }

    public int execQuery(String query, Object[] params) throws SQLException {
        try (Connection conn = getConnection();
             PreparedStatement pStatement = conn.prepareStatement(query)) {
            if (params != null) {
                for (int i = 0; i < params.length; i++) {
                    pStatement.setObject(i + 1, params[i]);
                }
            }
            return pStatement.executeUpdate();
        }
    }

    public ResultSet execSelectQuery(String query, Object[] params) throws SQLException {
        Connection conn = getConnection();
        PreparedStatement pStatement = conn.prepareStatement(query);
        if (params != null) {
            for (int i = 0; i < params.length; i++) {
                pStatement.setObject(i + 1, params[i]);
            }
        }
        return pStatement.executeQuery();
    }

    public ResultSet execSelectQuery(String query) throws SQLException {
        return this.execSelectQuery(query, null);
    }
}
