package Controller;

import DAO.CarDAO;
import DAO.CartDAO;
import DAO.PartDAO;

import Model.Car;
import util.MenuDataHelper;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "HomeServlet", urlPatterns = {"/home"})
public class HomeServlet extends HttpServlet {

    private CarDAO carDAO;
    private PartDAO partDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        carDAO = new CarDAO();
        partDAO = new PartDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (session != null) ? (Integer) session.getAttribute("userId") : null;
            if (userId != null) {
                DAO.CartDAO cartDAO = new DAO.CartDAO();
                Model.Cart cart = cartDAO.getCartDetailByUserId(userId);
                int cartCount = (cart != null) ? cart.getCountItem() : 0;
                java.math.BigDecimal totalPrice = (cart != null && cart.getCartPrice() != null) ? cart.getCartPrice() : java.math.BigDecimal.ZERO;
                session.setAttribute("cartCount", cartCount);
                session.setAttribute("totalPrice", totalPrice);
                
                //Test cart count and total price
                System.out.println("Cart count: " + cartCount);
                System.out.println("Total price: " + totalPrice);
            } else {
                request.setAttribute("cartCount", 0);
                request.setAttribute("totalPrice", java.math.BigDecimal.ZERO);
            }
        try {
            MenuDataHelper.preloadCarList(request);     
            MenuDataHelper.preloadPartMenu(request);
            List<String> partBrands = partDAO.getAllBrands();
            request.setAttribute("partBrands", partBrands);
            request.getRequestDispatcher("/home.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace(); // Log the exception
            // Handle the error, maybe forward to an error page
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading cars");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
} 