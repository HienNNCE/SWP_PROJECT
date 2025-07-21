package Controller;

import DAO.ServiceDAO;
import DAO.CarDAO;
import DAO.PartDAO;
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
    private CarDAO carDAO;
    private PartDAO partDAO;

    @Override
    public void init() {
        serviceDAO = new ServiceDAO();
        carDAO = new CarDAO();
        partDAO = new PartDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getServletPath();

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
        List<Service> services = serviceDAO.getAllService();
        request.setAttribute("services", services);
        // Bổ sung biến cho navbar
        List<String> carBrands = carDAO.getAllBrands();
        List<String> carCategories = carDAO.getAllCategories();
        List<Model.Car> latestCars = carDAO.getRandomCars(8);
        if (latestCars == null || latestCars.isEmpty()) {
            latestCars = carDAO.getAllCars();
        }
        List<String> partBrands = partDAO.getAllBrands();
        request.setAttribute("carBrands", carBrands);
        request.setAttribute("carCategories", carCategories);
        request.setAttribute("latestCars", latestCars);
        request.setAttribute("partBrands", partBrands);
        request.getRequestDispatcher("/service-list.jsp").forward(request, response);
    }

    // === SEARCH ===
    private void handleSearch(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        List<Service> services = serviceDAO.searchServiceByName(keyword);
        request.setAttribute("services", services);
        // Bổ sung biến cho navbar
        List<String> carBrands = carDAO.getAllBrands();
        List<String> carCategories = carDAO.getAllCategories();
        List<Model.Car> latestCars = carDAO.getRandomCars(8);
        if (latestCars == null || latestCars.isEmpty()) {
            latestCars = carDAO.getAllCars();
        }
        List<String> partBrands = partDAO.getAllBrands();
        request.setAttribute("carBrands", carBrands);
        request.setAttribute("carCategories", carCategories);
        request.setAttribute("latestCars", latestCars);
        request.setAttribute("partBrands", partBrands);
        request.getRequestDispatcher("/service-list.jsp").forward(request, response);
    }

    // === FILTER ===
    private void handleFilter(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        String serviceType = request.getParameter("serviceType");
        Double priceFrom = parseDouble(request.getParameter("priceFrom"));
        Double priceTo = parseDouble(request.getParameter("priceTo"));

        // Filter services based on price and keyword
        List<Service> services = serviceDAO.filterServices(keyword, BigDecimal.ZERO, BigDecimal.ZERO, keyword);

        // Apply additional filtering if keyword is provided
        if (keyword != null && !keyword.trim().isEmpty()) {
            services = services.stream()
                    .filter(s -> s.getServiceName().toLowerCase().contains(keyword.toLowerCase()))
                    .collect(Collectors.toList());
        }

        request.setAttribute("services", services);
        // Bổ sung biến cho navbar
        List<String> carBrands = carDAO.getAllBrands();
        List<String> carCategories = carDAO.getAllCategories();
        List<Model.Car> latestCars = carDAO.getRandomCars(8);
        if (latestCars == null || latestCars.isEmpty()) {
            latestCars = carDAO.getAllCars();
        }
        List<String> partBrands = partDAO.getAllBrands();
        request.setAttribute("carBrands", carBrands);
        request.setAttribute("carCategories", carCategories);
        request.setAttribute("latestCars", latestCars);
        request.setAttribute("partBrands", partBrands);
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
