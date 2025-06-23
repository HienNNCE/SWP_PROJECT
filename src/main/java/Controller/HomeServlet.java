package Controller;

import DAO.CarDAO;
import Model.Car;
import util.MenuDataHelper;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "HomeServlet", urlPatterns = {"/home"})
public class HomeServlet extends HttpServlet {

    private CarDAO carDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        carDAO = new CarDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            
            jakarta.servlet.http.HttpSession session = request.getSession(false);
            Integer userId = (session != null) ? (Integer) session.getAttribute("userId") : null;
            if (userId != null) {
                DAO.CartDAO cartDAO = new DAO.CartDAO();
                Model.Cart cart = cartDAO.getCartDetailByUserId(userId);
                int cartCount = (cart != null) ? cart.getCountItem() : 0;
                java.math.BigDecimal totalPrice = (cart != null && cart.getCartPrice() != null) ? cart.getCartPrice() : java.math.BigDecimal.ZERO;
                request.setAttribute("cartCount", cartCount);
                request.setAttribute("totalPrice", totalPrice);
            } else {
                request.setAttribute("cartCount", 0);
                request.setAttribute("totalPrice", java.math.BigDecimal.ZERO);
            }

            MenuDataHelper.preloadCarList(request);     
            request.getRequestDispatcher("/home.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading cars");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}