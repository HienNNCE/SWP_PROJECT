package DAO;

import Model.CarAppointment;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import DB.DBContext;

public class CarAppointmentDAO extends DBContext {
    // public static void main(String[] args) throws SQLException {
    // CarAppointmentDAO cDAO = new CarAppointmentDAO();
    // List<CarAppointment> list = cDAO.getByUserId(102);
    // for ( CarAppointment car : list){
    // System.out.println(car.getCarName());
    // }
    // }

    public void add(CarAppointment ca) throws SQLException {
        int nextId = getNextServiceScheduleId(); // ID cho CarAppointment

        String sql1 = "INSERT INTO CarAppointment (car_appointment_id, user_id, car_id, ca_date, ca_note, ca_status) VALUES (?, ?, ?, ?, ?, ?)";
        String sql2 = "INSERT INTO CaBookingType (car_appointment_id, ca_type_name) VALUES (?, ?)"; // ca_type_id tự
                                                                                                    // tăng

        Connection conn = this.getConnection();
        try {
            conn.setAutoCommit(false); // Bắt đầu transaction

            // Insert CarAppointment
            try (PreparedStatement ps1 = conn.prepareStatement(sql1)) {
                ps1.setInt(1, nextId);
                ps1.setObject(2, ca.getUserId(), Types.INTEGER);
                ps1.setObject(3, ca.getCarId(), Types.INTEGER);
                ps1.setTimestamp(4, Timestamp.valueOf(ca.getCaDate()));
                ps1.setString(5, ca.getCaNote());
                ps1.setString(6, ca.getCaStatus());
                ps1.executeUpdate();
            }

            // Insert CaBookingType
            try (PreparedStatement ps2 = conn.prepareStatement(sql2)) {
                ps2.setInt(1, nextId); // Gán theo car_appointment_id vừa tạo
                ps2.setString(2, ca.getServicerType()); // Giả sử có getCaTypeName()
                ps2.executeUpdate();
            }

            conn.commit(); // Thành công cả 2 thì mới lưu
        } catch (SQLException e) {
            conn.rollback(); // Lỗi thì rollback cả 2
            throw e;
        } finally {
            conn.setAutoCommit(true);
            conn.close();
        }
    }

    public int getNextServiceScheduleId() throws SQLException {
        String sql = "SELECT ISNULL(MAX([car_appointment_id]), 0) + 1 FROM CarAppointment";
        Connection conn = this.getConnection();
        try (PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 1; // fallback nếu DB trống
    }

    public List<CarAppointment> getAll() throws SQLException {
        List<CarAppointment> list = new ArrayList<>();
        String sql = "SELECT ca.*, c.car_name, c.model AS car_model, cb.ca_type_name " +
                "FROM CarAppointment ca " +
                "JOIN Car c ON ca.car_id = c.car_id " +
                "LEFT JOIN CaBookingType cb ON ca.car_appointment_id = cb.car_appointment_id";

        Connection conn = this.getConnection();
        try (PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                CarAppointment ca = new CarAppointment(
                        rs.getInt("car_appointment_id"),
                        (Integer) rs.getObject("user_id"),
                        (Integer) rs.getObject("car_id"),
                        rs.getTimestamp("ca_date").toLocalDateTime(),
                        rs.getString("ca_note"),
                        rs.getString("ca_status"));
                ca.setCarName(rs.getString("car_name"));
                ca.setCarModel(rs.getString("car_model"));
                ca.setServicerType(rs.getString("ca_type_name"));
                list.add(ca);
            }
        }
        return list;
    }

    public List<CarAppointment> getByUserId(int userId) throws SQLException {
        List<CarAppointment> list = new ArrayList<>();
        String sql = "SELECT ca.*, c.car_name, c.model AS car_model " +
                "FROM CarAppointment ca " +
                "JOIN Car c ON ca.car_id = c.car_id " +
                "WHERE ca.user_id = ?";

        Connection conn = this.getConnection();
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                CarAppointment ca = new CarAppointment(
                        rs.getInt("car_appointment_id"),
                        (Integer) rs.getObject("user_id"),
                        (Integer) rs.getObject("car_id"),
                        rs.getTimestamp("ca_date").toLocalDateTime(),
                        rs.getString("ca_note"),
                        rs.getString("ca_status"));
                ca.setCarName(rs.getString("car_name"));
                ca.setCarModel(rs.getString("car_model"));
                list.add(ca);
            }
        }
        return list;
    }

    public CarAppointment getById(int id) throws SQLException {
        String sql = "SELECT * FROM CarAppointment WHERE car_appointment_id = ?";
        Connection conn = this.getConnection();
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new CarAppointment(
                        rs.getInt("car_appointment_id"),
                        (Integer) rs.getObject("user_id"),
                        (Integer) rs.getObject("car_id"),
                        rs.getTimestamp("ca_date").toLocalDateTime(),
                        rs.getString("ca_note"),
                        rs.getString("ca_status"));
            }
        }
        return null;
    }

    public void update(String status, int caId) throws SQLException {
        String sql = "UPDATE CarAppointment SET ca_status=? WHERE car_appointment_id=?";
        Connection conn = this.getConnection();
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, caId);
            ps.executeUpdate();
        }
    }

    public void delete(int id) throws SQLException {
        String sql = "DELETE FROM CarAppointment WHERE car_appointment_id=?";
        Connection conn = this.getConnection();
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }
}
