/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DB.DBContext;
import Model.Users;
import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
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
     * Retrieves a user from the database by their username/email and password.
     * This method is typically used for user authentication (login).
     * @param username The username or email of the user.
     * @param password The password of the user.
     * @return A User object if a matching user is found, otherwise null.
     */
    public Users getUserById(String username, String password) {
        String sql = "SELECT * FROM Users WHERE (user_name = ? OR email = ?) AND password = ?";
        try (PreparedStatement ps = this.getConnection().prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, username);
            ps.setString(3, password);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int userId = Integer.parseInt(rs.getString(1));
                username = rs.getString(2);
                String email = rs.getString(3);
                String phone = rs.getString(5);
                String address = rs.getString(6);
                int roleId = 0;
                if(rs.getString(7)!=null)
                roleId = Integer.parseInt(rs.getString(7));
                String userStatus = rs.getString(8);
                Users u = new Users(userId, username, email, phone, address, roleId, userStatus);
                // set fields...
                return u;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Registers a new user in the database.
     * @param username The username for the new user.
     * @param email The email for the new user.
     * @param password The password for the new user.
     */
    public void registerUser(String username, String email, String passsword) {
        String sql = "INSERT INTO Users (user_id, user_name, email, password, phone) VALUES (?,?,?,?,0)";
        try (PreparedStatement ps = this.getConnection().prepareStatement(sql)) {
            ps.setInt(1, getTotalUserCount()+1);
            ps.setString(2, username);
            ps.setString(3, email);
            ps.setString(4, passsword);

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * Checks if a user with the given email already exists in the database.
     * @param email The email to check.
     * @return true if a user with the email exists, false otherwise.
     */
    public boolean checkEmailUser(String email) {
        String sql = "SELECT * FROM Users WHERE email = ?";
        try (PreparedStatement ps = this.getConnection().prepareStatement(sql)) {
            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int userId = Integer.parseInt(rs.getString(1));
                String username = rs.getString(2);
                String phone = rs.getString(5);
                String address = rs.getString(6);
                int roleId = 0;
                if(rs.getString(7)!=null)
                   roleId = Integer.parseInt(rs.getString(7));
                String userStatus = rs.getString(8);
                Users u = new Users(userId, username, email, phone, address, roleId, userStatus);
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

    /**
     * Sets or updates the password for a user based on their email.
     * This is typically used for "forgot password" functionalities.
     * @param femail The email of the user whose password needs to be updated.
     * @param password The new password to set.
     */
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
    
    public static void sendEmail(String to, String subject, String content) throws MessagingException {
        final String from = "driverxo123@gmail.com"; // your email
        final String password = "fafe tdwc mxth zmhl"; // app password (not regular email password)

        // SMTP server configuration
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        // Authenticator
        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, password);
            }
        });

        // Compose message
        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(from));
        message.setRecipients(
            Message.RecipientType.TO, InternetAddress.parse(to));
        message.setSubject(subject);
        message.setText(content);

        // Send message
        Transport.send(message);
    }
    
    public static String generateFiveRandomNumbersString() {
        Random random = new Random();
        StringBuilder sb = new StringBuilder();

        for (int i = 0; i < 5; i++) {
            int number = random.nextInt(10); // generates number from 0 to 9
            sb.append(number);

            if (i < 4) {
                sb.append("");
            }
        }

        return sb.toString();
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
