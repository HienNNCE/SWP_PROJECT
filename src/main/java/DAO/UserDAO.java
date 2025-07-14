package DAO;

import DB.DBContext;
import Model.Part;
import Model.Users;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDAO extends DBContext {
        private static List<Users> cachedUsers = null;  // Cache for parts list


    

    
    public List<Users> getAllUsers() {
        if(cachedUsers!=null){
            return cachedUsers;
        }
        List<Users> list = new ArrayList<>();
        String query = "SELECT u.*, r.role_name FROM [User] u JOIN Role r ON u.role_id = r.role_id";

        try (
                PreparedStatement ps = this.getConnection().prepareStatement(query); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Users user = mapUser(rs);
                list.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();  // hoặc ghi log
        }


        return list;
    }

    public Users getUserById(int userId) {
        String query = "SELECT u.*, r.role_name FROM [User] u JOIN Role r ON u.role_id = r.role_id WHERE u.user_id = ?";

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
    
    public  Users getUserByEmail(String email) {
        String query = "SELECT u.*, r.role_name FROM [User] u JOIN Role r ON u.role_id = r.role_id WHERE u.email = ?";

        try (
                PreparedStatement ps = this.getConnection().prepareStatement(query)) {

            ps.setString(1, email);
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
    
    public  Users getUserByUsername(String username) {
        String query = "SELECT u.*, r.role_name FROM [User] u JOIN Role r ON u.role_id = r.role_id WHERE u.user_name = ?";

        try (
                PreparedStatement ps = this.getConnection().prepareStatement(query)) {

            ps.setString(1, username);
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
    
    public  Users getUserByPhone(String phone) {
        String query = "SELECT u.*, r.role_name FROM [User] u JOIN Role r ON u.role_id = r.role_id WHERE u.phone = ?";

        try (
                PreparedStatement ps = this.getConnection().prepareStatement(query)) {

            ps.setString(1, phone);
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


    public void addUser(Users user) {
        String query = "INSERT INTO [User] (user_name, email, password, phone, address, role_id, user_status) VALUES (?, ?, ?, ?, ?, ?, ?)";

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
        String query = "UPDATE [User] SET user_name = ?, email = ?, phone = ?, address = ?, role_id = ? WHERE user_id = ?";

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
        String query = "UPDATE [User] SET user_status = CASE WHEN user_status = 'Active' THEN 'Banned' ELSE 'Active' END WHERE user_id = ?";
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
        String query = "SELECT u.*, r.role_name FROM [User] u JOIN Role r ON u.role_id = r.role_id WHERE u.user_name LIKE ? OR u.email LIKE ?";

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

    public int getTotalUserCount() {
        String query = "SELECT COUNT(*) FROM [User]";
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

    public int getActiveUserCount() {
        String query = "SELECT COUNT(*) FROM [User] WHERE user_status = 'Active'";
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

    // --- Helper method ---
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
        // user.setRoleName(rs.getString("role_name"));
        return user;
    }

    public List<Users> searchUsersWithPaging(String keyword, int offset, int limit) {
        List<Users> list = new ArrayList<>();
        String sql = "SELECT u.*, r.role_name FROM [User] u JOIN Role r ON u.role_id = r.role_id "
                + "WHERE (? IS NULL OR u.user_name LIKE ? OR u.email LIKE ? OR u.phone LIKE ?) "
                + "ORDER BY u.user_id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            boolean hasKeyword = keyword != null && !keyword.trim().isEmpty();
            String search = "%" + (hasKeyword ? keyword.trim() : "") + "%";

            ps.setString(1, hasKeyword ? keyword : null);
            ps.setString(2, search);
            ps.setString(3, search);
            ps.setString(4, search);
            ps.setInt(5, offset);
            ps.setInt(6, limit);

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

    public int countUsers(String keyword) {
        String sql = "SELECT COUNT(*) FROM [User] "
                + "WHERE (? IS NULL OR user_name LIKE ? OR email LIKE ? OR phone LIKE ?)";

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            boolean hasKeyword = keyword != null && !keyword.trim().isEmpty();
            String search = "%" + (hasKeyword ? keyword.trim() : "") + "%";

            ps.setString(1, hasKeyword ? keyword : null);
            ps.setString(2, search);
            ps.setString(3, search);
            ps.setString(4, search);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }
}
