package Controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

import DAO.CarDAO;
import DAO.OrderDAO;
import DAO.UserDAO;
import Model.Order;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "AdminDashboardServlet", urlPatterns = {"/admin/dashboard" })
public class AdminDashboardServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                HttpSession session = request.getSession();
        try {
            // CarDAO carDAO = new CarDAO();
            // UserDAO userDAO = new UserDAO();
            OrderDAO orderDAO= new OrderDAO();
            //Get data from DAOs
            // int totalCars = carDAO.getTotalCarCount(); // Assuming CarDAO has this method
            // int totalUsers = userDAO.getTotalUserCount();
            // int activeUsers = userDAO.getActiveUserCount();
            int totalOrders = orderDAO.countOrders();
            // BigDecimal totalRevenue = orderDAO.getTotalRevenue();

            // Get latest orders
            //List<Order> latestOrders = orderDAO.getLatestOrders(5); // Get latest 5 orders

            // Set data as request attributes
            // request.setAttribute("totalCars", totalCars);
            // request.setAttribute("totalUsers", totalUsers);
            // request.setAttribute("activeUsers", activeUsers);
            session.setAttribute("totalOrders", totalOrders);
            // request.setAttribute("totalRevenue", totalRevenue);
            //request.setAttribute("latestOrders", latestOrders);

            // Forward to the dashboard JSP
            request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace(); // Log the exception
            // Handle the error
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading dashboard data");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}