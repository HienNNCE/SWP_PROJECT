package Controller;

import DAO.ServiceDAO;
import Model.Service;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.*;

@WebServlet(name = "AdminServiceServlet",
        urlPatterns = {"/admin/service",
            "/admin/service/create",
            "/admin/service/edit",
            "/admin/service/delete",
            "/admin/service/detail"})
@MultipartConfig
public class AdminServiceServlet extends HttpServlet {

    private ServiceDAO serviceDAO;

    @Override
    public void init() throws ServletException {
        serviceDAO = new ServiceDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getServletPath();

        switch (action) {
            case "/admin/service/create":
                showAddForm(request, response);
                break;
            case "/admin/service/edit":
                showEditForm(request, response);
                break;
            case "/admin/service/delete":
                deleteService(request, response);
                break;
            case "/admin/service/detail":
                showDetail(request, response);
                break;
            case "/admin/service":
            default:
                listServices(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getServletPath();

        switch (action) {
            case "/admin/service/create":
                handleAdd(request, response);
                break;
            case "/admin/service/edit":
                handleEdit(request, response);
                break;
        }
    }

    // === LIST ===
    private void listServices(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Service> services = serviceDAO.getAllService();
        request.setAttribute("services", services);
        request.getRequestDispatcher("/admin/service/service-list.jsp").forward(request, response);
    }

    // === ADD FORM ===
    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/admin/service/create-form.jsp").forward(request, response);
    }

    // === HANDLE ADD ===
    private void handleAdd(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        Service service = extractServiceFromRequest(request, null);
        Map<String, String> errors = validateService(service);

        if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);
            request.setAttribute("service", service);
            request.getRequestDispatcher("/admin/service/create-form.jsp").forward(request, response);
            return;
        }

        serviceDAO.createService(service);
        response.sendRedirect(request.getContextPath() + "/admin/service?msg=created");
    }

    // === EDIT FORM ===
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = parseInt(request.getParameter("id"));
        Service service = serviceDAO.getServiceById(id);
        if (service == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        request.setAttribute("service", service);
        request.getRequestDispatcher("/admin/service/edit-form.jsp").forward(request, response);
    }

    // === HANDLE EDIT ===
    private void handleEdit(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        int id = parseInt(request.getParameter("id"));
        Service existingService = serviceDAO.getServiceById(id);

        if (existingService == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        Service service = extractServiceFromRequest(request, existingService.getServiceImg());
        service.setServiceId(id);

        Map<String, String> errors = validateService(service);

        if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);
            request.setAttribute("service", service);
            request.getRequestDispatcher("/admin/service/edit-form.jsp").forward(request, response);
            return;
        }

        serviceDAO.updateService(service);
        response.sendRedirect(request.getContextPath() + "/admin/service?msg=updated");
    }

    // === DELETE ===
    private void deleteService(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = parseInt(request.getParameter("id"));
        serviceDAO.deleteService(id);
        response.sendRedirect(request.getContextPath() + "/admin/service?msg=deleted");
    }

    // === DETAIL ===
    private void showDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = parseInt(request.getParameter("id"));
        Service service = serviceDAO.getServiceById(id);
        if (service == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        request.setAttribute("service", service);
        request.getRequestDispatcher("/admin/service/service-detail.jsp").forward(request, response);
    }

    // === UTILS ===
    private Service extractServiceFromRequest(HttpServletRequest request, String existingImg)
            throws IOException, ServletException {
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        BigDecimal price = parseBigDecimal(request.getParameter("price"));

        String imageName = existingImg;
        jakarta.servlet.http.Part filePart = request.getPart("img");

        if (filePart != null && filePart.getSize() > 0) {
            imageName = UUID.randomUUID() + "_" + filePart.getSubmittedFileName();

            // Save image
            String uploadPath = getServletContext().getRealPath("/asset/img/services");
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

        return new Service(0, name, description, price, LocalDateTime.now(), imageName);
    }

    private Map<String, String> validateService(Service service) {
        Map<String, String> errors = new HashMap<>();
        if (service.getServiceName() == null || service.getServiceName().trim().isEmpty()) {
            errors.put("name", "Name is required.");
        }
        if (service.getServiceDescription() == null || service.getServiceDescription().trim().isEmpty()) {
            errors.put("description", "Description is required.");
        }
        if (service.getServicePrice() == null || service.getServicePrice().compareTo(BigDecimal.ZERO) <= 0) {
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
