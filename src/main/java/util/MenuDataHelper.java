package util;

import DAO.CarDAO;
import DAO.PartDAO;
import Model.Car;
import java.util.List;
import jakarta.servlet.http.HttpServletRequest;

public class MenuDataHelper {
    public static void preloadCarList(HttpServletRequest request) {
        try {
            CarDAO carDAO = new CarDAO();
            List<Car> cars = carDAO.getRandomCars(8);
            request.setAttribute("latestCars", cars);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public static void preloadPartMenu(HttpServletRequest request) {
        try {
            PartDAO partDAO = new PartDAO();
            List<String> partBrands = partDAO.getAllBrands();
            request.setAttribute("partBrands", partBrands);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
