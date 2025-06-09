package Controller;

import DAO.CarDAO;
import Model.Car;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;

@WebServlet(name = "CarImageServlet", urlPatterns = {"/car/image"})
public class CarImageServlet extends HttpServlet {

    private CarDAO carDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        carDAO = new CarDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int carId = Integer.parseInt(request.getParameter("id"));
            byte[] imageData = carDAO.getCarImageById(carId);

            if (imageData != null) {
                response.setContentType("image/jpeg"); // Assuming images are JPEG. Adjust if needed.
                response.setContentLength(imageData.length);
                try (OutputStream out = response.getOutputStream()) {
                    out.write(imageData);
                }
            } else {
                // Handle image not found - could send a default image or a 404
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Image not found");
            }
        } catch (NumberFormatException e) {
            // Handle invalid car ID format
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid car ID");
        } catch (Exception e) {
            e.printStackTrace(); // Log the exception
            // Handle other errors
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading image");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
} 