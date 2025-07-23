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

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        String partIdStr = request.getParameter("id");
        if (partIdStr == null || !partIdStr.matches("\\d+")) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Part id incorrect.");
            return;
        }
        int partId = Integer.parseInt(partIdStr);
        CartDAO cartDAO = new CartDAO();

        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login.jsp");
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
            response.getWriter().print(
                    "{\"status\":\"success\", \"cartCount\":" + cartCount + ", \"totalPrice\":" + totalPrice + ", \"partStock\":" + partStock +"}");
        } else {       
                response.getWriter().print("{\"status\":\"out_of_stock\"}");       
        }
    }
}
