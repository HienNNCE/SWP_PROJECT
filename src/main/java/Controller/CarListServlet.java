package Controller;

import DAO.CarDAO;
import Model.Car;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "CarListServlet", urlPatterns = {"/car/list"})
public class CarListServlet extends HttpServlet {

    private CarDAO carDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        carDAO = new CarDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<Car> carList = carDAO.getAllCars();
            request.setAttribute("carList", carList);
            request.getRequestDispatcher("/car/car-list.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace(); // Log the exception
            // Handle the error
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading car list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
} 