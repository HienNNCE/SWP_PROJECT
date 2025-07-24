/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.CartDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author thien
 */
@WebServlet("/GetCartCountServlet")
public class CartCountServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false); // false: không tạo session nếu chưa có
        Integer userId = (session != null) ? (Integer) session.getAttribute("userId") : null;

        int cartCount = 0;

        if (userId != null) {
            CartDAO cartDAO = new CartDAO();
            Model.Cart cart = cartDAO.getCartDetailByUserId(userId);
            cartCount = (cart != null) ? cart.getCountItem() : 0;
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write("{\"cartCount\":" + cartCount + "}");
    }
}

