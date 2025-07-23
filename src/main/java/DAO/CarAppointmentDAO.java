package DAO;

import Model.CarAppointment;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import DB.DBContext;

public class CarAppointmentDAO extends DBContext {
    public static void main(String[] args) throws SQLException {
    CarAppointmentDAO cDAO = new CarAppointmentDAO();
    cDAO.update("Confirm", 2);
    }

    public void add(CarAppointment ca) throws SQLException {
        int nextId = getNextServiceScheduleId(); // Lấy ID kế tiếp
        String sql = "INSERT INTO CarAppointment ([car_appointment_id], user_id, car_id, ca_date, ca_note, ca_status) VALUES (?, ?, ?, ?, ?, ?)";
        Connection conn = this.getConnection();
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, nextId);
            ps.setObject(2, ca.getUserId(), Types.INTEGER);
            ps.setObject(3, ca.getCarId(), Types.INTEGER);
            ps.setTimestamp(4, Timestamp.valueOf(ca.getCaDate()));
            ps.setString(5, ca.getCaNote());
            ps.setString(6, ca.getCaStatus());
            ps.executeUpdate();
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
        String sql = "SELECT ca.*, c.car_name, c.model AS car_model " +
                "FROM CarAppointment ca " +
                "JOIN Car c ON ca.car_id = c.car_id";

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
                ca.setCarModel(rs.getString("car_model")); // thêm dòng này
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
