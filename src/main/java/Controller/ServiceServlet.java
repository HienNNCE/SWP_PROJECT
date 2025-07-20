package Controller;

import DAO.ServiceDAO;
import Model.Service;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet(name = "ServiceServlet", urlPatterns = {
    "/services", // list
    "/services/search", // search
    "/services/filter", // filter
    "/service/detail" // detail
})
public class ServiceServlet extends HttpServlet {

    private ServiceDAO serviceDAO;

    @Override
    public void init() {
        serviceDAO = new ServiceDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getServletPath();

        // Always set serviceTypes for filter display
        List<String> serviceTypes = serviceDAO.getAllServiceTypes();
        request.setAttribute("serviceTypes", serviceTypes);

        switch (action) {
            case "/services/search":
                handleSearch(request, response);
                break;
            case "/services/filter":
                handleFilter(request, response);
                break;
            case "/service/detail":
                showDetail(request, response);
                break;
            case "/services":
            default:
                listServices(request, response);
                break;
        }
    }

    // === LIST ===
    private void listServices(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String serviceType = request.getParameter("serviceType");
        String sort = request.getParameter("sort");
        List<Service> services = serviceDAO.filterServices(serviceType, null, null, sort);
        request.setAttribute("services", services);
        request.getRequestDispatcher("/service-list.jsp").forward(request, response);
    }

    // === SEARCH ===
    private void handleSearch(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        List<Service> services = serviceDAO.searchServiceByName(keyword);
        request.setAttribute("services", services);
        request.getRequestDispatcher("/service-list.jsp").forward(request, response);
    }

    // === FILTER ===
    private void handleFilter(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String serviceType = request.getParameter("serviceType");
        String sort = request.getParameter("sort");
        // You can add priceFrom/priceTo if needed
        List<Service> services = serviceDAO.filterServices(serviceType, null, null, sort);
        request.setAttribute("services", services);
        request.getRequestDispatcher("/service-list.jsp").forward(request, response);
    }

    // === DETAIL ===
    private void showDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Service service = serviceDAO.getServiceById(id);
        if (service == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        request.setAttribute("service", service);
        request.getRequestDispatcher("/service-detail.jsp").forward(request, response);
    }

    // === UTIL ===
    private Double parseDouble(String value) {
        try {
            return (value != null && !value.trim().isEmpty()) ? Double.parseDouble(value) : null;
        } catch (NumberFormatException e) {
            return null;
        }
    }
}
