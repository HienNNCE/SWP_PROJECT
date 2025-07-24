package DAO;

import DB.DBContext;
import Model.Address;
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

    public Users getUserByEmail(String email) {
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

    public Users getUserByUsername(String username) {
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

    public Users getUserByPhone(String phone) {
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
        String query = "INSERT INTO [User] (user_name, email, password, phone, address, role_id, user_status, full_name, gender, dob, about_me) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = this.getConnection().prepareStatement(query)) {

            ps.setString(1, user.getUserName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getPhone());
            ps.setString(5, user.getAddress());
            ps.setInt(6, user.getRoleId());
            ps.setString(7, user.getUserStatus()); // "Active" hoặc từ thuộc tính

            ps.setString(8, user.getFullName());
            ps.setBoolean(9, user.isGender()); // true = male, false = female/other
            ps.setDate(10, java.sql.Date.valueOf(user.getDob())); // LocalDate → java.sql.Date
            ps.setString(11, user.getAboutMe());

            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateUser(Users user) {
        String query = "UPDATE [User] SET "
                + "user_name = ?, email = ?, password = ?, phone = ?, address = ?, role_id = ?, "
                + "user_status = ?, full_name = ?, gender = ?, dob = ?, about_me = ? "
                + "WHERE user_id = ?";

        try (PreparedStatement ps = this.getConnection().prepareStatement(query)) {
            ps.setString(1, user.getUserName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getPhone());
            ps.setString(5, user.getAddress());
            ps.setInt(6, user.getRoleId());
            ps.setString(7, user.getUserStatus());
            ps.setString(8, user.getFullName());
            ps.setBoolean(9, user.isGender());
            ps.setDate(10, java.sql.Date.valueOf(user.getDob()));
            ps.setString(11, user.getAboutMe());
            ps.setInt(12, user.getUserId());

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
        user.setFullName(rs.getString("full_name"));
        user.setGender(rs.getBoolean("gender"));
        user.setDob(rs.getDate("dob").toLocalDate());
        user.setAboutMe(rs.getString("about_me"));
        // user.setRoleName(rs.getString("role_name"));
        return user;
    }

    public List<Users> searchUsersWithPaging(String keyword, int offset, int limit) {
        List<Users> list = new ArrayList<>();
        String sql = "SELECT u.*, r.role_name FROM [User] u JOIN Role r ON u.role_id = r.role_id "
                + "WHERE (? IS NULL OR u.user_name LIKE ? OR u.email LIKE ? OR u.phone LIKE ?) "
                + "ORDER BY u.user_id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        Connection conn = this.getConnection(); 
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
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

        Connection conn = this.getConnection();
        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
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
    
    public int countAllUsers(){
        String sql = "SELECT COUNT(*) FROM [User] ";
        Connection conn = this.getConnection();
        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
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

    public void updateUserPassword(int userId, String newPassword) {
        String query = "UPDATE [User] SET password = ? WHERE user_id = ?";
        try (PreparedStatement ps = this.getConnection().prepareStatement(query)) {
            ps.setString(1, newPassword); // Consider hashing the password in a real application
            ps.setInt(2, userId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

// Create Address
    public void addAddress(Address address) {
        String query = "INSERT INTO Address (user_id, address_name, address_details, phone, is_default) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = getConnection().prepareStatement(query)) {
            ps.setInt(1, address.getUserId());
            ps.setString(2, address.getAddressName());
            ps.setString(3, address.getAddressDetails());
            ps.setString(4, address.getPhone());
            ps.setBoolean(5, address.isDefault());
            ps.executeUpdate();

            // If this is the default address, unset others
            if (address.isDefault()) {
                unsetOtherDefaultAddresses(address.getUserId(), address.getAddressId());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Read Addresses by User ID
    public List<Address> getAddressesByUserId(int userId) {
        List<Address> addresses = new ArrayList<>();
        String query = "SELECT * FROM Address WHERE user_id = ?";
        try (PreparedStatement ps = getConnection().prepareStatement(query)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Address address = new Model.Address();
                    address.setAddressId(rs.getInt("address_id"));
                    address.setUserId(rs.getInt("user_id"));
                    address.setAddressName(rs.getString("address_name"));
                    address.setAddressDetails(rs.getString("address_details"));
                    address.setPhone(rs.getString("phone"));
                    address.setDefault(rs.getBoolean("is_default"));
                    addresses.add(address);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return addresses;
    }

    // Update Address
    public void updateAddress(Address address) {
        String query = "UPDATE Address SET address_name = ?, address_details = ?, phone = ?, is_default = ? WHERE address_id = ?";
        try (PreparedStatement ps = getConnection().prepareStatement(query)) {
            ps.setString(1, address.getAddressName());
            ps.setString(2, address.getAddressDetails());
            ps.setString(3, address.getPhone());
            ps.setBoolean(4, address.isDefault());
            ps.setInt(5, address.getAddressId());
            ps.executeUpdate();

            // If this is the default address, unset others
            if (address.isDefault()) {
                unsetOtherDefaultAddresses(address.getUserId(), address.getAddressId());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Delete Address
    public void deleteAddress(int addressId) {
        String query = "DELETE FROM Address WHERE address_id = ?";
        try (PreparedStatement ps = getConnection().prepareStatement(query)) {
            ps.setInt(1, addressId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Helper: Unset other default addresses for a user
    private void unsetOtherDefaultAddresses(int userId, int currentAddressId) {
        String query = "UPDATE Address SET is_default = 0 WHERE user_id = ? AND address_id != ?";
        try (PreparedStatement ps = getConnection().prepareStatement(query)) {
            ps.setInt(1, userId);
            ps.setInt(2, currentAddressId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
