package Controller;

import DAO.CarDAO;
import DAO.PartDAO;

import Model.Car;
import util.MenuDataHelper;

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
    private PartDAO partDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        carDAO = new CarDAO();
        partDAO = new PartDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            MenuDataHelper.preloadCarList(request);     
            MenuDataHelper.preloadPartMenu(request);

            List<String> partBrands = partDAO.getAllBrands();
            request.setAttribute("partBrands", partBrands);
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