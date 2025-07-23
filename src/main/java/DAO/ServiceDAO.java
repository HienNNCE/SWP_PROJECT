package DAO;

import DB.DBContext;
import Model.Service;
import java.math.BigDecimal;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ServiceDAO extends DBContext {
    // Get all services
    public List<Service> getAllService() {
        List<Service> services = new ArrayList<>();
        String sql = "SELECT * FROM Service";
        Connection conn = this.getConnection();
        try (
                PreparedStatement stmt = conn.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                services.add(mapRowToService(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return services;
    }

    // Get service by ID
    public Service getServiceById(int serviceId) {
        String sql = "SELECT * FROM dbo.Service WHERE service_id = ?";

        Connection conn = this.getConnection();
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, serviceId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapRowToService(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Create new service
    public void createService(Service service) {
        String sql = "INSERT INTO dbo.Service(service_name, service_description, service_price, estimate_time, service_img) VALUES (?, ?, ?, ?, ?)";

        Connection conn = this.getConnection();
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, service.getServiceName());
            stmt.setString(2, service.getServiceDescription());
            stmt.setBigDecimal(3, service.getServicePrice());
            stmt.setTimestamp(4, Timestamp.valueOf(service.getEstimateTime()));
            stmt.setString(5, service.getServiceImg());
            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Update service
    public void updateService(Service service) {
        String sql = "UPDATE dbo.Service SET service_name = ?, service_description = ?, service_price = ?, estimate_time = ?, service_img = ? WHERE service_id = ?";
        Connection conn = this.getConnection();
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, service.getServiceName());
            stmt.setString(2, service.getServiceDescription());
            stmt.setBigDecimal(3, service.getServicePrice());
            stmt.setTimestamp(4, Timestamp.valueOf(service.getEstimateTime()));
            stmt.setString(5, service.getServiceImg());
            stmt.setInt(6, service.getServiceId());
            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Delete service
    public void deleteService(int serviceId) {
        String sql = "DELETE FROM dbo.Service WHERE service_id = ?";

        try (Connection conn = this.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, serviceId);
            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Search services by name (using LIKE)
    public List<Service> searchServiceByName(String keyword) {
        List<Service> services = new ArrayList<>();
        String sql = "SELECT * FROM Service WHERE LOWER(service_name) LIKE LOWER(?)";
        Connection conn = this.getConnection();
        try (
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, "%" + keyword + "%");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                services.add(mapRowToService(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return services;
    }

    // Filter services based on certain criteria
    public List<Service> filterServices(String serviceType, BigDecimal priceFrom, BigDecimal priceTo, String sort) {
        List<Service> services = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Service WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (serviceType != null && !serviceType.isEmpty()) {
            sql.append(" AND service_description LIKE ?"); // or use a dedicated column if available
            params.add("%" + serviceType + "%");
        }
        if (priceFrom != null) {
            sql.append(" AND service_price >= ?");
            params.add(priceFrom);
        }
        if (priceTo != null) {
            sql.append(" AND service_price <= ?");
            params.add(priceTo);
        }
        if ("asc".equalsIgnoreCase(sort)) {
            sql.append(" ORDER BY service_price ASC");
        } else if ("desc".equalsIgnoreCase(sort)) {
            sql.append(" ORDER BY service_price DESC");
        }
        Connection conn = this.getConnection();
        try (PreparedStatement stmt = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                services.add(mapRowToService(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return services;
    }

    // Get all distinct service types (for filter display)
    public List<String> getAllServiceTypes() {
        List<String> types = new ArrayList<>();
        String sql = "SELECT DISTINCT service_description FROM Service WHERE service_description IS NOT NULL AND service_description <> ''";
        Connection conn = this.getConnection();
        try (
                PreparedStatement stmt = conn.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                types.add(rs.getString("service_description"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return types;
    }

    // Utility: Mapping result set row to Service object
    private Service mapRowToService(ResultSet rs) throws SQLException {
        Service service = new Service();
        service.setServiceId(rs.getInt("service_id"));
        service.setServiceName(rs.getString("service_name"));
        service.setServiceDescription(rs.getString("service_description"));
        service.setServicePrice(rs.getBigDecimal("service_price"));
        service.setEstimateTime(rs.getTimestamp("estimate_time").toLocalDateTime());
        service.setServiceImg(rs.getString("service_img"));
        return service;
    }
}
