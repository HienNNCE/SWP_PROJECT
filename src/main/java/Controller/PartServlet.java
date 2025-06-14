package Controller;

import DAO.PartDAO;
import Model.Part;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;

@WebServlet(name = "PartServlet", urlPatterns = {
    "/parts",             // list
    "/parts/search",      // search
    "/parts/filter",      // filter
    "/part/detail"        // detail
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

    // === LIST ===
    private void listParts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Part> parts = partDAO.getAllParts();
        List<String> brands = partDAO.getAllBrands();

        request.setAttribute("parts", parts);
        request.setAttribute("brands", brands);
        request.getRequestDispatcher("/part/parts-list.jsp").forward(request, response);
    }

    // === SEARCH ===
    private void handleSearch(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = request.getParameter("keyword");

        List<Part> parts = partDAO.searchPartsByName(keyword);
        List<String> brands = partDAO.getAllBrands();

        request.setAttribute("parts", parts);
        request.setAttribute("brands", brands);
        request.getRequestDispatcher("/part/parts-list.jsp").forward(request, response);
    }

    // === FILTER ===
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

        List<String> brands = partDAO.getAllBrands();

        request.setAttribute("parts", parts);
        request.setAttribute("brands", brands);
        request.getRequestDispatcher("/part/parts-list.jsp").forward(request, response);
    }

    // === DETAIL ===
    private void showDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = parseInt(request.getParameter("id"));
        Part part = partDAO.getPartById(id);
        if (part == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        request.setAttribute("part", part);
        request.getRequestDispatcher("/part/part-detail.jsp").forward(request, response);
    }

    // === UTIL ===
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
