/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller;

import jakarta.mail.Part;
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
import java.util.ArrayList;
import java.util.List;


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
public class AddToCartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("Request received!");

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            System.out.println("Error: userId is null. Redirecting to login.");
            response.sendRedirect("login"); // Chuyển hướng về trang đăng nhập
            return;
        }

        String gameIdStr = request.getParameter("id");
        if (gameIdStr == null || !gameIdStr.matches("\\d+")) {
            System.out.println("Error: Invalid gameId: " + gameIdStr);
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Game id incorrect.");
            return;
        }

        int gameId = Integer.parseInt(gameIdStr);
        System.out.println("userId: " + userId + ", gameId: " + gameId);

        CartDAO cartDAO = new CartDAO();

        //boolean exists = cartDAO.isGameInCart(userId, gameId);
//        if (exists) {
//            System.out.println("Game already in cart");
//            response.getWriter().print("{\"status\":\"exists\"}");
//            return;
//        }


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

