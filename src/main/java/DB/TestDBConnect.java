/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DB;
import java.sql.Connection;
import java.sql.SQLException;

public class TestDBConnect {
    public static void main(String[] args) throws SQLException {
        DBContext db = new DBContext();
        Connection conn = db.getConnection();

        if (conn != null) {
            System.out.println("Test Passed: Connection successfully.");
        } else {
            System.out.println("Test Failed: Connection is null.");
        }
    }
}

