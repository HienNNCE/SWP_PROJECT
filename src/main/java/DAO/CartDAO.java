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
import java.sql.Statement;
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
        boolean sucess = cDAO.addToCart(1, 1);
        List<Cart> carts = cDAO.getCartByUserId(1);
        for (Cart c : carts) {
            System.out.println("Cart ID: " + c.getCartId() + ", User ID: " + c.getUserId() + ", Count Item: "
                    + c.getCountItem() + ", Cart Price: " + c.getCartPrice() + ", Part ID: " + c.getPartId());
        }
        // if (sucess) {
        //     System.out.println("Sucess");
        // } else {
        //     System.out.println("Fail");
        // }
        // double total = cDAO.getTotalCartPrice(3);
        // System.out.println(total);
        // cDAO.addToCart(3, 6);
        // List<Part> gameInCarts = cDAO.getGamesInCartByUserId(1);
        // for (Part g : gameInCarts) {
        // //System.out.println(g.getTitle());
        // }
    }

    public boolean clearCart(int userId) {
        String query = "DELETE FROM Cart WHERE user_id = ?";
        try (Connection connection = getConnection(); PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setInt(1, userId);
            return stmt.executeUpdate() > 0; // Trả về true nếu có ít nhất một hàng bị xóa

        } catch (SQLException ex) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, "Error clearing cart", ex);
            return false;
        }
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
    //
    // public double getAllTotalCartPrice() {
    // double totalPrice = 0.0;
    // String sql = "SELECT SUM(g.price) AS total FROM Cart c JOIN Games g ON
    // c.game_id = g.game_id";
    // try {
    // PreparedStatement ps = this.getConnection().prepareStatement(sql);
    // ResultSet rs = ps.executeQuery();
    // if (rs.next()) {
    // totalPrice = rs.getDouble("total");
    // }
    // } catch (Exception e) {
    // e.printStackTrace();
    // }
    // return totalPrice;
    // }
    //

    public double getTotalCartPrice(int userId) {
        double totalPrice = 0;
        String sql = " SELECT SUM(p.part_price * cd.pt_order_quantity) AS total\r\n" + //
                "                    FROM Cart c\r\n" + //
                "                    JOIN CartDetail cd ON c.cart_id = cd.cart_id\r\n" + //
                "                    JOIN Part p ON cd.part_id = p.part_id\r\n" + //
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

    //
    // // Lấy tất cả sản phẩm trong giỏ hàng
    // public ArrayList<Part> getAllCarts() {
    // try {
    // ArrayList<Cart> cartList = new ArrayList<>();
    // String query = "SELECT * FROM Cart";
    // PreparedStatement pStatement = this.getConnection().prepareStatement(query);
    // ResultSet rs = pStatement.executeQuery();
    //
    // while (rs.next()) {
    // cartList.add(new Cart(
    // rs.getInt("cart_id"),
    // rs.getInt("user_id"),
    // rs.getInt("game_id"),
    // rs.getTimestamp("created_at")
    // ));
    // }
    // return cartList;
    // } catch (SQLException e) {
    // }
    // return null;
    // }
    //
    // public List<Part> getGamesInCartByUserId(int userId) {
    // List<Part> games = new ArrayList<>();
    // String sql = "SELECT g.* FROM Cart c JOIN Games g ON c.game_id = g.game_id
    // WHERE c.user_id = ?";
    // try ( PreparedStatement ps = this.getConnection().prepareStatement(sql)) {
    // ps.setInt(1, userId);
    // try ( ResultSet rs = ps.executeQuery()) {
    // while (rs.next()) {
    // int gameId = rs.getInt("game_id");
    // List<String> platforms = getPlatformsByGameId(gameId);
    // Part part = new Part(
    // gameId,
    // rs.getString("title"),
    // rs.getString("description"),
    // rs.getString("image_url"),
    // rs.getBigDecimal("price"),
    // null,
    // null, // createdAt (nếu cần, bạn có thể lấy
    // `rs.getDate("created_at").toLocalDate()`)
    // null, null, null, platforms, null // Developers, publishers, genres,
    // platforms, categories
    // );
    // games.add(part);
    // }
    // }
    // } catch (SQLException e) {
    // e.printStackTrace();
    // }
    // return games;
    // }
    //
    // private List<String> getPlatformsByGameId(int gameId) {
    // List<String> platforms = new ArrayList<>();
    // String sql = "SELECT p.name FROM Game_Platforms gp JOIN Platforms p ON
    // gp.platform_id = p.platform_id WHERE gp.game_id = ?";
    //
    // try ( PreparedStatement ps = this.getConnection().prepareStatement(sql)) {
    // ps.setInt(1, gameId);
    // try ( ResultSet rs = ps.executeQuery()) {
    // while (rs.next()) {
    // platforms.add(rs.getString("name"));
    // }
    // }
    // } catch (SQLException e) {
    // e.printStackTrace();
    // }
    // return platforms;
    // }
    //
    // // Lấy giỏ hàng theo user_id
    public List<Cart> getCartByUserId(int userId) {
        List<Cart> cartList = new ArrayList<>();
        String sql = "SELECT c.cart_id, c.user_id, c.count_item, c.cart_price, cd.part_id\r\n" + //
                "                    FROM Cart c\r\n" + //
                "                    JOIN CartDetail cd ON c.cart_id = cd.cart_id\r\n" + //
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
        String getCartSql = "SELECT cart_id, count_item, cart_price FROM Cart WHERE user_id = ?";
        String getMaxCartIdSql = "SELECT ISNULL(MAX(cart_id), 0) + 1 AS new_cart_id FROM Cart";
        String insertCartSql = "INSERT INTO Cart (cart_id, user_id, count_item, cart_price) VALUES (?, ?, 0, 0)";
        String checkPartSql = "SELECT pt_order_quantity FROM CartDetail WHERE cart_id = ? AND part_id = ?";
        String insertDetailSql = "INSERT INTO CartDetail (cart_id, part_id, pt_order_quantity) VALUES (?, ?, 1)";
        String updateDetailSql = "UPDATE CartDetail SET pt_order_quantity = pt_order_quantity + 1 WHERE cart_id = ? AND part_id = ?";
        String getPartPriceSql = "SELECT part_price FROM Part WHERE part_id = ?";
        String updateCartSql = "UPDATE Cart SET count_item = ?, cart_price = ? WHERE cart_id = ?";

        try (Connection conn = this.getConnection()) {
            conn.setAutoCommit(false); // Transaction

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
            System.out.println("🛒 After update - cartId: " + cartId + ", countItem: " + newCountItem + ", total: "
                    + newCartPrice);

            conn.commit();
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    //
    // // Xóa sản phẩm khỏi giỏ hàng
    // public boolean removeFromCart(int userId, int gameId) {
    // String sql = "DELETE FROM Cart WHERE user_id = ? AND game_id = ?";
    // try ( PreparedStatement ps = this.getConnection().prepareStatement(sql)) {
    // ps.setInt(1, userId);
    // ps.setInt(2, gameId);
    // int rowsAffected = ps.executeUpdate();
    // return rowsAffected > 0; // Trả về true nếu có ít nhất 1 dòng bị xóa
    // } catch (SQLException e) {
    // e.printStackTrace();
    // return false; // Trả về false nếu có lỗi xảy ra
    // }
    // }
    //
    // // Xóa toàn bộ giỏ hàng của một user (nếu cần)
    // public void clearCartByUserId(int userId) {
    // String sql = "DELETE FROM Cart WHERE user_id = ?";
    // try ( PreparedStatement ps = this.getConnection().prepareStatement(sql)) {
    // ps.setInt(1, userId);
    // ps.executeUpdate();
    // } catch (SQLException e) {
    // e.printStackTrace();
    // }
    // }
}
