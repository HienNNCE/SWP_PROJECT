package DAO;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import DB.DBContext;
import Model.OrderDetail;
import Model.Part;

public class OrderDetailDAO extends DBContext {
//    public static void main(String[] args) {
//        OrderDetailDAO dao = new OrderDetailDAO();
//        List<OrderDetail> orderDetails = dao.getOrderDetailWithPartByOrderId(5);
//        for (OrderDetail orderDetail : orderDetails) {
//            System.out.println(orderDetail.getPart().getPartName());
//        }
//    }

    public void updateOrderPrice(int orderId) {
        String sql = "SELECT SUM(total_price) AS total FROM [OrderDetail] WHERE order_id = ?";

        try (Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    BigDecimal total = rs.getBigDecimal("total");
                    if (total == null)
                        total = BigDecimal.ZERO;

                    // Cập nhật bảng Order
                    String updateSql = "UPDATE [Order] SET order_price = ? WHERE order_id = ?";
                    try (PreparedStatement updatePs = conn.prepareStatement(updateSql)) {
                        updatePs.setBigDecimal(1, total);
                        updatePs.setInt(2, orderId);
                        updatePs.executeUpdate();
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean updateOrderDetail(OrderDetail orderDetail) {
        String sql = "UPDATE [OrderDetail] SET quantity = ?, price = ?, total_price = ? WHERE order_detail_id = ?";
        Connection conn = this.getConnection();
        try (PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderDetail.getQuantity());
            ps.setBigDecimal(2, orderDetail.getPrice());
            ps.setBigDecimal(3, orderDetail.getTotalPrice());
            ps.setInt(4, orderDetail.getOrderDetailId());

            int rows = ps.executeUpdate();

            // Sau khi cập nhật OrderDetail => cập nhật tổng giá trị Order
            if (rows > 0) {
                updateOrderPrice(orderDetail.getOrderId());
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public List<OrderDetail> getOrderDetailWithPartByOrderId(int orderId) {
        List<OrderDetail> list = new ArrayList<>();
        String sql = "SELECT od.*, p.* FROM [OrderDetail] od " +
                "JOIN [Part] p ON od.part_id = p.part_id " +
                "WHERE od.order_id = ?";

        try (Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderDetail od = new OrderDetail();
                    od.setOrderDetailId(rs.getInt("order_detail_id"));
                    od.setOrderId(rs.getInt("order_id"));
                    od.setPartId(rs.getInt("part_id"));
                    od.setQuantity(rs.getInt("quantity"));
                    od.setPrice(rs.getBigDecimal("price"));
                    od.setTotalPrice(rs.getBigDecimal("total_price"));

                    // Set Part thông qua model Part
                    Part part = new Part();
                    part.setPartId(rs.getInt("part_id"));
                    part.setPartName(rs.getString("part_name"));
                    part.setPartBrand(rs.getString("part_brand"));
                    part.setCarModel(rs.getString("car_model"));
                    part.setDescription(rs.getString("description"));
                    part.setPartImg(rs.getString("part_img"));
                    part.setPartStock(rs.getInt("part_stock"));
                    part.setPartPrice(rs.getBigDecimal("part_price"));

                    od.setPart(part);

                    list.add(od);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<OrderDetail> getOrderDetailByOrderId(int orderId) {
        List<OrderDetail> list = new ArrayList<>();
        String sql = "SELECT * FROM [OrderDetail] WHERE order_id = ?";
        Connection conn = this.getConnection();
        try (PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderDetail od = new OrderDetail();
                    od.setOrderDetailId(rs.getInt("order_detail_id"));
                    od.setOrderId(rs.getInt("order_id"));
                    od.setPartId(rs.getInt("part_id"));
                    od.setQuantity(rs.getInt("quantity"));
                    od.setPrice(rs.getBigDecimal("price"));
                    od.setTotalPrice(rs.getBigDecimal("total_price"));
                    list.add(od);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public OrderDetail getOrderDetailByOrderDetailId(int orderDetailId) {
        String sql = "SELECT * FROM [OrderDetail] WHERE order_detail_id = ?";
        OrderDetail od = null;
        Connection conn = this.getConnection();
        try (PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderDetailId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    od = new OrderDetail();
                    od.setOrderDetailId(rs.getInt("order_detail_id"));
                    od.setOrderId(rs.getInt("order_id"));
                    od.setPartId(rs.getInt("part_id"));
                    od.setQuantity(rs.getInt("quantity"));
                    od.setPrice(rs.getBigDecimal("price"));
                    od.setTotalPrice(rs.getBigDecimal("total_price"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return od;
    }
}
