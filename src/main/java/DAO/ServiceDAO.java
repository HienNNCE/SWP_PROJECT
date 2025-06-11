package DAO;

import DB.DBContext;
import Model.Service;
import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ServiceDAO extends DBContext {

    // Method to get all services from the database
    public List<Service> getAllService() {
        List<Service> list = new ArrayList<>();
        String sql = "SELECT * FROM Service";

        try (PreparedStatement ps = this.getConnection().prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Service rsObj = new Service();
                // Set fields for each Service object
                rsObj.setServiceId(rs.getInt("service_id"));
                rsObj.setServiceName(rs.getString("service_name"));
                rsObj.setServiceDescription(rs.getString("service_description"));
                rsObj.setServicePrice(rs.getBigDecimal("service_price"));
                rsObj.setEstimateTime(rs.getTimestamp("estimate_time").toLocalDateTime());
                rsObj.setServiceImg(rs.getString("service_img"));
                
                list.add(rsObj);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    // Method to add a new service to the database
    public boolean addNewService(Service service) {
        String sql = "INSERT INTO Service(service_name, service_description, service_price, estimate_time, service_img) VALUES (?,?,?,?,?)";

        try (PreparedStatement ps = this.getConnection().prepareStatement(sql)) {
            ps.setString(1, service.getServiceName());
            ps.setString(2, service.getServiceDescription());
            ps.setBigDecimal(3, service.getServicePrice());
            ps.setTimestamp(4, Timestamp.valueOf(service.getEstimateTime()));
            ps.setString(5, service.getServiceImg());

            // Execute update and return true if successful
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    // Method to get a service by its ID
    public Service getServiceById(int serviceId) {
        String sql = "SELECT * FROM Service WHERE service_id = ?";

        try (PreparedStatement ps = this.getConnection().prepareStatement(sql)) {
            ps.setInt(1, serviceId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
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
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    // Method to update a service in the database
    public boolean updateService(Service service) {
        String sql = "UPDATE Service SET service_name=?, service_description=?, service_price=?, estimate_time=?, service_img=? WHERE service_id =?";

        try (PreparedStatement ps = this.getConnection().prepareStatement(sql)) {
            ps.setString(1, service.getServiceName());
            ps.setString(2, service.getServiceDescription());
            ps.setBigDecimal(3, service.getServicePrice());
            ps.setTimestamp(4, Timestamp.valueOf(service.getEstimateTime()));
            ps.setString(5, service.getServiceImg());
            ps.setInt(6, service.getServiceId());

            // Execute update and return true if successful
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

   
}
