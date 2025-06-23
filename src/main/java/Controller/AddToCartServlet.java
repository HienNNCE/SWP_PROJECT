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
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
/**
 *
 * @author ALIENWARE
 */
@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
            int cartCount = 0;
            BigDecimal totalPrice = null;
            List<Cart> carts = cDAO.getCartByUserId(userId);
            for (Cart c : carts) {
              cartCount = c.getCountItem();
              totalPrice = c.getCartPrice();
            }
            session.setAttribute("totalPrice", totalPrice);
            System.out.println("Part added successfully. Cart Count: " + cartCount + ", Total Price: " + totalPrice);
            response.getWriter().print("{\"status\":\"success\", \"cartCount\":" + cartCount + ", \"totalPrice\":" + totalPrice + "}");
        } else {
            System.out.println("Error: Failed to add part to cart");
            response.getWriter().print("{\"status\":\"error\"}");
        }
    }
}
