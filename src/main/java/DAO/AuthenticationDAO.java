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
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.Random;

/**
 *
 * @author
 */
public class AuthenticationDAO extends DBContext {

    /**
     * Retrieves a list of all users from the database.
     *
     * @return A List of User objects, or an empty list if no users are found or
     * an error occurs.
     */
    public List<Users> getAllUser() {
        List<Users> list = new ArrayList<>();
        String sql = "SELECT * FROM [User]";
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

    /**
     * Retrieves a user from the database by their username/email and password.
     * This method is typically used for user authentication (login).
     *
     * @param username The username or email of the user.
     * @param password The password of the user.
     * @return A User object if a matching user is found, otherwise null.
     */
    public Users getUserById(String username, String password) {
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
                String phone = rs.getString(5);
                String address = rs.getString(6);
                int roleId = 0;
                if (rs.getString(7) != null) {
                    roleId = Integer.parseInt(rs.getString(7));
                }
                String userStatus = rs.getString(8);
                String fullName = rs.getString(9);
                boolean gender = rs.getBoolean(10);
                LocalDate dob = rs.getDate(11).toLocalDate();
                String aboutMe = rs.getString(12);
                Users u = new Users(userId, fullName, username, email, password, phone, gender, dob, aboutMe, address, roleId, userStatus);
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
     *
     * @param username The username for the new user.
     * @param email The email for the new user.
     * @param password The password for the new user.
     */
    public void registerUser(String username, String email, String password) {
        String sql = "INSERT INTO [User] (user_name, email, password, role_id, user_status, phone, gender, dob) VALUES (?, ?, ?, ?, ?, 0, 1, '2000-01-01')";
        try (PreparedStatement ps = this.getConnection().prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, email);
            ps.setString(3, password);
            ps.setInt(4, 2);
            ps.setString(5, "Active");

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * Checks if a user with the given email already exists in the database.
     *
     * @param email The email to check.
     * @return true if a user with the email exists, false otherwise.
     */
    public boolean checkEmailUser(String email) {
        String sql = "SELECT * FROM [User] WHERE email = ?";
        try (PreparedStatement ps = this.getConnection().prepareStatement(sql)) {
            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int userId = Integer.parseInt(rs.getString(1));
                String username = rs.getString(2);
                String phone = rs.getString(5);
                String address = rs.getString(6);
                int roleId = 0;
                if (rs.getString(7) != null) {
                    roleId = Integer.parseInt(rs.getString(7));
                }
                String userStatus = rs.getString(8);
                String fullName = rs.getString(9);
                boolean gender = rs.getBoolean(10);
                LocalDate dob = rs.getDate(11).toLocalDate();
                String aboutMe = rs.getString(12);
                Users u = new Users(userId, fullName, username, email, null, phone, gender, dob, aboutMe, address, roleId, userStatus);
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
     *
     * @return The total number of users as an integer.
     */
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

    /**
     * Sets or updates the password for a user based on their email. This is
     * typically used for "forgot password" functionalities.
     *
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
}
