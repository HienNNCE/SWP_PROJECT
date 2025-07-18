package Controller;

import DAO.PartDAO;
import Model.Part;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;
import util.MenuDataHelper;

@WebServlet(name = "PartServlet", urlPatterns = {
    "/parts",
    "/parts/search",
    "/parts/filter",
    "/part/detail"
})
public class PartServlet extends HttpServlet {

    private PartDAO partDAO;

    @Override
    public void init() {
        partDAO = new PartDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        MenuDataHelper.preloadCarList(request);
        MenuDataHelper.preloadPartMenu(request);

        String action = request.getServletPath();

        switch (action) {
            case "/parts/search":
                handleSearch(request, response);
                break;
            case "/parts/filter":
                handleFilter(request, response);
                break;
            case "/part/detail":
                showDetail(request, response);
                break;
            case "/parts":
            default:
                listParts(request, response);
                break;
        }
    }

    private void listParts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String brand = request.getParameter("brand");
        String carModel = request.getParameter("carModel");
        String sort = request.getParameter("sort");

        List<Part> parts = partDAO.filterParts(brand, carModel, null, null, null, null, sort);
        List<String> partBrands = partDAO.getAllBrands();
        List<String> carModels = partDAO.getAllCarModels();

        request.setAttribute("parts", parts);
        request.setAttribute("partBrands", partBrands);
        request.setAttribute("carModels", carModels);
        request.setAttribute("activePage", "parts");

        request.getRequestDispatcher("/parts-list.jsp").forward(request, response);
    }

    private void handleSearch(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        String brand = request.getParameter("brand");

        List<Part> parts = partDAO.searchPartsByName(keyword);

        if (brand != null && !brand.trim().isEmpty()) {
            parts = parts.stream()
                    .filter(p -> p.getPartBrand().equalsIgnoreCase(brand))
                    .collect(Collectors.toList());
        }

        List<String> partBrands = partDAO.getAllBrands();
        List<String> carModels = partDAO.getAllCarModels();

        request.setAttribute("parts", parts);
        request.setAttribute("partBrands", partBrands);
        request.setAttribute("carModels", carModels);

        request.setAttribute("paramKeyword", keyword);
        request.setAttribute("paramBrand", brand);

        request.getRequestDispatcher("/parts-list.jsp").forward(request, response);
    }

    private void handleFilter(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        String brand = request.getParameter("brand");
        String carModel = request.getParameter("carModel");
        Double priceFrom = parseDouble(request.getParameter("priceFrom"));
        Double priceTo = parseDouble(request.getParameter("priceTo"));
        Integer stockFrom = parseInt(request.getParameter("stockFrom"));
        Integer stockTo = parseInt(request.getParameter("stockTo"));
        String sort = request.getParameter("sort");

        List<Part> parts = partDAO.filterParts(brand, carModel, priceFrom, priceTo, stockFrom, stockTo, sort);

        if (keyword != null && !keyword.trim().isEmpty()) {
            parts = parts.stream()
                    .filter(p -> p.getPartName().toLowerCase().contains(keyword.toLowerCase()))
                    .collect(Collectors.toList());
        }

        List<String> partBrands = partDAO.getAllBrands();
        List<String> carModels = partDAO.getAllCarModels();

        request.setAttribute("parts", parts);
        request.setAttribute("partBrands", partBrands);
        request.setAttribute("carModels", carModels);
        request.getRequestDispatcher("/parts-list.jsp").forward(request, response);
    }

    private void showDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        MenuDataHelper.preloadCarList(request);
        int id = parseInt(request.getParameter("id"));
        Part part = partDAO.getPartById(id);
        if (part == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        List<Part> relatedParts = partDAO.getRelatedParts(part.getPartBrand(), part.getPartId());

        request.setAttribute("relatedParts", relatedParts);
        request.setAttribute("activePage", "parts");
        request.setAttribute("part", part);
        request.getRequestDispatcher("/part-detail.jsp").forward(request, response);
    }

    private Double parseDouble(String value) {
        try {
            return (value != null && !value.trim().isEmpty()) ? Double.parseDouble(value) : null;
        } catch (NumberFormatException e) {
            return null;
        }
    }

    private Integer parseInt(String value) {
        try {
            return (value != null && !value.trim().isEmpty()) ? Integer.parseInt(value) : null;
        } catch (NumberFormatException e) {
            return null;
        }
    }
}
