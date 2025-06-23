/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DB.DBContext;
import Model.Users;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.Random;

/**
 *
 * @author 
 */
public class UserDAO extends DBContext {

    /**
     * Retrieves a list of all users from the database.
     * @return A List of User objects, or an empty list if no users are found or an error occurs.
     */
    public List<Users> getAllUsers() {
        List<Users> list = new ArrayList<>();
        String sql = "SELECT * FROM Users";
        try (PreparedStatement ps = this.getConnection().prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Users u = new Users();
                // set fields...
                list.add(u);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Users getUserById(int userId) {
        String query = "SELECT u.*, r.role_name FROM Users u JOIN Role r ON u.role_id = r.role_id WHERE u.user_id = ?";

        try (
                PreparedStatement ps = this.getConnection().prepareStatement(query)) {

            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapUser(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
    
    /**
     * Retrieves the total count of users in the database.
     * @return The total number of users as an integer.
     */
    public int getTotalUserCount() {
        String sql = "SELECT Count(*) FROM Users";
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

    public void addUser(Users user) {
        String query = "INSERT INTO Users (user_name, email, password, phone, address, role_id, user_status) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (
                PreparedStatement ps = this.getConnection().prepareStatement(query)) {

            ps.setString(1, user.getUserName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getPhone());
            ps.setString(5, user.getAddress());
            ps.setInt(6, user.getRoleId());
            ps.setString(7, "Active");

            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateUser(Users user) {
        String query = "UPDATE Users SET user_name = ?, email = ?, phone = ?, address = ?, role_id = ? WHERE user_id = ?";

        try (
                PreparedStatement ps = this.getConnection().prepareStatement(query)) {

            ps.setString(1, user.getUserName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPhone());
            ps.setString(4, user.getAddress());
            ps.setInt(5, user.getRoleId());
            ps.setInt(6, user.getUserId());

            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void toggleUserStatus(int userId) {
        String query = "UPDATE Users SET user_status = CASE WHEN user_status = 'Active' THEN 'Banned' ELSE 'Active' END WHERE user_id = ?";
        try (
                PreparedStatement ps = this.getConnection().prepareStatement(query)) {

            ps.setInt(1, userId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Users> searchUsers(String keyword) {
        List<Users> list = new ArrayList<>();
        String query = "SELECT u.*, r.role_name FROM Users u JOIN Role r ON u.role_id = r.role_id WHERE u.user_name LIKE ? OR u.email LIKE ?";

        try (Connection conn = getConnection(); PreparedStatement ps = this.getConnection().prepareStatement(query)) {

            ps.setString(1, "%" + keyword + "%");
            ps.setString(2, "%" + keyword + "%");

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Users user = mapUser(rs);
                    list.add(user);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }


    public int getActiveUserCount() {
        String query = "SELECT COUNT(*) FROM Users WHERE user_status = 'Active'";
        try (
                PreparedStatement ps = this.getConnection().prepareStatement(query); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

//    // --- Helper method ---
    private Users mapUser(ResultSet rs) throws SQLException {
        Users user = new Users();
        user.setUserId(rs.getInt("user_id"));
        user.setUserName(rs.getString("user_name"));
        user.setEmail(rs.getString("email"));
        user.setPassword(rs.getString("password"));
        user.setPhone(rs.getString("phone"));
        user.setAddress(rs.getString("address"));
        user.setRoleId(rs.getInt("role_id"));
        user.setUserStatus(rs.getString("user_status"));
//        user.setRoleName(rs.getString("role_name"));
        return user;
    }
}
