/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DB.DBContext;
import Model.Cart;
import Model.Part;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author thien
 */
public class CartDAO extends DBContext {

    public static void main(String[] a) {
        CartDAO cDAO = new CartDAO();
        cDAO.clearCartByUserId(102);

    }

    public boolean checkoutCartAndUpdateStock(int userId) {
        String getCartItemsSql = "SELECT cd.part_id, cd.pt_order_quantity FROM CartDetail cd "
                + "JOIN Cart c ON cd.cart_id = c.cart_id "
                + "WHERE c.user_id = ?";
        String updateStockSql = "UPDATE Part SET part_stock = part_stock - ? WHERE part_id = ? AND part_stock >= ?";

        Connection conn = this.getConnection();
        try {
            if (conn == null)
                throw new SQLException("Cannot get DB connection");

            conn.setAutoCommit(false); // ❗ Bắt đầu transaction

            List<int[]> partList = new ArrayList<>();

            // 1. Lấy sản phẩm và số lượng trong giỏ
            try (PreparedStatement ps = conn.prepareStatement(getCartItemsSql)) {
                ps.setInt(1, userId);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        int partId = rs.getInt("part_id");
                        int quantity = rs.getInt("pt_order_quantity");
                        partList.add(new int[] { partId, quantity });
                    }
                }
            }

            // 2. Cập nhật tồn kho
            for (int[] item : partList) {
                int partId = item[0];
                int quantity = item[1];

                try (PreparedStatement ps = conn.prepareStatement(updateStockSql)) {
                    ps.setInt(1, quantity);
                    ps.setInt(2, partId);
                    ps.setInt(3, quantity);
                    int rowsAffected = ps.executeUpdate();
                    if (rowsAffected == 0) {
                        conn.rollback();
                        return false;
                    }
                }
            }

            conn.commit(); // ✅ Commit thành công
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            try {
                if (conn != null)
                    conn.rollback(); // Rollback nếu lỗi
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        return false;
    }

    public int getCartItemCount(int userId) {
        String sql = "SELECT SUM(cd.pt_order_quantity) AS total_items "
                + "FROM Cart c "
                + "JOIN CartDetail cd ON c.cart_id = cd.cart_id "
                + "WHERE c.user_id = ?";
        Connection conn = this.getConnection();
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    int count = rs.getInt("total_items");
                    return rs.wasNull() ? 0 : count; // Tránh null trả về 0
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public boolean increaseQuantity(int userId, int partId) {
        String getStockSql = "SELECT part_stock FROM Part WHERE part_id = ?";
        String updateDetailSql = "UPDATE CartDetail SET pt_order_quantity = pt_order_quantity + 1 "
                + "WHERE cart_id = (SELECT cart_id FROM Cart WHERE user_id = ?) AND part_id = ?";
        String updateCartSql = "UPDATE Cart SET count_item = count_item + 1, cart_price = cart_price + ? WHERE cart_id = (SELECT cart_id FROM Cart WHERE user_id = ?)";
        String getPartPriceSql = "SELECT part_price FROM Part WHERE part_id = ?";
        int partCartCount = this.getReservedQuantity(partId, userId);
        Connection conn = this.getConnection();
        try {
            conn.setAutoCommit(false);
            // Kiểm tra tồn kho
            int partStock = 0;
            try (PreparedStatement ps = conn.prepareStatement(getStockSql)) {
                ps.setInt(1, partId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        partStock = rs.getInt("part_stock");
                    }
                }
            }
            int availableStock = partStock - partCartCount;
            if (availableStock <= 0) {
                conn.rollback();
                return false; // Hết hàng
            }

            java.math.BigDecimal partPrice = java.math.BigDecimal.ZERO;
            // Lấy giá part
            try (PreparedStatement ps = conn.prepareStatement(getPartPriceSql)) {
                ps.setInt(1, partId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        partPrice = rs.getBigDecimal("part_price");
                    }
                }
            }
            // Update CartDetail
            try (PreparedStatement ps = conn.prepareStatement(updateDetailSql)) {
                ps.setInt(1, userId);
                ps.setInt(2, partId);
                ps.executeUpdate();
            }
            // Update Cart
            try (PreparedStatement ps = conn.prepareStatement(updateCartSql)) {
                ps.setBigDecimal(1, partPrice);
                ps.setInt(2, userId);
                ps.executeUpdate();
            }
            // // Update part stock
            // String updateStockSql = "UPDATE Part SET part_stock = part_stock - 1 WHERE
            // part_id = ?";
            // try (PreparedStatement ps = conn.prepareStatement(updateStockSql)) {
            // ps.setInt(1, partId);
            // ps.executeUpdate();
            // }
            conn.commit();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public void decreaseQuantity(int userId, int partId) {
        String getCartIdSql = "SELECT cart_id FROM Cart WHERE user_id = ?";
        String getQuantitySql = "SELECT pt_order_quantity FROM CartDetail WHERE cart_id = ? AND part_id = ?";
        String deleteDetailSql = "DELETE FROM CartDetail WHERE cart_id = ? AND part_id = ?";
        String updateDetailSql = "UPDATE CartDetail SET pt_order_quantity = pt_order_quantity - 1 WHERE cart_id = ? AND part_id = ?";
        String updateCartSql = "UPDATE Cart SET count_item = count_item - 1, cart_price = cart_price - ? WHERE cart_id = ?";
        String getPartPriceSql = "SELECT part_price FROM Part WHERE part_id = ?";
        Connection conn = this.getConnection();
        try {
            conn.setAutoCommit(false);

            int cartId = -1;
            int quantity = 0;
            java.math.BigDecimal partPrice = java.math.BigDecimal.ZERO;

            // Lấy cart_id
            try (PreparedStatement ps = conn.prepareStatement(getCartIdSql)) {
                ps.setInt(1, userId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        cartId = rs.getInt("cart_id");
                    } else {
                        conn.rollback();
                        return;
                    }
                }
            }

            // Lấy số lượng hiện tại
            try (PreparedStatement ps = conn.prepareStatement(getQuantitySql)) {
                ps.setInt(1, cartId);
                ps.setInt(2, partId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        quantity = rs.getInt("pt_order_quantity");
                    } else {
                        conn.rollback();
                        return;
                    }
                }
            }

            // Lấy giá part
            try (PreparedStatement ps = conn.prepareStatement(getPartPriceSql)) {
                ps.setInt(1, partId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        partPrice = rs.getBigDecimal("part_price");
                    }
                }
            }

            if (quantity <= 1) {
                // Xóa CartDetail
                try (PreparedStatement ps = conn.prepareStatement(deleteDetailSql)) {
                    ps.setInt(1, cartId);
                    ps.setInt(2, partId);
                    ps.executeUpdate();
                }
                // Update Cart
                try (PreparedStatement ps = conn.prepareStatement(updateCartSql)) {
                    ps.setBigDecimal(1, partPrice);
                    ps.setInt(2, cartId);
                    ps.executeUpdate();
                }
            } else {
                // Giảm số lượng
                try (PreparedStatement ps = conn.prepareStatement(updateDetailSql)) {
                    ps.setInt(1, cartId);
                    ps.setInt(2, partId);
                    ps.executeUpdate();
                }
                // Update Cart
                try (PreparedStatement ps = conn.prepareStatement(updateCartSql)) {
                    ps.setBigDecimal(1, partPrice);
                    ps.setInt(2, cartId);
                    ps.executeUpdate();
                }

                // // Update part stock
                // String updateStockSql = "UPDATE Part SET part_stock = part_stock + 1 WHERE
                // part_id = ?";
                // try (PreparedStatement ps = conn.prepareStatement(updateStockSql)) {
                // ps.setInt(1, partId);
                // ps.executeUpdate();
                // }
            }

            conn.commit();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void removePartFromCart(int userId, int partId) {
        String getCartIdSql = "SELECT cart_id FROM Cart WHERE user_id = ?";
        String getPartQuantityAndPriceSql = "SELECT pt_order_quantity, p.part_price FROM CartDetail cd JOIN Part p ON cd.part_id = p.part_id WHERE cd.cart_id = ? AND cd.part_id = ?";
        String deletePartSql = "DELETE FROM CartDetail WHERE cart_id = ? AND part_id = ?";
        String updateCartSql = "UPDATE Cart SET count_item = CASE WHEN count_item - ? < 0 THEN 0 ELSE count_item - ? END, cart_price = CASE WHEN cart_price - ? < 0 THEN 0 ELSE cart_price - ? END WHERE cart_id = ?";

        try (Connection conn = this.getConnection()) {
            conn.setAutoCommit(false);

            int cartId = -1;
            int quantity = 0;
            java.math.BigDecimal partPrice = java.math.BigDecimal.ZERO;

            // Lấy cart_id
            try (PreparedStatement ps = conn.prepareStatement(getCartIdSql)) {
                ps.setInt(1, userId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        cartId = rs.getInt("cart_id");
                    } else {
                        conn.rollback();
                        return;
                    }
                }
            }

            // Lấy số lượng và giá part
            try (PreparedStatement ps = conn.prepareStatement(getPartQuantityAndPriceSql)) {
                ps.setInt(1, cartId);
                ps.setInt(2, partId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        quantity = rs.getInt("pt_order_quantity");
                        partPrice = rs.getBigDecimal("part_price");
                    } else {
                        conn.rollback();
                        return;
                    }
                }
            }

            // Xóa part khỏi CartDetail
            try (PreparedStatement ps = conn.prepareStatement(deletePartSql)) {
                ps.setInt(1, cartId);
                ps.setInt(2, partId);
                ps.executeUpdate();
            }

            // Cập nhật lại Cart (không để âm)
            java.math.BigDecimal totalRemove = partPrice.multiply(new java.math.BigDecimal(quantity));
            try (PreparedStatement ps = conn.prepareStatement(updateCartSql)) {
                ps.setInt(1, quantity);
                ps.setInt(2, quantity);
                ps.setBigDecimal(3, totalRemove);
                ps.setBigDecimal(4, totalRemove);
                ps.setInt(5, cartId);
                ps.executeUpdate();
            }

            conn.commit();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Cart getCartDetailByUserId(int userId) {
        Cart cart = null;
        String sql = " SELECT \n"
                + "            c.cart_id,\n"
                + "            c.user_id,\n"
                + "            c.count_item,\n"
                + "            c.cart_price,\n"
                + "            cd.part_id,\n"
                + "            p.part_name,\n"
                + "            p.part_brand,\n"
                + "            p.part_price,\n"
                + "            p.part_img,\n"
                + "            p.part_stock,\n"
                + "            cd.pt_order_quantity,\n"
                + "            (cd.pt_order_quantity * p.part_price) AS total_price\n"
                + "        FROM Cart c\n"
                + "        JOIN CartDetail cd ON c.cart_id = cd.cart_id\n"
                + "        JOIN Part p ON cd.part_id = p.part_id\n"
                + "        WHERE c.user_id = ?";
        Connection conn = this.getConnection();
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                List<Part> parts = new ArrayList<>();

                while (rs.next()) {
                    if (cart == null) {
                        cart = new Cart();
                        cart.setCartId(rs.getInt("cart_id"));
                        cart.setUserId(rs.getInt("user_id"));
                        cart.setCountItem(rs.getInt("count_item"));
                        cart.setCartPrice(rs.getBigDecimal("cart_price"));
                    }

                    Part part = new Part();
                    part.setPartId(rs.getInt("part_id"));
                    part.setPartName(rs.getString("part_name"));
                    part.setPartBrand(rs.getString("part_brand"));
                    part.setPartPrice(rs.getBigDecimal("part_price"));
                    part.setPartImg(rs.getString("part_img"));
                    part.setPartStock(rs.getInt("part_stock"));
                    part.setQuantityInCart(rs.getInt("pt_order_quantity"));
                    part.setTotalPrice(rs.getBigDecimal("total_price"));

                    parts.add(part);
                }

                if (cart != null) {
                    cart.setPartList(parts);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return cart;
    }

    public double getPartPrice(int partId) {
        String sql = "SELECT part_price FROM Part WHERE part_id = ?";
        try (PreparedStatement ps = this.getConnection().prepareStatement(sql)) {
            ps.setInt(1, partId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getBigDecimal("part_price").doubleValue();
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public double getTotalCartPrice(int userId) {
        double totalPrice = 0;
        String sql = " SELECT SUM(p.part_price * cd.pt_order_quantity) AS total\r\n"
                + //
                "                    FROM Cart c\r\n"
                + //
                "                    JOIN CartDetail cd ON c.cart_id = cd.cart_id\r\n"
                + //
                "                    JOIN Part p ON cd.part_id = p.part_id\r\n"
                + //
                "                    WHERE c.user_id = ?";

        try (PreparedStatement ps = this.getConnection().prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    totalPrice = rs.getDouble("total");
                    if (rs.wasNull()) {
                        totalPrice = 0; // đảm bảo không bị NaN
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return totalPrice;
    }

    public List<Cart> getCartByUserId(int userId) {
        List<Cart> cartList = new ArrayList<>();
        String sql = "SELECT c.cart_id, c.user_id, c.count_item, c.cart_price, cd.part_id\r\n"
                + //
                "                    FROM Cart c\r\n"
                + //
                "                    JOIN CartDetail cd ON c.cart_id = cd.cart_id\r\n"
                + //
                "                    WHERE c.user_id = ?";

        try (PreparedStatement ps = this.getConnection().prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Cart cart = new Cart(
                            rs.getInt("cart_id"),
                            rs.getInt("user_id"),
                            rs.getInt("count_item"),
                            rs.getBigDecimal("cart_price"),
                            rs.getInt("part_id") // part_id là từng sản phẩm trong cart
                    );
                    cartList.add(cart);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return cartList;
    }

    //
    public boolean isPartInCart(int userId, int partId) {
        String sql = "SELECT COUNT(*) FROM Cart WHERE user_id = ? AND part_id = ?";
        try (PreparedStatement ps = this.getConnection().prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, partId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0; // Trả về true nếu có ít nhất 1 kết quả
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    //
    // // Thêm sản phẩm vào giỏ hàng
    public boolean addToCart(int userId, int partId) {
        String getStockSql = "SELECT part_stock FROM Part WHERE part_id = ?";
        String getCartSql = "SELECT cart_id, count_item, cart_price FROM Cart WHERE user_id = ?";
        String getMaxCartIdSql = "SELECT ISNULL(MAX(cart_id), 0) + 1 AS new_cart_id FROM Cart";
        String insertCartSql = "INSERT INTO Cart (cart_id, user_id, count_item, cart_price) VALUES (?, ?, 0, 0)";
        String checkPartSql = "SELECT pt_order_quantity FROM CartDetail WHERE cart_id = ? AND part_id = ?";
        String insertDetailSql = "INSERT INTO CartDetail (cart_id, part_id, pt_order_quantity) VALUES (?, ?, 1)";
        String updateDetailSql = "UPDATE CartDetail SET pt_order_quantity = pt_order_quantity + 1 WHERE cart_id = ? AND part_id = ?";
        String getPartPriceSql = "SELECT part_price FROM Part WHERE part_id = ?";
        String updateCartSql = "UPDATE Cart SET count_item = ?, cart_price = ? WHERE cart_id = ?";
        int partCartCount = this.getReservedQuantity(partId, userId);

        Connection conn = this.getConnection();
        try {
            conn.setAutoCommit(false); // Transaction

            // 0. Kiểm tra tồn kho
            int partStock = 0;
            try (PreparedStatement ps = conn.prepareStatement(getStockSql)) {
                ps.setInt(1, partId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        partStock = rs.getInt("part_stock");
                    }
                }
            }
            int availableStock = partStock - partCartCount;
            if (availableStock <= 0) {
                conn.rollback();
                return false; // Hết hàng
            }

            int cartId = -1;
            int newCountItem = 0;
            BigDecimal newCartPrice = BigDecimal.ZERO;
            BigDecimal partPrice = BigDecimal.ZERO;

            // 1. Kiểm tra cart đã tồn tại chưa
            try (PreparedStatement ps = conn.prepareStatement(getCartSql)) {
                ps.setInt(1, userId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        cartId = rs.getInt("cart_id");
                        newCountItem = rs.getInt("count_item");
                        newCartPrice = rs.getBigDecimal("cart_price");
                    }
                }
            }

            // 2. Nếu chưa có cart, tạo mới và sinh cartId thủ công
            if (cartId == -1) {
                try (PreparedStatement ps = conn.prepareStatement(getMaxCartIdSql); ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        cartId = rs.getInt("new_cart_id");
                    } else {
                        conn.rollback();
                        return false;
                    }
                }

                try (PreparedStatement ps = conn.prepareStatement(insertCartSql)) {
                    ps.setInt(1, cartId);
                    ps.setInt(2, userId);
                    ps.executeUpdate();
                }
            }

            // 3. Lấy giá part
            try (PreparedStatement ps = conn.prepareStatement(getPartPriceSql)) {
                ps.setInt(1, partId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        partPrice = rs.getBigDecimal("part_price");
                    } else {
                        conn.rollback();
                        return false;
                    }
                }
            }

            // 4. Kiểm tra part đã có trong cart chưa
            boolean partExists = false;
            try (PreparedStatement ps = conn.prepareStatement(checkPartSql)) {
                ps.setInt(1, cartId);
                ps.setInt(2, partId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        partExists = true;
                    }
                }
            }

            // 5. Thêm mới hoặc cập nhật CartDetail
            if (partExists) {
                try (PreparedStatement ps = conn.prepareStatement(updateDetailSql)) {
                    ps.setInt(1, cartId);
                    ps.setInt(2, partId);
                    ps.executeUpdate();
                }
            } else {
                try (PreparedStatement ps = conn.prepareStatement(insertDetailSql)) {
                    ps.setInt(1, cartId);
                    ps.setInt(2, partId);
                    ps.executeUpdate();
                }
            }

            // 6. Cập nhật giỏ hàng
            newCountItem += 1;
            newCartPrice = newCartPrice.add(partPrice);

            try (PreparedStatement ps = conn.prepareStatement(updateCartSql)) {
                ps.setInt(1, newCountItem);
                ps.setBigDecimal(2, newCartPrice);
                ps.setInt(3, cartId);
                ps.executeUpdate();
            }

            // // 7. Giảm tồn kho sản phẩm
            // String updateStockSql = "UPDATE Part SET part_stock = part_stock - 1 WHERE
            // part_id = ? AND part_stock > 0";
            // try (PreparedStatement ps = conn.prepareStatement(updateStockSql)) {
            // ps.setInt(1, partId);
            // ps.executeUpdate();
            // }

            conn.commit();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public int getReservedQuantity(int partId, int userId) {
        int reserved = 0;
        String sql = "SELECT SUM(cd.pt_order_quantity) AS reserved_quantity "
                + "FROM CartDetail cd "
                + "JOIN Cart c ON cd.cart_id = c.cart_id "
                + "WHERE c.user_id = ? AND cd.part_id = ?";
        Connection conn = this.getConnection();
        try (
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, partId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    reserved = rs.getInt("reserved_quantity");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return reserved;
    }

    public void clearCartByUserId(int userId) {
        String getCartIdSql = "SELECT cart_id FROM Cart WHERE user_id = ?";
        String deleteDetailSql = "DELETE FROM CartDetail WHERE cart_id = ?";
        String deleteCartSql = "DELETE FROM Cart WHERE cart_id = ?";

        Connection conn = this.getConnection();

        try {
            conn.setAutoCommit(false); // Bắt đầu transaction

            try (PreparedStatement ps1 = conn.prepareStatement(getCartIdSql)) {
                ps1.setInt(1, userId);
                try (ResultSet rs = ps1.executeQuery()) {
                    if (rs.next()) {
                        int cartId = rs.getInt("cart_id");

                        // Xóa chi tiết giỏ hàng
                        try (PreparedStatement ps2 = conn.prepareStatement(deleteDetailSql)) {
                            ps2.setInt(1, cartId);
                            ps2.executeUpdate();
                        }

                        // Xóa chính giỏ hàng
                        try (PreparedStatement ps3 = conn.prepareStatement(deleteCartSql)) {
                            ps3.setInt(1, cartId);
                            ps3.executeUpdate();
                        }

                        conn.commit(); // Nếu mọi thứ OK thì commit
                    }
                }
            } catch (SQLException e) {
                conn.rollback(); // Nếu lỗi thì rollback toàn bộ
                e.printStackTrace();
            } finally {
                conn.setAutoCommit(true); // Khôi phục lại trạng thái mặc định
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}
