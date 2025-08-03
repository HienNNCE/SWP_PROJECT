package Controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

import DAO.CarDAO;
import DAO.PartDAO;
import DAO.ServiceDAO;
import DAO.UserDAO;
import DAO.OrderDAO;
import DAO.CarAppointmentDAO;
import DAO.ServiceAppointmentDAO;
import DAO.BlogDAO;
import Model.Order;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "StaffDashboardServlet", urlPatterns = {"/staff/dashboard"})
public class StaffDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            CarDAO carDAO = new CarDAO();
            PartDAO partDAO = new PartDAO();
            ServiceDAO serviceDAO = new ServiceDAO();
            UserDAO userDAO = new UserDAO();
            OrderDAO orderDAO = new OrderDAO();
            CarAppointmentDAO carAppointmentDAO = new CarAppointmentDAO();
            ServiceAppointmentDAO serviceAppointmentDAO = new ServiceAppointmentDAO();
            BlogDAO blogDAO = new BlogDAO();

            int totalCars = carDAO.getTotalCarCount();
            int totalParts = partDAO.getAllParts().size();
            int totalServices = serviceDAO.getAllService().size();
            int totalUsers = userDAO.getTotalUserCount();
            int totalOrders = orderDAO.countOrders();
            int totalCarAppointments = carAppointmentDAO.getAll().size();
            int totalServiceAppointments = serviceAppointmentDAO.getAll().size();
            int totalBlogs = blogDAO.getAllBlogs().size();
            int totalCarBrands = carDAO.getAllBrands().size();
            int totalCarModels = carDAO.getAllCars().stream().map(c -> c.getModel()).distinct().toArray().length;
            int totalPartBrands = partDAO.getAllBrands().size();
            int totalServiceTypes = serviceDAO.getAllServiceTypes().size();

            request.setAttribute("totalCars", totalCars);
            request.setAttribute("totalParts", totalParts);
            request.setAttribute("totalServices", totalServices);
            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("totalOrders", totalOrders);
            request.setAttribute("totalCarAppointments", totalCarAppointments);
            request.setAttribute("totalServiceAppointments", totalServiceAppointments);
            request.setAttribute("totalBlogs", totalBlogs);
            request.setAttribute("totalCarBrands", totalCarBrands);
            request.setAttribute("totalCarModels", totalCarModels);
            request.setAttribute("totalPartBrands", totalPartBrands);
            request.setAttribute("totalServiceTypes", totalServiceTypes);

            request.getRequestDispatcher("/staff/dashboard.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading dashboard data");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
