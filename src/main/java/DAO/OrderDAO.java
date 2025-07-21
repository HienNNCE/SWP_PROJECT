/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Order;
import Model.OrderDetail;
import java.math.BigDecimal;

import DB.DBContext;

import java.sql.*;
import java.util.*;

/**
 *
 * @author acer
 */
public class OrderDAO extends DBContext {
    public static void main(String[] args) {
    OrderDAO oderDAO = new OrderDAO();
    int count = oderDAO.countOrders();
        System.out.println(count);
    }

    public List<Order> getAllOrders() {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM [Order]";
        try (Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Order o = new Order();
                o.setOrderId(rs.getInt("order_id"));
                o.setUserId(rs.getInt("user_id"));
                o.setOrderPrice(rs.getBigDecimal("order_price"));
                o.setOrderStatus(rs.getString("order_status"));
                o.setOrderDate(rs.getTimestamp("order_date"));
                o.setPaymentId(rs.getInt("payment_id"));
                list.add(o);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Order getOrderById(int orderId) {
        String sql = "SELECT * FROM [Order] WHERE order_id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Order o = new Order();
                    o.setOrderId(rs.getInt("order_id"));
                    o.setUserId(rs.getInt("user_id"));
                    o.setOrderPrice(rs.getBigDecimal("order_price"));
                    o.setOrderStatus(rs.getString("order_status"));
                    o.setOrderDate(rs.getTimestamp("order_date"));
                    o.setPaymentId(rs.getInt("payment_id"));
                    return o;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public int insertOrder(Order o) {
        String sql = "INSERT INTO [Order] (user_id, order_price, order_status, order_date, payment_id) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, o.getUserId());
            ps.setBigDecimal(2, o.getOrderPrice());
            ps.setString(3, o.getOrderStatus());
            ps.setTimestamp(4, new java.sql.Timestamp(o.getOrderDate().getTime()));
            ps.setInt(5, o.getPaymentId());
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    public void updateOrder(Order o) {
        String sql = "UPDATE [Order] SET user_id=?, order_price=?, order_status=?, order_date=?, payment_id=? WHERE order_id=?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, o.getUserId());
            ps.setBigDecimal(2, o.getOrderPrice());
            ps.setString(3, o.getOrderStatus());
            ps.setTimestamp(4, new java.sql.Timestamp(o.getOrderDate().getTime()));
            ps.setInt(5, o.getPaymentId());
            ps.setInt(6, o.getOrderId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateOrderStatus(int orderId, String status) {
        String sql = "UPDATE [Order] SET order_status=? WHERE order_id=?";
        Connection conn = this.getConnection();
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, orderId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteOrder(int orderId) {
        String deleteOrderDetailSql = "DELETE FROM [OrderDetail] WHERE order_id=?";
        String deleteOrderSql = "DELETE FROM [Order] WHERE order_id=?";
        try (Connection conn = getConnection()) {
            conn.setAutoCommit(false); // Bắt đầu transaction

            try (PreparedStatement ps1 = conn.prepareStatement(deleteOrderDetailSql);
                    PreparedStatement ps2 = conn.prepareStatement(deleteOrderSql)) {

                ps1.setInt(1, orderId);
                ps1.executeUpdate();

                ps2.setInt(1, orderId);
                ps2.executeUpdate();

                conn.commit(); // Nếu cả hai xóa thành công thì commit
            } catch (SQLException e) {
                conn.rollback(); // Có lỗi thì rollback
                e.printStackTrace();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public int countOrders() {
        int count = 0;
        String query = "SELECT COUNT(*) FROM [Order]"; // Thay "orders" bằng tên bảng thật nếu khác
        try (Connection conn = new DBContext().getConnection();
                PreparedStatement ps = conn.prepareStatement(query);
                ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                count = rs.getInt(1); // Cột đầu tiên chứa số lượng
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Xử lý lỗi theo nhu cầu
        }
        return count;
    }

    public BigDecimal getTotalRevenue() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from
        // nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public List<Order> getLatestOrders(int i) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from
        // nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public List<Order> getOrdersByUserId(int userId) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM [Order] WHERE user_id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order o = new Order();
                    o.setOrderId(rs.getInt("order_id"));
                    o.setUserId(rs.getInt("user_id"));
                    o.setOrderPrice(rs.getBigDecimal("order_price"));
                    o.setOrderStatus(rs.getString("order_status"));
                    o.setOrderDate(rs.getTimestamp("order_date"));
                    o.setPaymentId(rs.getInt("payment_id"));
                    list.add(o);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<OrderDetail> getOrderDetailById(int orderId) {
        List<OrderDetail> details = new ArrayList<>();
        String sql = "SELECT order_detail_id, order_id, part_id, quantity, price, total_price FROM OrderDetail WHERE order_id = ?";
        Connection conn = this.getConnection();
        try (
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderDetail detail = new OrderDetail();
                    detail.setOrderDetailId(rs.getInt("order_detail_id"));
                    detail.setOrderId(rs.getInt("order_id"));
                    detail.setPartId(rs.getInt("part_id"));
                    detail.setQuantity(rs.getInt("quantity"));
                    detail.setPrice(rs.getBigDecimal("price"));
                    detail.setTotalPrice(rs.getBigDecimal("total_price"));
                    details.add(detail);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return details;
    }

    public void insertOrderDetail(OrderDetail detail) {
        String sql = "INSERT INTO [OrderDetail] (order_id, part_id, quantity, price, total_price) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, detail.getOrderId());
            ps.setInt(2, detail.getPartId());
            ps.setInt(3, detail.getQuantity());
            ps.setBigDecimal(4, detail.getPrice());
            ps.setBigDecimal(5, detail.getTotalPrice());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
