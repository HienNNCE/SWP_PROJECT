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

@WebServlet(name = "HomeServlet", urlPatterns = {"/home"})
public class HomeServlet extends HttpServlet {

    private CarDAO carDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        carDAO = new CarDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<Car> latestCars = carDAO.getAllCars();
            request.setAttribute("latestCars", latestCars);
            request.getRequestDispatcher("/home.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace(); // Log the exception
            // Handle the error, maybe forward to an error page
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading cars");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
} 