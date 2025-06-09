package Controller;

import DAO.CarDAO;
import Model.Car;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "CarDetailServlet", urlPatterns = {"/car/detail"})
public class CarDetailServlet extends HttpServlet {

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
            Car car = carDAO.getCarById(carId); // Assuming getCarById exists in CarDAO

            if (car != null) {
                request.setAttribute("car", car);
                request.getRequestDispatcher("/car/car-detail.jsp").forward(request, response);
            } else {
                // Handle car not found, maybe redirect to an error page or car list
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Car not found");
            }
        } catch (NumberFormatException e) {
            // Handle invalid car ID format
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid car ID");
        } catch (Exception e) {
            e.printStackTrace(); // Log the exception
            // Handle other errors
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading car detail");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
} 