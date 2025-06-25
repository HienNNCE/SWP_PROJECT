package DAO;

import DB.DBContext;
import Model.Service;
import java.math.BigDecimal;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ServiceDAO extends DBContext {
    // Cache for the list of services
    private static List<Service> cachedServices = null;

    // Get all services
    public List<Service> getAllService() {
        if (cachedServices != null) {
            return cachedServices;  // Return from cache if available
        }

        List<Service> services = new ArrayList<>();
        String sql = "SELECT * FROM dbo.Service";
        try (Connection conn = this.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                services.add(mapRowToService(rs));
            }
            cachedServices = services;  // Cache the results after the first load
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return services;
    }

    // Get service by ID
    public Service getServiceById(int serviceId) {
        String sql = "SELECT * FROM dbo.Service WHERE service_id = ?";
        try (Connection conn = this.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
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
        try (Connection conn = this.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, service.getServiceName());
            stmt.setString(2, service.getServiceDescription());
            stmt.setBigDecimal(3, service.getServicePrice());
            stmt.setTimestamp(4, Timestamp.valueOf(service.getEstimateTime()));
            stmt.setString(5, service.getServiceImg());
            stmt.executeUpdate();
            
            // Invalidate the cache after creating a new service
            cachedServices = null;
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Update service
    public void updateService(Service service) {
        String sql = "UPDATE dbo.Service SET service_name = ?, service_description = ?, service_price = ?, estimate_time = ?, service_img = ? WHERE service_id = ?";
        try (Connection conn = this.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, service.getServiceName());
            stmt.setString(2, service.getServiceDescription());
            stmt.setBigDecimal(3, service.getServicePrice());
            stmt.setTimestamp(4, Timestamp.valueOf(service.getEstimateTime()));
            stmt.setString(5, service.getServiceImg());
            stmt.setInt(6, service.getServiceId());
            stmt.executeUpdate();
            
            // Invalidate the cache after updating the service
            cachedServices = null;
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
            
            // Invalidate the cache after deleting the service
            cachedServices = null;
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Search services by name (using LIKE)
    public List<Service> searchServiceByName(String keyword) {
        List<Service> services = new ArrayList<>();
        String sql = "SELECT * FROM dbo.Service WHERE service_name LIKE ?";
        try (Connection conn = this.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, "%" + keyword + "%");
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    services.add(mapRowToService(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return services;
    }

    // Filter services based on certain criteria
    public List<Service> filterServices(String name, BigDecimal priceFrom, BigDecimal priceTo, String sort) {
        List<Service> services = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM dbo.Service WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (name != null && !name.isEmpty()) {
            sql.append(" AND service_name LIKE ?");
            params.add("%" + name + "%");
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

        try (Connection conn = this.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql.toString())) {
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

    // Main method for testing
    public static void main(String[] args) {
        ServiceDAO serviceDAO = new ServiceDAO();

        // Test fetching all services
        List<Service> services = serviceDAO.getAllService();

        if (services.isEmpty()) {
            System.out.println("No services found.");
        } else {
            for (Service service : services) {
                System.out.println("Service ID: " + service.getServiceId());
                System.out.println("Service Name: " + service.getServiceName());
                System.out.println("Service Description: " + service.getServiceDescription());
                System.out.println("Service Price: $" + service.getServicePrice());
                System.out.println("Estimate Time: " + service.getEstimateTime());
                System.out.println("------------");
            }
        }
    }
}
