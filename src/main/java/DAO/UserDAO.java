/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DB.DBContext;
import Model.User;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author thien
 */
public class UserDAO extends DBContext {

    public List<User> getAllUser() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM [User]";
        try (PreparedStatement ps = this.getConnection().prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                User u = new User();
                // set fields...
                list.add(u);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public User getUserById(String username, String password) {
        String sql = "SELECT * FROM [User] WHERE (user_name = ? OR email = ?) AND password = ?";
        try (PreparedStatement ps = this.getConnection().prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, username);
            ps.setString(3, password);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int userId = Integer.parseInt(rs.getString(1));
                username = rs.getString(2);
                String email = rs.getString(3);
                long phone = Long.parseLong(rs.getString(5));
                String address = rs.getString(6);
                int roleId = 0;
                if(rs.getString(7)!=null)
                roleId = Integer.parseInt(rs.getString(7));
                String userStatus = rs.getString(8);
                User u = new User(userId, username, email, phone, address, roleId, userStatus);
                // set fields...
                return u;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void RegisterUser(String username, String email, String passsword) {
        String sql = "INSERT INTO [User] (user_id, user_name, email, password, phone) VALUES (?,?,?,?,0)";
        try (PreparedStatement ps = this.getConnection().prepareStatement(sql)) {
            ps.setInt(1, getTotalUserCount());
            ps.setString(2, username);
            ps.setString(3, email);
            ps.setString(4, passsword);

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean CheckEmailUser(String email) {
        String sql = "SELECT * FROM [User] WHERE email = ?";
        try (PreparedStatement ps = this.getConnection().prepareStatement(sql)) {
            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int userId = Integer.parseInt(rs.getString(1));
                String username = rs.getString(2);
                long phone = Long.parseLong(rs.getString(5));
                String address = rs.getString(6);
                int roleId = 0;
                if(rs.getString(7)!=null)
                   roleId = Integer.parseInt(rs.getString(7));
                String userStatus = rs.getString(8);
                User u = new User(userId, username, email, phone, address, roleId, userStatus);
                // set fields...
                if (u != null) {
                    return true;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public int getTotalUserCount() {
        String sql = "SELECT Count(*) FROM [User]";
        try (PreparedStatement ps = this.getConnection().prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int count = Integer.parseInt(rs.getString(1));

                return count;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int getActiveUserCount() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public void setUserPasswordByEmail(String femail, String password) {
        String sql = "UPDATE [User] set password = ? where email = ?";
        try (PreparedStatement ps = this.getConnection().prepareStatement(sql)) {
            ps.setString(1, password);
            ps.setString(2, femail);

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
