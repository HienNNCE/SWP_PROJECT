/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import DAO.CartDAO;
import DAO.PartDAO;
import Model.Cart;
import jakarta.servlet.annotation.WebServlet;
import java.math.BigDecimal;

/**
 *
 * @author thien
 */
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt
 * to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to
 * edit this template
 * /**
 *
 * @author ALIENWARE
 */
@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("Request received!");

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        String partIdStr = request.getParameter("id");
        if (partIdStr == null || !partIdStr.matches("\\d+")) {
            System.out.println("Error: Invalid partId: " + partIdStr);
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Part id incorrect.");
            return;
        }

        int partId = Integer.parseInt(partIdStr);
        System.out.println("Recived partID: " + partId);
        System.out.println("Recived userId: " + userId);
        System.out.println("userId: " + userId + ", partId: " + partId);

        CartDAO cartDAO = new CartDAO();

        if (userId == null) {
            System.out.println("Error: userId is null. Redirecting to login.");
            response.sendRedirect(request.getContextPath() + "/login");
            // Chuyển hướng về trang đăng nhập
            return;
        }

        // Đã login → xử lý giỏ hàng DB
        boolean success = cartDAO.addToCart(userId, partId);
        if (success) {
            CartDAO cDAO = new CartDAO();
            PartDAO pDAO = new PartDAO();
            int cartCount = 0;
            BigDecimal totalPrice = null;
            Cart cart = cDAO.getCartDetailByUserId(userId);
            cartCount = cart.getCountItem();
            totalPrice = cart.getCartPrice();
            int partStock = pDAO.getPartById(partId).getPartStock();
            session.setAttribute("totalPrice", totalPrice);
            System.out.println("Part added successfully. Cart Count: " + cartCount + ", Total Price: " + totalPrice + ", Part Stock: " + partStock);
            response.getWriter().print(
                    "{\"status\":\"success\", \"cartCount\":" + cartCount + ", \"totalPrice\":" + totalPrice + ", \"partStock\":" + partStock +"}");
        } else {
            //Kiem tra ton kho
            // Kiểm tra tồn kho để trả về đúng status
            int partStock = 0;
            try (java.sql.Connection conn = cartDAO.getConnection();
                    java.sql.PreparedStatement ps = conn
                            .prepareStatement("SELECT part_stock FROM Part WHERE part_id = ?")) {
                ps.setInt(1, partId);
                try (java.sql.ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        partStock = rs.getInt("part_stock");
                    }
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            if (partStock <= 0) {
                System.out.println("Error: Out of stock");
                response.getWriter().print("{\"status\":\"out_of_stock\"}");
            } else {
                System.out.println("Error: Failed to add part to cart");
                response.getWriter().print("{\"status\":\"error\"}");
            }
        }
    }
}
