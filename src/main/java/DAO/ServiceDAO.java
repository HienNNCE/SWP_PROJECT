package DAO;

import DB.DBContext;
import Model.Service;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ServiceDAO extends DBContext {

    /**
     * Lấy tất cả service
     */
    public List<Service> getAllService() {
        List<Service> list = new ArrayList<>();
        String sql = "SELECT * FROM Service";
        try (PreparedStatement ps = getConnection().prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapRowToService(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Thêm mới service
     */
    public boolean addNewService(Service service) {
        String sql = "INSERT INTO Service(service_name, service_description, service_price, "
                   + "estimate_time, service_img, service_type) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
            ps.setString(1, service.getServiceName());
            ps.setString(2, service.getServiceDescription());
            ps.setBigDecimal(3, service.getServicePrice());
            ps.setTimestamp(4, Timestamp.valueOf(service.getEstimateTime()));
            ps.setString(5, service.getServiceImg());
            ps.setString(6, service.getServiceType());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Lấy service theo ID
     */
    public Service getServiceById(int serviceId) {
        String sql = "SELECT * FROM Service WHERE service_id = ?";
        try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
            ps.setInt(1, serviceId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRowToService(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Cập nhật service
     */
    public boolean updateService(Service service) {
        String sql = "UPDATE Service SET service_name = ?, service_description = ?, "
                   + "service_price = ?, estimate_time = ?, service_img = ?, service_type = ? "
                   + "WHERE service_id = ?";
        try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
            ps.setString(1, service.getServiceName());
            ps.setString(2, service.getServiceDescription());
            ps.setBigDecimal(3, service.getServicePrice());
            ps.setTimestamp(4, Timestamp.valueOf(service.getEstimateTime()));
            ps.setString(5, service.getServiceImg());
            ps.setString(6, service.getServiceType());
            ps.setInt(7, service.getServiceId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Xóa service theo ID
     */
    public boolean deleteService(int serviceId) {
        String sql = "DELETE FROM Service WHERE service_id = ?";
        try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
            ps.setInt(1, serviceId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Tìm service theo tên (LIKE search)
     */
    public List<Service> searchServiceByName(String keyword) {
        List<Service> list = new ArrayList<>();
        String sql = "SELECT * FROM Service WHERE service_name LIKE ?";
        try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRowToService(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Lọc service theo loại service_type
     */
    public List<Service> getServicesByType(String type) {
        List<Service> list = new ArrayList<>();
        String sql = "SELECT * FROM Service WHERE service_type = ?";
        try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
            ps.setString(1, type);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRowToService(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Alias cho getServiceById khi load form edit
     */
    public Service loadServiceForEdit(int serviceId) {
        return getServiceById(serviceId);
    }

    /**
     * Utility: ánh xạ một dòng ResultSet thành đối tượng Service
     */
    private Service mapRowToService(ResultSet rs) throws SQLException {
        Service s = new Service();
        s.setServiceId(rs.getInt("service_id"));
        s.setServiceName(rs.getString("service_name"));
        s.setServiceDescription(rs.getString("service_description"));
        s.setServicePrice(rs.getBigDecimal("service_price"));
        s.setEstimateTime(rs.getTimestamp("estimate_time").toLocalDateTime());
        s.setServiceImg(rs.getString("service_img"));
        s.setServiceType(rs.getString("service_type"));
        return s;
    }
}
