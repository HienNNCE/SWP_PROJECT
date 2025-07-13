package DB;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DBContext {

    private static final String DB_URL = "jdbc:sqlserver://localhost:1433;databaseName=DriveXO;encrypt=true;trustServerCertificate=true";
    private static final String DB_USER = "sa";
    private static final String DB_PWD = "Admin@123";

    static {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("SQL Server Driver not found", e);
        }
    }

    public Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PWD);
    }

    // INSERT, UPDATE, DELETE
    public int execQuery(String query, Object[] params) throws SQLException {
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            if (params != null) {
                for (int i = 0; i < params.length; i++) {
                    stmt.setObject(i + 1, params[i]);
                }
            }
            return stmt.executeUpdate();
        }
    }

    // SELECT có tham số
    public ResultSet execSelectQuery(String query, Object[] params) throws SQLException {
        Connection conn = getConnection();
        PreparedStatement stmt = conn.prepareStatement(query);
        if (params != null) {
            for (int i = 0; i < params.length; i++) {
                stmt.setObject(i + 1, params[i]);
            }
        }
        return stmt.executeQuery(); // ⚠ Gọi xong phải đóng conn ở DAO sau khi dùng xong
    }

    // SELECT không tham số
    public ResultSet execSelectQuery(String query) throws SQLException {
        return execSelectQuery(query, null);
    }
}
