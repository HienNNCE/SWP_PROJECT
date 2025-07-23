package DAO;

import Model.ServiceAppointment;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import DB.DBContext;

public class ServiceAppointmentDAO extends DBContext {
    // public static void main(String[] args) throws SQLException {
    // ServiceAppointmentDAO cDAO = new ServiceAppointmentDAO();
    // List<ServiceAppointment> list = cDAO.getByUserId(102);
    // for ( ServiceAppointment car : list){
    // System.out.println(car.getCarInfo());
    // }
    // }

    public void add(ServiceAppointment sa) throws SQLException {
        int nextId = getNextServiceScheduleId(); // Lấy ID kế tiếp
        String sql = "INSERT INTO ServiceSchedule (service_schedule_id, user_id, service_id, ss_date, ss_note, ss_status, car_info) VALUES (?, ?, ?, ?, ?, ?, ?)";
        Connection conn = this.getConnection();
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, nextId);
            ps.setInt(2, sa.getUserId());
            ps.setInt(3, sa.getServiceId());
            ps.setTimestamp(4, Timestamp.valueOf(sa.getSaDate()));
            ps.setString(5, sa.getSaNote());
            ps.setString(6, sa.getSaStatus());
            ps.setString(7, sa.getCarInfo());
            ps.executeUpdate();
        }
    }

    public int getNextServiceScheduleId() throws SQLException {
        String sql = "SELECT ISNULL(MAX(service_schedule_id), 0) + 1 FROM ServiceSchedule";
        Connection conn = this.getConnection();
        try (PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 1; // fallback nếu DB trống
    }

    public List<ServiceAppointment> getAll() throws SQLException {
        List<ServiceAppointment> list = new ArrayList<>();
        String sql = "SELECT ss.*, s.service_name " +
                "FROM ServiceSchedule ss " +
                "JOIN Service s ON ss.service_id = s.service_id";

        Connection conn = this.getConnection();
        try (PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                ServiceAppointment sa = new ServiceAppointment(
                        rs.getInt("service_schedule_id"),
                        rs.getInt("user_id"),
                        rs.getInt("service_id"),
                        rs.getTimestamp("ss_date").toLocalDateTime(),
                        rs.getString("ss_note"),
                        rs.getString("ss_status"),
                        rs.getString("car_info"));
                // Gán tên dịch vụ nếu model có thuộc tính
                sa.setServiceName(rs.getString("service_name"));
                list.add(sa);
            }
        }
        return list;
    }

    public List<ServiceAppointment> getByUserId(int userId) throws SQLException {
        List<ServiceAppointment> list = new ArrayList<>();
        String sql = "SELECT ss.*, s.service_name " +
                "FROM ServiceSchedule ss " +
                "JOIN Service s ON ss.service_id = s.service_id " +
                "WHERE ss.user_id = ?";

        Connection conn = this.getConnection();
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ServiceAppointment sa = new ServiceAppointment(
                            rs.getInt("service_schedule_id"),
                            rs.getInt("user_id"),
                            rs.getInt("service_id"),
                            rs.getTimestamp("ss_date").toLocalDateTime(),
                            rs.getString("ss_note"),
                            rs.getString("ss_status"),
                            rs.getString("car_info"));
                    sa.setServiceName(rs.getString("service_name"));
                    list.add(sa);
                }
            }
        }
        return list;
    }

    public ServiceAppointment getById(int id) throws SQLException {
        String sql = "SELECT * FROM ServiceSchedule WHERE user_id = ?";
        Connection conn = this.getConnection();
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new ServiceAppointment(
                        rs.getInt("service_appointment_id"),
                        rs.getInt("user_id"),
                        rs.getInt("service_id"),
                        rs.getTimestamp("sa_date").toLocalDateTime(),
                        rs.getString("sa_note"),
                        rs.getString("sa_status"),
                        rs.getString("car_info"));
            }
        }
        return null;
    }

    public void update(String status, int saId) throws SQLException {
        String sql = "UPDATE ServiceSchedule SET ss_status=? WHERE service_schedule_id = ?";
        Connection conn = this.getConnection();
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, saId);
            ps.executeUpdate();
        }
    }

    public void delete(int id) throws SQLException {
        String sql = "DELETE FROM ServiceSchedule WHERE service_schedule_id=?";
        Connection conn = this.getConnection();
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }
}
