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
import java.sql.SQLException;

@WebServlet(name = "AdminCarServlet", urlPatterns = {"/admin/car", "/admin/car/add", "/admin/car/edit", "/admin/car/delete"})
public class AdminCarServlet extends HttpServlet {

    private CarDAO carDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        carDAO = new CarDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getServletPath();

        try {
            switch (action) {
                case "/admin/car/add":
                    showAddForm(request, response);
                    break;
                case "/admin/car/edit":
                    showEditForm(request, response);
                    break;
                case "/admin/car/delete":
                    deleteCar(request, response);
                    break;
                case "/admin/car":
                default:
                    listCars(request, response);
                    break;
            }
        } catch (Exception ex) {
            throw new ServletException(ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getServletPath();

        try {
            switch (action) {
                case "/admin/car/add":
                    addCar(request, response);
                    break;
                case "/admin/car/edit":
                    updateCar(request, response);
                    break;
                // Delete will be handled by GET for simplicity in this example
            }
        } catch (Exception ex) {
            throw new ServletException(ex);
        }
    }

    private void listCars(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException {
        List<Car> carList = carDAO.getAllCars();
        request.setAttribute("carList", carList);
        request.getRequestDispatcher("/admin/car.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Forward to a JSP for adding a new car
        request.getRequestDispatcher("/admin/car-form.jsp").forward(request, response); // Need to create car-form.jsp
    }

    private void addCar(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        // Logic to add a new car from form data
        // Redirect back to car list
        response.sendRedirect(request.getContextPath() + "/admin/car");
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        int carId = Integer.parseInt(request.getParameter("id"));
        // Car existingCar = carDAO.getCarById(carId); // Need to implement getCarById
        // request.setAttribute("car", existingCar);
        // Forward to a JSP for editing a car
        request.getRequestDispatcher("/admin/car-form.jsp").forward(request, response); // Need to create car-form.jsp
    }

    private void updateCar(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        // Logic to update an existing car from form data
        // Redirect back to car list
        response.sendRedirect(request.getContextPath() + "/admin/car");
    }

    private void deleteCar(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int carId = Integer.parseInt(request.getParameter("id"));
        // carDAO.deleteCar(carId); // Need to implement deleteCar
        // Redirect back to car list
        response.sendRedirect(request.getContextPath() + "/admin/car");
    }
} 