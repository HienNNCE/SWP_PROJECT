package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;


public class CartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect("login.jsp"); // Nếu chưa đăng nhập thì chuyển đến login
            return;
        }

        // Dữ liệu cartItems và totalPrice đã được xử lý từ trước (VD: trong AddToCartServlet)
        // => chỉ cần forward sang cart.jsp để hiển thị
        request.getRequestDispatcher("/cart.jsp").forward(request, response);
    }
}
