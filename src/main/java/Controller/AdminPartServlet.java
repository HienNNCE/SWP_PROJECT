package Controller;

import DAO.PartDAO;
import Model.Part;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;
import java.math.BigDecimal;
import java.util.*;

@WebServlet(name = "AdminPartServlet", urlPatterns = {
    "/admin/part", "/admin/part/create", "/admin/part/edit", "/admin/part/delete", "/admin/part/detail"
})
@MultipartConfig
public class AdminPartServlet extends HttpServlet {

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
            case "/admin/part/create":
                showAddForm(request, response);
                break;
            case "/admin/part/edit":
                showEditForm(request, response);
                break;
            case "/admin/part/delete":
                deletePart(request, response);
                break;
            case "/admin/part/detail":
                showDetail(request, response);
                break;
            case "/admin/part":
            default:
                listParts(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getServletPath();

        switch (action) {
            case "/admin/part/create":
                handleAdd(request, response);
                break;
            case "/admin/part/edit":
                handleEdit(request, response);
                break;
        }
    }

    // === LIST ===
    private void listParts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        List<Part> parts = (keyword != null && !keyword.trim().isEmpty())
                ? partDAO.searchPartsByName(keyword)
                : partDAO.getAllParts();

        request.setAttribute("parts", parts);
        request.getRequestDispatcher("/admin/part/parts-list.jsp").forward(request, response);
    }

    // === ADD FORM ===
    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("brands", partDAO.getAllBrands());
        request.getRequestDispatcher("/admin/part/create-form.jsp").forward(request, response);
    }

    // === HANDLE ADD ===
    private void handleAdd(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        Part part = extractPartFromRequest(request, null);
        Map<String, String> errors = validatePart(part);

        if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);
            request.setAttribute("oldPart", part);
            request.setAttribute("brands", partDAO.getAllBrands());
            request.getRequestDispatcher("/admin/part/create-form.jsp").forward(request, response);
            return;
        }

        partDAO.createPart(part);
        response.sendRedirect(request.getContextPath() + "/admin/part?msg=created");
    }

    // === EDIT FORM ===
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = parseInt(request.getParameter("id"));
        Part part = partDAO.getPartById(id);
        if (part == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        request.setAttribute("part", part);
        request.setAttribute("brands", partDAO.getAllBrands());
        request.getRequestDispatcher("/admin/part/edit-form.jsp").forward(request, response);
    }

    // === HANDLE EDIT ===
    private void handleEdit(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        int id = parseInt(request.getParameter("id"));
        Part existingPart = partDAO.getPartById(id);

        if (existingPart == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        Part part = extractPartFromRequest(request, existingPart.getPartImg());
        part.setPartId(id);

        Map<String, String> errors = validatePart(part);

        if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);
            request.setAttribute("part", part);
            request.setAttribute("brands", partDAO.getAllBrands());
            request.getRequestDispatcher("/admin/part/edit-form.jsp").forward(request, response);
            return;
        }

        partDAO.updatePart(part);
        response.sendRedirect(request.getContextPath() + "/admin/part?msg=updated");
    }

    // === DELETE ===
    private void deletePart(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = parseInt(request.getParameter("id"));
        partDAO.deletePart(id);
        response.sendRedirect(request.getContextPath() + "/admin/part?msg=deleted");
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
        request.getRequestDispatcher("/admin/part/part-detail.jsp").forward(request, response);
    }

    // === UTILS ===
    private Part extractPartFromRequest(HttpServletRequest request, String existingImg)
            throws IOException, ServletException {
        String name = request.getParameter("name");
        String brand = request.getParameter("brand");
        String carModel = request.getParameter("carModel");
        String description = request.getParameter("description");
        int stock = parseInt(request.getParameter("stock"));
        BigDecimal price = parseBigDecimal(request.getParameter("price"));

        String imageName = existingImg;
        jakarta.servlet.http.Part filePart = request.getPart("img");

        if (filePart != null && filePart.getSize() > 0) {
            imageName = UUID.randomUUID() + "_" + filePart.getSubmittedFileName();

            // ✅ Fixed path
            String uploadPath = getServletContext().getRealPath("/asset/img/parts");
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            try (InputStream input = filePart.getInputStream(); FileOutputStream output = new FileOutputStream(new File(uploadPath, imageName))) {
                byte[] buffer = new byte[1024];
                int bytesRead;
                while ((bytesRead = input.read(buffer)) != -1) {
                    output.write(buffer, 0, bytesRead);
                }
            }
        }

        return new Part(0, name, brand, carModel, description, imageName, stock, price);
    }

    private Map<String, String> validatePart(Part part) {
        Map<String, String> errors = new HashMap<>();
        if (part.getPartName() == null || part.getPartName().trim().isEmpty()) {
            errors.put("name", "Name is required.");
        }
        if (part.getPartBrand() == null || part.getPartBrand().trim().isEmpty()) {
            errors.put("brand", "Brand is required.");
        }
        if (part.getCarModel() == null || part.getCarModel().trim().isEmpty()) {
            errors.put("carModel", "Car model is required.");
        }
        if (part.getPartStock() <= 0) {
            errors.put("stock", "Stock must be greater than 0.");
        }
        if (part.getPartPrice() == null || part.getPartPrice().compareTo(BigDecimal.ZERO) <= 0) {
            errors.put("price", "Price must be greater than 0.");
        }
        return errors;
    }

    private int parseInt(String value) {
        try {
            return Integer.parseInt(value);
        } catch (Exception e) {
            return 0;
        }
    }

    private BigDecimal parseBigDecimal(String value) {
        try {
            return new BigDecimal(value);
        } catch (Exception e) {
            return BigDecimal.ZERO;
        }
    }
}
